import Foundation
import SwiftUI

struct PrayerTime {
    let name: String
    let time: String
    let isNext: Bool
}

struct AyahData {
    let text: String
    let surah: String
    let ayahNum: Int
}

struct WidgetData {
    static let appGroupId = "com.abuhashim.khalafquran"

    static func getCoordinates() -> (lat: String, lon: String)? {
        let defaults = UserDefaults(suiteName: appGroupId)
        let lat = defaults?.string(forKey: "widget_latitude")
        let lon = defaults?.string(forKey: "widget_longitude")
        if let lat = lat, let lon = lon {
            return (lat, lon)
        }
        return nil
    }

    static func fetchPrayers(lat: String, lon: String, completion: @escaping (([PrayerTime]?, String?, String?) -> Void)) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())

        if let cached = UserDefaults(suiteName: appGroupId)?.data(forKey: "cached_prayers_\(today)"),
           let decoded = try? JSONDecoder().decode([PrayerTime].self, from: cached) {
            completion(decoded, UserDefaults(suiteName: appGroupId)?.string(forKey: "sunrise_\(today)"), UserDefaults(suiteName: appGroupId)?.string(forKey: "sunset_\(today)"))
            return
        }

        let calendar = Calendar.current
        let month = calendar.component(.month, from: Date())
        let year = calendar.component(.year, from: Date())

        let urlString = "https://api.aladhan.com/v1/calendar/\(year)/\(month)?latitude=\(lat)&longitude=\(lon)&method=2"
        guard let url = URL(string: urlString) else {
            completion(nil, nil, nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, nil, nil)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let dataArray = json?["data"] as? [[String: Any]] ?? []

                let todayEntry = dataArray.first { entry in
                    if let date = entry["date"] as? [String: Any],
                       let greg = date["gregorian"] as? [String: Any],
                       let dateStr = greg["date"] as? String {
                        return dateStr == today
                    }
                    return false
                }

                guard let entry = todayEntry, let timings = entry["timings"] as? [String: String] else {
                    completion(nil, nil, nil)
                    return
                }

                let prayerNames = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]
                var prayers: [PrayerTime] = []

                let now = Date()
                var nextIndex = -1

                for (index, name) in prayerNames.enumerated() {
                    let timeStr = timings[name] ?? "--:--"
                    let parts = timeStr.split(separator: ":")
                    if parts.count >= 2, let hour = Int(parts[0]), let min = Int(parts[1]) {
                        var components = Calendar.current.dateComponentsL [.year, .month, .day], from: now)
                        components.hour = hour
                        components.minute = min
                        components.second = 0
                        if let prayerDate = Calendar.current.date(from: components), prayerDate > now {
                            nextIndex = index
                            break
                        }
                    }
                }

                if nextIndex == -1 { nextIndex = 0 }

                for (index, name) in prayerNames.enumerated() {
                    prayers.append(PrayerTime(name: name, time: timings[name] ?? "--:--", isNext: index == nextIndex))
                }

                let sunrise = timings["Sunrise"] ?? "--:--"
                let sunset = timings["Sunset"] ?? "--:--"

                if let encoded = try? JSONEncoder().encode(prayers) {
                    UserDefaults(suiteName: appGroupId)?.set(encoded, forKey: "cached_prayers_\(today)")
                    UserDefaults(suiteName: appGroupId)?.set(sunrise, forKey: "sunrise_\(today)")
                    UserDefaults(suiteName: appGroupId)?.set(sunset, forKey: "sunset_\(today)")
                }

                completion(prayers, sunrise, sunset)
            } catch {
                completion(nil, nil, nil)
            }
        }.resume()
    }

    static func fetchRandomAyah(completion: @escaping (AyahData?) -> Void) {
        // Fetch a random ayah from the Al-Quran API
        let urlString = "https://api.alquran.cloud/v1/ayah/random/editions/quran-uthmani"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let dataObj = json?["data"] as? [String: Any] {
                    let text = dataObj["text"] as? String ?? "Error loading Ayah"
                    let surah = dataObj["surah"] as? [String: Any]
                    let surahName = surah?["name"] as? String ?? "Unknown"
                    let number = dataObj["number"] as? Int ?? 0
                    completion(AyahData(text: text, surah: surahName, ayahNum: number))
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

extension PrayerTime: Codable {}
