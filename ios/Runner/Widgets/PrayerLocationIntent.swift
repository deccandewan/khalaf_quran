import WidgetKit
import AppIntents
import CoreLocation

struct CityEntity: AppEntity, Identifiable {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "City"
    static var defaultQuery = CityQuery()

    let id: String       // "CityName|Country"
    let name: String
    let country: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)", subtitle: "\(country)")
    }
}

struct CityQuery: EntityQuery, EntityStringQuery {
    func entities(for identifiers: [CityEntity.ID]) async throws -> [CityEntity] {
        identifiers.compactMap { id in
            let parts = id.components(separatedBy: "|")
            guard parts.count == 2 else { return nil }
            return CityEntity(id: id, name: parts[0], country: parts[1])
        }
    }

    func suggestedEntities() async throws -> [CityEntity] {
        [
            CityEntity(id: "Mecca|Saudi Arabia", name: "Mecca", country: "Saudi Arabia"),
            CityEntity(id: "Medina|Saudi Arabia", name: "Medina", country: "Saudi Arabia"),
            CityEntity(id: "Hyderabad|India", name: "Hyderabad", country: "India"),
        ]
    }

    func entities(matching string: String) async throws -> [CityEntity] {
        guard !string.trimmingCharacters(in: .whitespaces).isEmpty else {
            return try await suggestedEntities()
        }
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(string)
        var seen = Set<String>()
        var results: [CityEntity] = []
        for placemark in placemarks {
            guard let locality = placemark.locality, let country = placemark.country else { continue }
            let key = "\(locality)|\(country)"
            if !seen.contains(key) {
                seen.insert(key)
                results.append(CityEntity(id: key, name: locality, country: country))
            }
        }
        return results
    }

    func defaultResult() async -> CityEntity? {
        CityEntity(id: "Mecca|Saudi Arabia", name: "Mecca", country: "Saudi Arabia")
    }
}

struct PrayerLocationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Prayer Location"
    static var description = IntentDescription("Choose the city used to calculate prayer times.")

    @Parameter(title: "City")
    var city: CityEntity
}
