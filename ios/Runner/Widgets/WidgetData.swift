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

    static func fetchPrayers(city: String, country: String, completion: @escaping (([PrayerTime]?, String?, String?) -> Void)) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        let cacheKey = "cached_prayers_\(city)_\(country)_\(today)"

        if let cached = UserDefaults.standard.data(forKey: cacheKey),
           let decoded = try? JSONDecoder().decode([PrayerTime].self, from: cached) {
            completion(decoded,
                       UserDefaults.standard.string(forKey: "sunrise_\(city)_\(country)_\(today)"),
                       UserDefaults.standard.string(forKey: "sunset_\(city)_\(country)_\(today)"))
            return
        }

        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedCountry = country.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil, nil, nil)
            return
        }

        let urlString = "https://api.aladhan.com/v1/timingsByCity/\(today)?city=\(encodedCity)&country=\(encodedCountry)&method=2"
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
                guard let dataObj = json?["data"] as? [String: Any],
                      let timings = dataObj["timings"] as? [String: String] else {
                    completion(nil, nil, nil)
                    return
                }

                let prayerNames = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]
                var prayers: [PrayerTime] = []

                let now = Date()
                var nextIndex = -1

                for (index, name) in prayerNames.enumerated() {
                    let timeStr = timings[name] ?? "--:--"
                    let cleanTime = timeStr.components(separatedBy: " ").first ?? timeStr
                    let parts = cleanTime.split(separator: ":")
                    if parts.count >= 2, let hour = Int(parts[0]), let min = Int(parts[1]) {
                        var components = Calendar.current.dateComponents([.year, .month, .day], from: now)
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
                    UserDefaults.standard.set(encoded, forKey: cacheKey)
                    UserDefaults.standard.set(sunrise, forKey: "sunrise_\(city)_\(country)_\(today)")
                    UserDefaults.standard.set(sunset, forKey: "sunset_\(city)_\(country)_\(today)")
                }

                completion(prayers, sunrise, sunset)
            } catch {
                completion(nil, nil, nil)
            }
        }.resume()
    }

    static func fetchRandomAyah(completion: @escaping (AyahData?) -> Void) {
        let urlString = "https://api.alquran.cloud/v1/ayah/random/quran-uthmani"
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
