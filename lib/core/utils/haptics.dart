import 'package:vibration/vibration.dart';

/// Light haptic feedback for subtle interactions
void hapticLight() => Vibration.vibrate(duration: 40, amplitude: 120);

/// Haptic feedback for selection or success
void hapticSelect() => Vibration.vibrate(duration: 60, amplitude: 145);

/// Medium haptic feedback for significant actions
void hapticMedium() => Vibration.vibrate(duration: 60, amplitude: 160);
