import WidgetKit
import SwiftUI
import AppIntents

// ─── Theme Colors (matched from Android XML) ──────────────────────────────────

private extension Color {
    static let wBg         = Color(red: 0.031, green: 0.110, blue: 0.039) // darker base
    static let wDivider    = Color(red: 0.086, green: 0.165, blue: 0.102) // #162A1A
    static let wDay        = Color(red: 0.227, green: 0.490, blue: 0.259) // #3A7D42
    static let wMonth      = Color(red: 0.478, green: 0.671, blue: 0.502) // #7AAB80
    static let wYear       = Color(red: 0.165, green: 0.290, blue: 0.180) // #2A4A2E
    static let wUntilLbl   = Color(red: 0.165, green: 0.290, blue: 0.180) // #2A4A2E
    static let wCountdown  = Color(red: 0.561, green: 0.682, blue: 0.573) // #8FAE92
    static let wPillText   = Color(red: 0.290, green: 0.478, blue: 0.314) // #4A7A50
    static let wPrayerLbl  = Color(red: 0.141, green: 0.239, blue: 0.153) // #243D27
    static let wPrayerTime = Color(red: 0.227, green: 0.361, blue: 0.243) // #3A5C3E
    static let wSunTime    = Color(red: 0.290, green: 0.478, blue: 0.314) // #4A7A50
    static let wAyahRef    = Color(red: 0.506, green: 0.780, blue: 0.518) // #81C784
    static let wAyahText   = Color(red: 0.910, green: 0.961, blue: 0.914) // #E8F5E9
}

// ─── containerBackground compat ───────────────────────────────────────────────

extension View {
    @ViewBuilder
    func widgetBackground<B: View>(@ViewBuilder content: () -> B) -> some View {
        if #available(iOS 17.0, *) {
            self.containerBackground(for: .widget, content: content)
        } else {
            self.background(content())
        }
    }
}

// ─── Small Widget ─────────────────────────────────────────────────────────────

struct QuranWidgetView: View {
    var entry: QuranPrayerEntry
    var isLarge: Bool

    var body: some View {
        if isLarge {
            LargeWidgetBody(entry: entry)
                .widgetBackground { Color.wBg }
        } else {
            SmallWidgetBody(entry: entry)
                .widgetBackground { Color.wBg }
        }
    }
}

struct SmallWidgetBody: View {
    var entry: QuranPrayerEntry

    var body: some View {
        VStack(spacing: 0) {
            // Hero: Hijri date
            VStack(alignment: .leading, spacing: 1) {
                HStack(alignment: .lastTextBaseline, spacing: 6) {
                    Text(entry.hijriDay)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.wDay)
                    Text(entry.hijriMonth)
                        .font(.system(size: 17))
                        .foregroundColor(.wMonth)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
                Text(entry.hijriYear)
                    .font(.system(size: 12))
                    .foregroundColor(.wYear)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.top, 8)
            .padding(.bottom, 6)

            // Divider
            Color.wDivider.frame(height: 1)

            // Bottom: countdown + prayer pill
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("UNTIL")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.wUntilLbl)
                        .tracking(1)
                    Text(entry.countdown)
                        .font(.system(size: 21, weight: .medium))
                        .foregroundColor(.wCountdown)
                        .lineLimit(1)
                        .layoutPriority(1)
                        .minimumScaleFactor(0.85)
                }
                Spacer(minLength: 6)
                Text(entry.nextPrayerName)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.wPillText)
                    .lineLimit(1)
                    .layoutPriority(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.wDivider)
                    )
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// ─── Large Widget ─────────────────────────────────────────────────────────────

struct LargeWidgetBody: View {
    var entry: QuranPrayerEntry

