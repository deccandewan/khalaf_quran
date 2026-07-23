import WidgetKit
import AppIntents

struct PrayerLocationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Prayer Location"
    static var description = IntentDescription("Choose the city used to calculate prayer times.")

    @Parameter(title: "City", default: "Mecca")
    var city: String

    @Parameter(title: "Country", default: "Saudi Arabia")
    var country: String
}
