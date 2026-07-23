import WidgetKit
import AppIntents

enum AyahLanguage: String, AppEnum {
    case arabic = "quran-uthmani"
    case english = "en.sahih"
    case urdu = "ur.jalandhry"

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Language"
    static var caseDisplayRepresentations: [AyahLanguage: DisplayRepresentation] = [
        .arabic: "Arabic",
        .english: "English",
        .urdu: "Urdu"
    ]
}

struct AyahLanguageIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Ayah Language"
    static var description = IntentDescription("Choose the language for the daily Ayah.")

    @Parameter(title: "Language", default: .arabic)
    var language: AyahLanguage
}
