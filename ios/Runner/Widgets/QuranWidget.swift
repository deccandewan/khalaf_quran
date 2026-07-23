import WidgetKit
import SwiftUI
import AppIntents

// ─── Helpers ──────────────────────────────────────────────────────────────────

private let islamicMonthNames = [
    "Muharram", "Safar", "Rabi al-Awwal", "Rabi al-Thani",
    "Jumada al-Awwal", "Jumada al-Thani", "Rajab", "Sha'ban",
    "Ramadan", "Shawwal", "Dhu al-Qi'dah", "Dhu al-Hijjah"
]

/// Computes the Hijri date, rolling to the next Hijri day at Maghrib (sunset)
/// rather than at midnight. `sunsetString` should be the "HH:mm" sunset time
/// for `now`'s Gregorian day, as returned by the prayer API; pass nil when
/// unavailable (e.g. placeholder/snapshot) and this falls back to a
/// midnight-based Hijri date for that call only.
private func getHijriComponents(now: Date = Date(), sunsetString: String? = nil) -> (day: String, month: String, year: String) {
    let cal = Calendar(identifier: .islamicUmmAlQura)

    var baseDate = now
    if let sunsetString,
       let sunsetToday = parseTimeString(sunsetString, baseDay: now),
       now >= sunsetToday {
        // Past Maghrib: the Hijri day has already advanced even though the
        // Gregorian clock hasn't hit midnight yet.
        baseDate = Calendar.current.date(byAdding: .day, value: 1, to: now) ?? now
    }

    let c = cal.dateComponents([.day, .month, .year], from: baseDate)
    let day = "\(c.day ?? 1)"
    let monthIdx = (c.month ?? 1) - 1
    let month = islamicMonthNames.indices.contains(monthIdx) ? islamicMonthNames[monthIdx] : "---"
    let year = "\(c.year ?? 1446) AH"
    return (day, month, year)
}

/// Parses "HH:mm" (optionally with trailing " AM"/" PM" or extra text) into a Date on the given base day.
private func parseTimeString(_ raw: String, baseDay: Date = Date()) -> Date? {
    let clean = raw.trimmingCharacters(in: .whitespaces)
        .components(separatedBy: " ").first ?? raw
    let parts = clean.split(separator: ":")
    guard parts.count >= 2,
          let h = Int(parts[0]),
          let m = Int(parts[1]),
          (0...23).contains(h),
          (0...59).contains(m) else { return nil }
    var comps = Calendar.current.dateComponents([.year, .month, .day], from: baseDay)
    comps.hour = h
    comps.minute = m
    comps.second = 0
    return Calendar.current.date(from: comps)
}

/// Given the day's prayer list and "now", returns the next prayer's index and its absolute Date
/// (rolling into tomorrow's Fajr if all of today's prayers have passed).
private func resolveNextPrayer(_ prayers: [PrayerTime], now: Date) -> (index: Int, date: Date)? {
    guard !prayers.isEmpty else { return nil }

    // Try to find the first prayer today that's still in the future.
    for (i, p) in prayers.enumerated() {
        if let t = parseTimeString(p.time, baseDay: now), t > now {
            return (i, t)
        }
    }

    // Everything today has passed — roll to tomorrow's first prayer (typically Fajr).
    if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now),
       let t = parseTimeString(prayers[0].time, baseDay: tomorrow) {
        return (0, t)
    }

    return nil
}

private func countdownString(until target: Date, now: Date) -> String {
    let diff = Int(target.timeIntervalSince(now))
    guard diff > 0 else { return "--:--" }
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
    let nextPrayerIndex: Int?
    /// Absolute target time of the next prayer. Prefer rendering this in the
    /// view with `Text(nextPrayerDate, style: .relative)` / `.timer` so the
    /// countdown ticks live in the UI instead of relying on `countdown`,
    /// which is only as fresh as the last timeline entry.
    let nextPrayerDate: Date?
}

struct QuranPrayerProvider: AppIntentTimelineProvider {
    typealias Intent = PrayerLocationIntent
    typealias Entry = QuranPrayerEntry

