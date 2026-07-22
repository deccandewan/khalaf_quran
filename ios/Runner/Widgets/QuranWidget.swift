import WidgetKit
import SwiftUI

// ─── Prayer Widgets ───────────────────────────────────────────────────────────

struct QuranPrayerEntry: TimelineEntry {
    let date: Date
    let prayers: [PrayerTime]
    let sunrise: String
    let sunset: String
    let hijriDate: String
}

struct QuranPrayerProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuranPrayerEntry {
        QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--", hijriDate: "---")
    }

    func getSnapshot(in context: Context, completion: @escaping (QuranPrayerEntry) -> Void) {
        let entry = QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--", hijriDate: "---")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuranPrayerEntry>) -> Void) {
        if let coords = WidgetData.getCoordinates() {
            WidgetData.fetchPrayers(lat: coords.lat, lon: coords.lon) { prayers, sunrise, sunset in
                let hijri = getHijriDate()
                let entry = QuranPrayerEntry(
                    date: Date(),
                    prayers: prayers ?? [],
                    sunrise: sunrise ?? "--:--",
                    sunset: sunset ?? "--:--",
                    hijriDate: hijri
                )
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
                completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
            }
        } else {
            let entry = QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--", hijriDate: "---")
            completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(3600))))
        }
    }

    private func getHijriDate() -> String {
        let calendar = Calendar(identifier: .islamic)
        let components = calendar.dateComponents([.day, .month, .year], from: Date())
        return "\(components.day ?? 0) \(components.month ?? 0) \(components.year ?? 0) AH"
    }
}

struct QuranSmallWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.quranwidget.small"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuranPrayerProvider()) { entry in
            QuranWidgetView(
                prayers: entry.prayers,
                sunrise: entry.sunrise,
                sunset: entry.sunset,
                hijriDate: entry.hijriDate,
                isLarge: false
            )
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
            QuranWidgetView(
                prayers: entry.prayers,
                sunrise: entry.sunrise,
                sunset: entry.sunset,
                hijriDate: entry.hijriDate,
                isLarge: true
            )
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
            // Refresh every 4 hours
            let nextUpdate = Calendar.current.date(byAdding: .hour, value: 4, to: Date())!
            completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
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