    var body: some View {
        VStack(spacing: 0) {
            // Hero row: date left, countdown right
            HStack(alignment: .center) {
                // Date
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .lastTextBaseline, spacing: 6) {
                        Text(entry.hijriDay)
                            .font(.system(size: 33, weight: .semibold))
                            .foregroundColor(.wDay)
                        Text(entry.hijriMonth)
                            .font(.system(size: 17))
                            .foregroundColor(.wMonth)
                            .lineLimit(1)
                            .layoutPriority(1)
                    }
                    Text(entry.hijriYear)
                        .font(.system(size: 13))
                        .foregroundColor(.wYear)
                }
                Spacer(minLength: 8)
                // Countdown
                VStack(alignment: .trailing, spacing: 2) {
                    Text("UNTIL")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.wUntilLbl)
                        .tracking(1)
                        .padding(.top, 3)
                    Text(entry.countdown)
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.wCountdown)
                        .lineLimit(1)
                        .layoutPriority(1)
                    Text(entry.nextPrayerName)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.wPillText)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.wDivider)
                        )
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 12)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)

            // Divider
            Color.wDivider.frame(height: 1)

            // Prayer grid
            HStack(spacing: 0) {
                ForEach(entry.prayers, id: \.name) { prayer in
                    if entry.prayers.first?.name != prayer.name {
                        Color.wDivider.frame(width: 1)
                    }
                    PrayerCell(prayer: prayer, isHighlighted: prayer.name == entry.nextPrayerName)
                }
            }
            .frame(maxWidth: .infinity)

            // Divider
            Color.wDivider.frame(height: 1)

            // Sunrise / Sunset
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "sunrise.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.wMonth)
                    Text("Sunrise")
                        .font(.system(size: 10))
                        .foregroundColor(.wPrayerLbl)
                    Text(entry.sunrise)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.wSunTime)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
                Spacer()
                Color.wDivider.frame(width: 1, height: 14)
                Spacer()
                HStack(spacing: 4) {
                    Text(entry.sunset)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.wSunTime)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Text("Sunset")
                        .font(.system(size: 10))
                        .foregroundColor(.wPrayerLbl)
                    Image(systemName: "sunset.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.wMonth)
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 6)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
        }
    }
}

struct PrayerCell: View {
    var prayer: PrayerTime
    var isHighlighted: Bool

    private let highlightColor = Color(red: 0.478, green: 0.620, blue: 0.478) // #7A9E7A
    private let dimColor       = Color(red: 0.290, green: 0.420, blue: 0.290) // #4A6B4A
    private let underlineColor = Color(red: 0.176, green: 0.361, blue: 0.200) // #2D5C33

    var body: some View {
        VStack(spacing: 4) {
            Text(prayer.name)
                .font(.system(size: 12, weight: .medium))
                .tracking(0.3)
                .foregroundColor(isHighlighted ? highlightColor : dimColor)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .allowsTightening(true)
            Text(prayer.time.components(separatedBy: " ").first ?? prayer.time)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(isHighlighted ? highlightColor : dimColor)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .allowsTightening(true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
        .padding(.horizontal, 0)
        .background(
            VStack(spacing: 0) {
                Spacer()
                if isHighlighted {
                    Rectangle()
                        .fill(underlineColor)
                        .frame(height: 2)
                        .cornerRadius(1)
                }
            }
        )
    }
}

// ─── Refresh Ayah Intent ───────────────────────────────────────────────────────

struct RefreshAyahIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh Ayah"
    static var description = IntentDescription("Fetches a new random Ayah.")

    func perform() async throws -> some IntentResult {
        WidgetCenter.shared.reloadTimelines(ofKind: "com.abuhashim.khalafquran.ayahwidget")
        return .result()
    }
}

// ─── Ayah Widget ──────────────────────────────────────────────────────────────

struct QuranAyahWidgetView: View {
    var ayah: AyahData?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Centered ayah text
            Group {
                if let ayah = ayah {
                    Text(ayah.text)
                        .font(.system(size: 18))
                        .foregroundColor(.wAyahText)
                        .multilineTextAlignment(.center)
                        .lineLimit(5)
                        .minimumScaleFactor(0.7)
                        .padding(28)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Loading Ayah...")
                        .font(.system(size: 14))
                        .foregroundColor(.wCountdown)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }

            // Reference pinned top-right
            if let ayah = ayah {
                Text("\(ayah.surah) · \(ayah.ayahNum)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.wAyahRef)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .padding(12)
            }

            // Refresh button pinned top-left
            Button(intent: RefreshAyahIntent()) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.wAyahRef)
                    .padding(8)
                    .background(
                        Circle().fill(Color.wDivider)
                    )
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
        }
        .widgetBackground { Color.wBg }
    }
}