    func placeholder(in context: Context) -> QuranPrayerEntry {
        QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--",
                         hijriDay: "15", hijriMonth: "Muharram", hijriYear: "1446 AH",
                         countdown: "2h 30m", nextPrayerName: "Asr", nextPrayerIndex: nil,
                         nextPrayerDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date()))
    }

    func snapshot(for configuration: PrayerLocationIntent, in context: Context) async -> QuranPrayerEntry {
        // No sunset data yet at this point, so this falls back to a
        // midnight-based Hijri date for the snapshot only.
        let h = getHijriComponents()
        return QuranPrayerEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--",
                                hijriDay: h.day, hijriMonth: h.month, hijriYear: h.year,
                                countdown: "--:--", nextPrayerName: "---", nextPrayerIndex: nil,
                                nextPrayerDate: nil)
    }

    /// Builds one entry for "now" plus one entry at every remaining prayer
    /// boundary (today's remaining prayers + tomorrow's Fajr). WidgetKit
    /// switches between pre-scheduled entries at their exact timestamps for
    /// free — this does NOT consume the OS reload budget the way requesting
    /// a fresh timeline every minute does. Reloading every minute exhausts
    /// iOS's daily widget refresh budget within the hour, after which the
    /// system silently stops honoring reload requests and the widget freezes
    /// on stale data — that was the root cause of the widget "randomly"
    /// appearing to stop updating.
    private func makeEntry(now: Date, list: [PrayerTime], sunrise: String?, sunset: String?,
                           resolved: (index: Int, date: Date)) -> QuranPrayerEntry {
        let h = getHijriComponents(now: now, sunsetString: sunset)
        let cd = countdownString(until: resolved.date, now: now)
        let nextName = list.indices.contains(resolved.index) ? list[resolved.index].name : "---"
        return QuranPrayerEntry(
            date: now,
            prayers: list,
            sunrise: sunrise ?? "--:--",
            sunset: sunset ?? "--:--",
            hijriDay: h.day,
            hijriMonth: h.month,
            hijriYear: h.year,
            countdown: cd,
            nextPrayerName: nextName,
            nextPrayerIndex: resolved.index,
            nextPrayerDate: resolved.date
        )
    }

    func timeline(for configuration: PrayerLocationIntent, in context: Context) async -> Timeline<QuranPrayerEntry> {
        await withCheckedContinuation { continuation in
            WidgetData.fetchPrayers(city: configuration.city.name, country: configuration.city.country) { prayers, sunrise, sunset in
                let list = prayers ?? []
                let now = Date()

                guard !list.isEmpty else {
                    let h = getHijriComponents(now: now, sunsetString: sunset)
                    let entry = QuranPrayerEntry(date: now, prayers: [], sunrise: sunrise ?? "--:--",
                                                  sunset: sunset ?? "--:--", hijriDay: h.day,
                                                  hijriMonth: h.month, hijriYear: h.year,
                                                  countdown: "--:--", nextPrayerName: "---",
                                                  nextPrayerIndex: nil, nextPrayerDate: nil)
                    // No data yet (e.g. network hiccup) — retry sooner, but
                    // still nowhere near budget-exhausting frequency.
                    let retry = Calendar.current.date(byAdding: .minute, value: 15, to: now) ?? now.addingTimeInterval(900)
                    continuation.resume(returning: Timeline(entries: [entry], policy: .after(retry)))
                    return
                }

                var entries: [QuranPrayerEntry] = []

                // Entry reflecting the current moment.
                if let resolvedNow = resolveNextPrayer(list, now: now) {
                    entries.append(makeEntry(now: now, list: list, sunrise: sunrise, sunset: sunset, resolved: resolvedNow))
                }

                // One entry exactly at each remaining prayer time today, so the
                // "next prayer" pointer flips the instant a prayer starts.
                for p in list {
                    if let t = parseTimeString(p.time, baseDay: now), t > now,
                       let resolvedAtT = resolveNextPrayer(list, now: t) {
                        entries.append(makeEntry(now: t, list: list, sunrise: sunrise, sunset: sunset, resolved: resolvedAtT))
                    }
                }

                // And tomorrow's prayer boundaries, so the widget cycles
                // seamlessly through tomorrow's schedule without sitting
                // stale after today's Isha passes.
                if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now) {
                    for p in list {
                        if let t = parseTimeString(p.time, baseDay: tomorrow),
                           let resolvedAtT = resolveNextPrayer(list, now: t) {
                            entries.append(makeEntry(now: t, list: list, sunrise: sunrise, sunset: sunset, resolved: resolvedAtT))
                        }
                    }
                }

                entries.sort { $0.date < $1.date }

                // Ask WidgetKit for a full data refresh (new prayer times,
                // in case location/date changed) well after tomorrow's Fajr
                // entry has already been scheduled above.
                let refreshAfter = Calendar.current.date(byAdding: .hour, value: 20, to: now) ?? now.addingTimeInterval(20 * 3600)
                continuation.resume(returning: Timeline(entries: entries, policy: .after(refreshAfter)))
            }
        }
    }
}

struct QuranSmallWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.quranwidget.small"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: PrayerLocationIntent.self, provider: QuranPrayerProvider()) { entry in
            QuranWidgetView(entry: entry, isLarge: false)
        }
        .configurationDisplayName("Prayer Times (Small)")
        .description("Next prayer and Hijri date.")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

struct QuranLargeWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.quranwidget.large"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: PrayerLocationIntent.self, provider: QuranPrayerProvider()) { entry in
            QuranWidgetView(entry: entry, isLarge: true)
        }
        .configurationDisplayName("Prayer Times (Large)")
        .description("Full daily prayer schedule.")
        .supportedFamilies([.systemLarge])
        .contentMarginsDisabled()
    }
}

// ─── Ayah Widget ──────────────────────────────────────────────────────────────

struct AyahWidgetEntry: TimelineEntry {
    let date: Date
    let ayah: AyahData?
}

struct AyahWidgetProvider: AppIntentTimelineProvider {
    typealias Intent = AyahLanguageIntent
    typealias Entry = AyahWidgetEntry

    func placeholder(in context: Context) -> AyahWidgetEntry {
        AyahWidgetEntry(date: Date(), ayah: nil)
    }

    func snapshot(for configuration: AyahLanguageIntent, in context: Context) async -> AyahWidgetEntry {
        AyahWidgetEntry(date: Date(), ayah: nil)
    }

    func timeline(for configuration: AyahLanguageIntent, in context: Context) async -> Timeline<AyahWidgetEntry> {
        await withCheckedContinuation { continuation in
            WidgetData.fetchRandomAyah(edition: configuration.language.rawValue) { ayah in
                let entry = AyahWidgetEntry(date: Date(), ayah: ayah)
                let next = Calendar.current.date(byAdding: .hour, value: 4, to: Date()) ?? Date().addingTimeInterval(4 * 3600)
                continuation.resume(returning: Timeline(entries: [entry], policy: .after(next)))
            }
        }
    }
}

struct QuranAyahWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.ayahwidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: AyahLanguageIntent.self, provider: AyahWidgetProvider()) { entry in
            QuranAyahWidgetView(ayah: entry.ayah)
        }
        .configurationDisplayName("Ayah of the Day")
        .description("A random Ayah from the Holy Quran.")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
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
