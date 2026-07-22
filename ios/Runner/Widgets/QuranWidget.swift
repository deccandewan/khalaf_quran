import WidgetKit
import SwiftUI

struct QuranWidgetEntry: TimelineEntry {
    let date: Date
    let prayers: [PrayerTime]
    let sunrise: String
    let sunset: String
    let hijriDate: String
}

struct QuranWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuranWidgetEntry {
        QuranWidgetEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--", hijriDate: "---")
    }

    func getSnapshot(in context: Context, completion: @escaping (QuranWidgetEntry) -> Void) {
        let entry = QuranWidgetEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--", hijriDate: "---")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuranWidgetEntry>) -> Void) {
        if let coords = WidgetData.getCoordinates() {
            WidgetData.fetchPrayers(lat: coords.lat, lon: coords.lon) { prayers, sunrise, sunset in
                let hijri = getHijriDate()
                let entry = QuranWidgetEntry(
                    date: Date(),
                    prayers: prayers ?? [],
                    sunrise: sunrise ?? "--:--",
                    sunset: sunset ?? "--:--",
                    hijriDate: hijri
                )
                // Update every 30 minutes
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
        } else {
            let entry = QuranWidgetEntry(date: Date(), prayers: [], sunrise: "--:--", sunset: "--:--", hijriDate: "---")
            completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(3600))))
        }
    }

    private func getHijriDate() -> String {
        let calendar = Calendar(identifier: .islamic)
        let components = calendar.dateComponents([.day, .month, .year], from: Date())
        return "\(components.day ?? 0) \(components.month ?? 0) \(components.year ?? 0) AH"
    }
}

@main
struct QuranWidget: Widget {
    let kind: String = "com.abuhashim.khalafquran.quranwidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuranWidgetProvider()) { entry in
            QuranWidgetView(
                prayers: entry.prayers,
                sunrise: entry.sunrise,
                sunset: entry.sunset,
                hijriDate: entry.hijriDate,
                isLarge: true // The system handles size, but we can use entry data
            )
        }
        .configurationDisplayName("Quran Prayers")
        .description("View daily prayer times and Hijri date.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
