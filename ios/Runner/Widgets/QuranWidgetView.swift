import WidgetKit
import SwiftUI

struct QuranWidgetView: View {
    var prayers: [PrayerTime]
    var sunrise: String
    var sunset: String
    var hijriDate: String
    var isLarge: Bool

    var body: some View {
        VStack(spacing: 8) {
            // Hijri Date Header
            HStack {
                Text(hijriDate)
                    .font(.system(size: isLarge ? 24 : 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 4)

            if isLarge {
                // Prayer Grid
                HStack(spacing: 0) {
                    ForEach(prayers, id: \.name) { prayer in
                        PrayerColumn(prayer: prayer)
                    }
                }
                .padding(.vertical, 8)

                // Next Prayer & Countdown
                if let next = prayers.first(where: { $0.isNext }) {
                    VStack {
                        Text("UNTIL")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white.opacity(0.7))

                        HStack {
                            Text(next.name)
                                .font(.system(size: 14, weight: .medium))
                            Text(next.time)
                                .font(.system(size: 14, weight: .bold))
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.bottom, 8)
                }

                // Sunrise / Sunset
                HStack {
                    VStack {
                        Text("Sunrise").font(.system(size: 10)).foregroundColor(.white.opacity(0.7))
                        Text(sunrise).font(.system(size: 12, weight: .bold)).foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Text("Sunset").font(.system(size: 10)).foregroundColor(.white.opacity(0.7))
                        Text(sunset).font(.system(size: 12, weight: .bold)).foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 12)
            } else {
                // Small Widget: just the next prayer and countdown
                if let next = prayers.first(where: { $0.isNext }) {
                    VStack {
                        Text("UNTIL").font(.system(size: 8, weight: .bold)).foregroundColor(.white.opacity(0.7))
                        HStack {
                            Text(next.name)
                                .font(.system(size: 12, weight: .medium))
                            Text(next.time)
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.05, green: 0.18, blue: 0.05)) // Dark Green Theme
    }
}

struct PrayerColumn: View {
    var prayer: PrayerTime

    var body: some View {
        VStack {
            Text(prayer.name)
                .font(.system(size: 10))
                .foregroundColor(prayer.isNext ? .white : .white.opacity(0.5))
            Text(prayer.time)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(prayer.isNext ? .white : .white.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
        .background(prayer.isNext ? Color.green.opacity(0.4) : Color.clear)
        .cornerRadius(4)
    }
}
