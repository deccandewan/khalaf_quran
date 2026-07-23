import WidgetKit
import SwiftUI

// ─── Helpers ──────────────────────────────────────────────────────────────────

private let islamicMonthNames = [
    "Muharram", "Safar", "Rabi al-Awwal", "Rabi al-Thani",
    "Jumada al-Awwal", "Jumada al-Thani", "Rajab", "Sha'ban",
    "Ramadan", "Shawwal", "Dhu al-Qi'dah", "Dhu al-Hijjah"
]

private func getHijriComponents() -> (day: String, month: String, year: String) {
    let cal = Calendar(identifier: .islamicUmmAlQura)
    let c = cal.dateComponents([.day, .month, .year], from: Date())
    let day = "\(c.day ?? 1)"
    let monthIdx = (c.month ?? 1) - 1
    let month = islamicMonthNames.indices.contains(monthIdx) ? islamicMonthNames[monthIdx] : "---"
    let year = "\(c.year ?? 1446) AH"
    return (day, month, year)
}

private func parseTimeString(_ raw: String) -> Date? {
    let clean = raw.components(separatedBy: " ").first ?? raw
    let parts = clean.split(separator: ":")
    guard parts.count >= 2,
          let h = Int(parts[0]),
          let m = Int(parts[1]) else { return nil }
    var comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    comps.hour = h
    comps.minute = m
    comps.second = 0
    return Calendar.current.date(from: comps)
}

private func countdownString(to prayerTime: String) -> String {
    guard let target = parseTimeString(prayerTime), target > Date() else { return "--:--" }
    let diff = Int(target.timeIntervalSince(Date()))
    let h = diff / 3600
    let m = (diff % 3600) / 60
    if h > 0 { return "\(h)h \(m)m" }
    return "\(m)m"
}

// ─── Prayer Entry & Provider ──────────────────────────────────────────────────

struct QuranPrayerEntry: TimelineEntry {
    let date: Date
    let prayers: [PrayerTime]
    let sunrise: String
    let sunset: String
    let hijriDay: String
    let hijriMonth: String
    let hijriYear: String
    let countdown: String
    let nextPrayerName: String
}

struct QuranPrayerProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuranPrayerEntry {
        QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--",
                         hijriDay: "15", hijriMonth: "Muharram", hijriYear: "1446 AH",
                         countdown: "2h 30m", nextPrayerName: "Asr")
    }

    func getSnapshot(in context: Context, completion: @escaping (QuranPrayerEntry) -> Void) {
        let h = getHijriComponents()
        completion(QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--",
                                    hijriDay: h.day, hijriMonth: h.month, hijriYear: h.year,
                                    countdown: "--:--", nextPrayerName: "---"))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuranPrayerEntry>) -> Void) {
        guard let coords = WidgetData.getCoordinates() else {
            let h = getHijriComponents()
            let entry = QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--",
                                         hijriDay: h.day, hijriMonth: h.month, hijriYear: h.year,
                                         countdown: "--:--", nextPrayerName: "---")
            completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(3600))))
            return
        }

        WidgetData.fetchPrayers(lat: coords.lat, lon: coords.lon) { prayers, sunrise, sunset in
            let h = getHijriComponents()
            let next = prayers?.first(where: { $0.isNext })
            let cd = next.map { countdownString(to: $0.time) } ?? "--:--"
            let entry = QuranPrayerEntry(
                date: Date(),
                prayers: prayers ?? [],
                sunrise: sunrise ?? "--:--",
                sunset: sunset ?? "--:--",
                hijriDay: h.day,
                hijriMonth: h.month,
                hijriYear: h.year,
                countdown: cd,
                nextPrayerName: next?.name ?? "---"
            )
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
            completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
        }
    }
}

// ─── Prayer Widgets ───────────────────────────────────────────────────────────

struct QuranSmallWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.quranwidget.small"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuranPrayerProvider()) { entry in
            QuranWidgetView(entry: entry, isLarge: false)
        }
        .configurationDisplayName("Prayer Times (Small)")
        .description("Next prayer and Hijri date.")
        .supportedFamilies([.systemSmall])
    }
}

struct QuranLargeWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.quranwidget.large"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuranPrayerProvider()) { entry in
            QuranWidgetView(entry: entry, isLarge: true)
        }
        .configurationDisplayName("Prayer Times (Large)")
        .description("Full daily prayer schedule.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

// ─── Ayah Widget ──────────────────────────────────────────────────────────────

struct AyahWidgetEntry: TimelineEntry {
    let date: Date
    let ayah: AyahData?
}

struct AyahWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> AyahWidgetEntry {
        AyahWidgetEntry(date: Date(), ayah: nil)
    }
    func getSnapshot(in context: Context, completion: @escaping (AyahWidgetEntry) -> Void) {
        completion(AyahWidgetEntry(date: Date(), ayah: nil))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<AyahWidgetEntry>) -> Void) {
        WidgetData.fetchRandomAyah { ayah in
            let entry = AyahWidgetEntry(date: Date(), ayah: ayah)
            let next = Calendar.current.date(byAdding: .hour, value: 4, to: Date())!
            completion(Timeline(entries: [entry], policy: .after(next)))
        }
    }
}

struct QuranAyahWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.ayahwidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AyahWidgetProvider()) { entry in
            QuranAyahWidgetView(ayah: entry.ayah)
        }
        .configurationDisplayName("Ayah of the Day")
        .description("A random Ayah from the Holy Quran.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// ─── Main Bundle ──────────────────────────────────────────────────────────────

@main
struct QuranWidgetBundle: WidgetBundle {
    var body: some Widget {
        QuranSmallWidget()
        QuranLargeWidget()
        QuranAyahWidget()
    }
}
