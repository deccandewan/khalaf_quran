// بسم الله الرحمان الرحيم

// ══════════════════════════════════════════════════════════════════════════════
// SECTION INDEX  —  main.dart  (~10199 lines total)
// Use Ctrl/Cmd+G (go to line) in your IDE to jump to any section.
// ══════════════════════════════════════════════════════════════════════════════
//
// Line   273  — Haptics
//              _hapticLight, _hapticSelect, _hapticMedium
//              Thin wrappers around Vibration.vibrate() used throughout the UI.
//
// Line   284  — Language / Localisation
//              AppLanguage enum  (english | arabic | urdu)
//              L10n class — every user-visible string, number formatter, and
//              duration formatter, expressed as switch-on-language getters.
//
// Line  1172  — App State
//              AppState (ChangeNotifier singleton) — owns the current language,
//              loads it from SharedPreferences, and notifies the widget tree.
//
// Line  1203  — Helpers
//              _safUriToPath()    — Android SAF content:// URI → filesystem path.
//              surahNameForPage() — maps a Quran page number to a surah name.
//
// Line  1242  — Static Data
//              kJuzNames (line 1243) — 30 Juz English transliteration names.
//              kJuz      (line 1278) — 30 Juz maps: juz number, arabic name, start page.
//              kHizb     (line 1313) — 60 Hizb maps: hizb number, juz number, start page.
//              kSurahs   (line 1376) — 114 Surah maps: number, arabic, english, page.
//
// Line  1493  — Theme Constants
//              _kGreen, _kGreenLight, _kGreenMid, _kGreenLabel,
//              _kBgDeep, _kBgCard, _kBgSheet — the full app colour palette.
//
// Line  1503  — Entry Point
//              main()                     — bootstrap: HomeWidget group ID,
//                                           AudioNotificationService init,
//                                           language load, widget refresh, app run.
//              _saveLocationForWidget()   — placeholder stub, no GPS fetch.
//              _updateWidgetPrayerTimes() — triggers both Android home-screen widgets.
//
// Line  1532  — QuranApp  (root widget)
//              Root MaterialApp. Dark Material 3 theme, platform page transitions,
//              1-minute periodic home-widget update timer.
//
// Line  1592  — SplashScreen
//              4-phase animated intro: diamond ornament → خ letter → app name →
//              riwayah subtitle (1.3 s animation, 2 s hold before navigation).
//              Requests notification + storage permissions on first launch only.
//   Line  1783  — _SplashOrnament       Stacked diamond + خ letter widget.
//   Line  1837  — _DiamondPainter       CustomPainter: two concentric glowing diamonds.
//   Line  1915  — _FadedDiamondPainter  Dimmer diamond variant (empty-search state).
//
// Line  1975  — PrefsService
//              All SharedPreferences I/O in one static class:
//              last-read page, bookmarks + optional labels, audio base URL,
//              audio download folder, max DPI, reading goals (daily minutes /
//              total hours), daily reminder on/off + up to 3 scheduled time
//              slots, audio playback position, first-launch permission flag.
//
// Line  2235  — ReadingStatsService
//              Tracks total reading seconds, today's reading seconds, day-streak,
//              and a full ISO-date → seconds history map used by the heatmap.
//              Inputs are validated and debounced; history is in-memory cached
//              (JSON); streak calculation uses local-date parsing to be timezone-safe.
//
// Line  2439  — AudioNotificationService
//              flutter_local_notifications wrapper.
//              - Persistent playback notification (low-priority, ongoing) with
//                skip-back / play-pause / skip-forward action buttons and a
//                progress bar. Throttled to at most 1 update per second.
//              - Up to 3 independently-scheduled daily reminder notifications
//                (daily-repeat via matchDateTimeComponents).
//              - Test notification on a separate high-importance channel.
//
// Line  2756  — AudioService
//              Core audio singleton (WidgetsBindingObserver).
//   PlaybackMode enum: off | autoPlay | repeatOne
//   Key features:
//              - downloadAndPlay()      — download if absent, then stream from file.
//              - downloadOnly()         — download without playing.
//              - downloadAllSurahs()    — bulk download, 3 concurrent, exponential
//                                         backoff, up to 3 retries per surah.
//              - cancelSingleDownload() / cancelBulkDownload()
//              - Sleep timer with live countdown.
//              - O(1) isKnownDownloaded() via pre-populated Set (one dir scan on init).
//              - Position persistence: saved on pause and on app background.
//              - Lightweight listener set (Set<VoidCallback>, no ChangeNotifier).
//
// Line  3177  — SettingsScreen
//              Full settings page. Sections rendered by _SettingsScreenState:
//              - Offline Audio: bulk-download progress bar + "Download All" button.
//              - Download Location: folder picker (SAF + MANAGE_EXTERNAL_STORAGE).
//              - Render Quality: DPI slider 150–800 (14 stops).
//              - Daily Reminder: toggle + count stepper (1–3) + time pickers.
//              - Test notification button (permission-request flow included).
//              - Reading Statistics: heatmap + stat chips + reset option.
//              - Reading Goals: daily-minutes picker + total-hours picker.
//              - Prayer Location: city picker sheet.
//              - Language: English / Arabic / Urdu selector.
//              - About: version number.
//              - Check for Updates: _UpdateChecker widget.
//
// Line  5139  — _CityPickerDialog
//              Searchable modal dialog listing cities for prayer-location selection.
//              Returns (name, lat, lon) on tap.
//
// Line  5425  — _SectionHeader
//              Reusable all-caps settings section label widget.
//
// Line  5448  — _GoalRow
//              Tappable settings row: icon + label + current value + chevron.
//              Used for daily-goal and total-goal rows.
//
// Line  5506  — _StatsSheet
//              Modal bottom-sheet: streak hero circle, _StreakDots 7-dot row,
//              two _TimeRingCard widgets (today vs daily goal, total vs total goal).
//
// Line  5676  — _StreakDots
//              7-dot row showing the current 7-day "lap" of the streak.
//              Completed full weeks shown as a x N badge to the right.
//
// Line  5748  — _StatChip
//              Small labelled value chip used in the Settings reading-stats card.
//
// Line  5828  — _ReadingHeatmap
//              Month-view calendar heatmap. Each cell is coloured by reading
//              intensity (seconds that day / month max). Month navigation arrows.
//
// Line  5988  — _HeatCell
//              Single 32x32 calendar day cell: intensity-coloured background,
//              today border, future-day dimming.
//
// Line  6040  — _HeatNavBtn
//              Prev/next month navigation arrow button for _ReadingHeatmap.
//
// Line  6061  — _TimeRingCard
//              Card: circular arc ring (CustomPaint) + time text +
//              mini linear progress bar + goal sub-label.
//
// Line  6138  — _RingPainter
//              CustomPainter: grey background arc + coloured foreground arc.
//
// Line  6185  — SurahListScreen  (home screen)
//              Three-tab screen: Surah | Juz | Hizb.
//              Portrait: AppBar with logo diamond, streak badge, bookmark icon,
//              segmented TabBar, search TextField, Continue Reading banner,
//              BottomNavigationBar audio bar.
//              Landscape: 64 px left sidebar with vertical tab/icon buttons.
//              Handles: search dialog, bookmarks sheet, audio sheet, stats sheet,
//              settings navigation, home-screen quick-action shortcuts.
//
// Line  6953  — Sidebar helpers  (landscape mode)
//              _SidebarIcon — icon-only button used in the landscape sidebar.
//              _SidebarTab  — vertical text-label tab button for landscape sidebar.
//
// Line  7013  — _SurahTab
//              Scrollable list of 114 surahs (AutomaticKeepAlive, RepaintBoundary).
//   Line  7083  — _SurahListItem   Single surah row: number badge, Arabic + English
//                                  names, starting page, live download-status icon /
//                                  circular progress indicator.
//
// Line  7246  — _JuzTab
//              Scrollable list of 30 Juz entries (kept alive across tab switches).
//   Line  7289  — _JuzListItem    Juz row: number badge, Arabic name, surah-range
//                                  subtitle, starting page.
//
// Line  7415  — _HizbTab
//              Scrollable list of 60 Hizb entries (kept alive).
//   Line  7458  — _HizbListItem  Hizb row: number badge (teal, darker for even/second-
//                                  half hizb), hizb label, juz number, starting page.
//
// Line  7575  — Optimised PDF Rendering System
//              _RenderingConfig        (line 7582) — device-aware cache extent,
//                                                    pixel budget, quality threshold.
//              _OptimizedRenderingStrategy (line 7626) — per-page scale selector:
//                                                    fast-pass (300 DPI) vs quality-pass
//                                                    (user max DPI), capped by pixel budget.
//
// Line  7667  — PdfScreen  (Quran reader)
//              Full-screen PDF viewer built on pdfrx. Features:
//              - Auto-hiding top/bottom bars (4 s idle, 6 px drag threshold to re-show).
//              - Double-tap zoom centred on tap position.
//              - Lock-scroll mode: constrains horizontal pan via Matrix4 override.
//              - Bookmark toggle with optional label input dialog.
//              - Jump-to-page number dialog.
//              - Reading-time session tracking (Duration recorded on dispose).
//              - Last-read page + surah name saved on every page change and on dispose.
//              - Wakelock enabled for the full reading session.
//              - Status-bar style forced dark while reading.
//              - Inline _AudioMiniBar pinned to the bottom.
//
// Line  8441  — _BottomAudioBar
//              Persistent bar in SurahListScreen's bottomNavigationBar slot.
//              Renders SizedBox.shrink() when no audio is active; _AudioMiniBar otherwise.
//
// Line  8483  — _AudioMiniBar
//              Collapsible mini audio bar shared between list screen and reader.
//              Expanded: headphone avatar, surah name + Arabic, play/pause, collapse.
//              Collapsed: name only, play/pause, expand arrow.
//              Always shows a thin _ProgressBar strip at the bottom.
//              Collapse state persisted in a global ValueNotifier.
//
// Line  8665  — Shared audio widgets
//              _HeadphoneIcon   (line 8668) — circular green headphones avatar.
//              _PlayPauseButton (line 8687) — animated play/pause icon (180 ms switch).
//              _ProgressBar     (line 8715) — StreamBuilder-based 2 px progress strip.
//
// Line  8742  — _AudioSheet
//              Full audio bottom-sheet. Components:
//              - Reciter label (Abd Al-Rashid Sufi · Khalaf an Hamzah).
//              - ListWheelScrollView surah picker (114 items, 3D perspective wheel).
//              - Download status indicator + Play / Download-and-play button.
//              - Saved-position resume option (shown when a position is stored).
//              - StreamBuilder seek bar with draggable thumb + position/duration labels.
//              - Controls row: mode toggle | skip-10s | play/pause | skip+10s | sleep.
//              - Sleep timer chip picker (Off / 15m / 30m / 60m).
//
// Line  9314  — _ModeButton
//              Icon button cycling: off -> autoPlay (playlist) -> repeatOne.
//
// Line  9346  — _SleepButton
//              Moon icon button; shows mm:ss countdown overlay when timer is active.
//
// Line  9398  — _SurahGalleryModal
//              DraggableScrollableSheet with 3-column grid of all 114 surahs.
//              Cloud-done (green) / cloud-off icon per tile.
//              Per-tile ValueNotifier<_TileState> so only the active tile rebuilds
//              during download — the rest of the grid is untouched.
//
// Line  9592  — _UpdateChecker
//              GitHub Releases API poller (api.github.com/repos/.../releases/latest).
//              State machine: idle -> checking -> upToDate | updateAvailable ->
//              downloading -> readyToInstall -> done | error.
//              APK download runs in background; state survives navigation via
//              static persisted fields; cancel token kept alive across rebuilds.
//
// Line 10039 — _TileState
//              Immutable data record for a gallery tile
//              (isDownloading, isDownloaded, progress).
//
// Line 10052 — _SurahTile
//              Single tile in _SurahGalleryModal: cloud status icon, surah name,
//              linear progress bar (visible while downloading), download/cancel button.
//
// ══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:khalaf_quran/version.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:pdfrx/pdfrx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'dart:math' as math;
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:vibration/vibration.dart';
import 'package:home_widget/home_widget.dart';

// ─── Haptics ───────────────────────────────────────────────────────────────────

/// Light tap — navigation, opening sheets, list items.
void _hapticLight() => Vibration.vibrate(duration: 40, amplitude: 120);

/// Selection click — toggles, mode switches, small state changes.
void _hapticSelect() => Vibration.vibrate(duration: 60, amplitude: 145);

/// Medium — confirmations, bookmark add/remove.
void _hapticMedium() => Vibration.vibrate(duration: 60, amplitude: 160);

class PressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;

  const PressScale({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: iosStandard),
    );
  }

  void _handleDown(TapDownDetails _) {
    _hapticLight();
    _ctrl.forward();
  }

  void _handleUp() {
    _ctrl.reverse();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleDown,
      onTapUp: (_) => _handleUp(),
      onTapCancel: _handleUp,
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

// ─── Language ──────────────────────────────────────────────────────────────────

enum AppLanguage { english, arabic, urdu }

class L10n {
  final AppLanguage lang;
  const L10n(this.lang);

  String get appName => switch (lang) {
        AppLanguage.arabic => 'قرآن خلف',
        AppLanguage.urdu => 'قرآن خلف',
        AppLanguage.english => 'Khalaf Quran',
      };

  String get riwayah => switch (lang) {
        AppLanguage.arabic => 'رواية خلف عن حمزة',
        AppLanguage.urdu => 'روایت خلف عن حمزہ',
        AppLanguage.english => 'Riwayat Khalaf ʿan Ḥamzah',
      };

  String get tabSurahs => switch (lang) {
        AppLanguage.arabic => 'السور',
        AppLanguage.urdu => 'سورتیں',
        AppLanguage.english => 'Surah',
      };

  String get tabJuz => switch (lang) {
        AppLanguage.arabic => 'الأجزاء',
        AppLanguage.urdu => 'اجزاء',
        AppLanguage.english => 'Juz',
      };

  String get searchHint => switch (lang) {
        AppLanguage.arabic => 'ابحث عن سورة…',
        AppLanguage.urdu => 'سورت تلاش کریں…',
        AppLanguage.english => 'Search surah name or number…',
      };

  String get noResults => switch (lang) {
        AppLanguage.arabic => 'لا نتائج',
        AppLanguage.urdu => 'کوئی نتیجہ نہیں',
        AppLanguage.english => 'No results',
      };

  String get continueReading => switch (lang) {
        AppLanguage.arabic => 'متابعة القراءة',
        AppLanguage.urdu => 'مسلسل پڑھے',
        AppLanguage.english => 'Continue Reading',
      };

  /// Converts a non-negative integer to the correct numeral system for the
  /// current language. Arabic and Urdu use Eastern Arabic-Indic digits
  /// (٠١٢٣٤٥٦٧٨٩); English keeps ASCII digits.
  ///
  /// Optimised: walks the digit string once with a StringBuffer instead of
  /// split → map → join, avoiding several intermediate list/string allocations.
  String toLocalNum(int n) {
    if (lang == AppLanguage.english) return '$n';
    const eastern = '٠١٢٣٤٥٦٧٨٩';
    final src = '$n';
    final buf = StringBuffer();
    for (var i = 0; i < src.length; i++) {
      final code = src.codeUnitAt(i) - 48; // '0' == 48
      buf.write(code >= 0 && code <= 9 ? eastern[code] : src[i]);
    }
    return buf.toString();
  }

  String page(int n) => switch (lang) {
        AppLanguage.arabic => 'صفحة ${toLocalNum(n)}',
        AppLanguage.urdu => 'صفحہ ${toLocalNum(n)}',
        AppLanguage.english => 'Page $n',
      };

  String pageOf(int n, int total) => switch (lang) {
        AppLanguage.arabic => 'صفحة ${toLocalNum(n)} / ${toLocalNum(total)}',
        AppLanguage.urdu => 'صفحہ ${toLocalNum(n)} / ${toLocalNum(total)}',
        AppLanguage.english => 'Page $n / $total',
      };

  String get tapToJump => switch (lang) {
        AppLanguage.arabic => 'اضغط للانتقال',
        AppLanguage.urdu => 'جانے کے لیے ٹیپ کریں',
        AppLanguage.english => 'tap to jump',
      };

  String startsPage(int p) => switch (lang) {
        AppLanguage.arabic => 'يبدأ ص. ${toLocalNum(p)}',
        AppLanguage.urdu => 'شروع ص. ${toLocalNum(p)}',
        AppLanguage.english => 'Starts pg. $p',
      };

  String get bookmarks => switch (lang) {
        AppLanguage.arabic => 'الإشارات المرجعية',
        AppLanguage.urdu => 'بُک مارکس',
        AppLanguage.english => 'Bookmarks',
      };

  String get noBookmarks => switch (lang) {
        AppLanguage.arabic =>
          'لا توجد إشارات بعد.\nاضغط ☆ في القارئ لإضافة إشارة.',
        AppLanguage.urdu =>
          'ابھی کوئی بُک مارک نہیں۔\nشامل کرنے کے لیے ریڈر میں ☆ دبائیں۔',
        AppLanguage.english =>
          'No bookmarks yet.\nTap ☆ in the reader to add one.',
      };

  String get bookmarkAdded => switch (lang) {
        AppLanguage.arabic => 'أُضيفت الإشارة',
        AppLanguage.urdu => 'بُک مارک شامل ہوا',
        AppLanguage.english => 'Bookmark added',
      };

  String get bookmarkRemoved => switch (lang) {
        AppLanguage.arabic => 'حُذفت الإشارة',
        AppLanguage.urdu => 'بُک مارک ہٹایا',
        AppLanguage.english => 'Bookmark removed',
      };

  String get settings => switch (lang) {
        AppLanguage.arabic => 'الإعدادات',
        AppLanguage.urdu => 'ترتیبات',
        AppLanguage.english => 'Settings',
      };

  String get downloadLocation => switch (lang) {
        AppLanguage.arabic => 'موقع التنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ مقام',
        AppLanguage.english => 'Download Location',
      };

  String get downloadLocationDesc => switch (lang) {
        AppLanguage.arabic => 'مجلد التخزين المحلي للملفات الصوتية.',
        AppLanguage.urdu => 'آڈیو فائلوں کے لیے مقامی اسٹوریج فولڈر۔',
        AppLanguage.english => 'Local storage folder for audio files.',
      };

  String get currentFolder => switch (lang) {
        AppLanguage.arabic => 'المجلد الحالي',
        AppLanguage.urdu => 'موجودہ فولڈر',
        AppLanguage.english => 'Current Folder',
      };

  String get resetToDefault => switch (lang) {
        AppLanguage.arabic => 'إعادة الضبط',
        AppLanguage.urdu => 'ڈیفالٹ پر',
        AppLanguage.english => 'Reset to default',
      };

  String get edit => switch (lang) {
        AppLanguage.arabic => 'تعديل',
        AppLanguage.urdu => 'ترمیم',
        AppLanguage.english => 'Edit',
      };

  String get cancel => switch (lang) {
        AppLanguage.arabic => 'إلغاء',
        AppLanguage.urdu => 'منسوخ',
        AppLanguage.english => 'Cancel',
      };

  String get save => switch (lang) {
        AppLanguage.arabic => 'حفظ',
        AppLanguage.urdu => 'محفوظ',
        AppLanguage.english => 'Save',
      };

  String get offlineAudio => switch (lang) {
        AppLanguage.arabic => 'الصوت بدون إنترنت',
        AppLanguage.urdu => 'آف لائن آڈیو',
        AppLanguage.english => 'Offline Audio',
      };

  String get downloadAllDesc => switch (lang) {
        AppLanguage.arabic =>
          'حمّل جميع السور الـ 114 للاستماع بدون إنترنت. الملفات الموجودة تُتجاوز تلقائيًا.',
        AppLanguage.urdu =>
          'آف لائن سننے کے لیے تمام 114 سورتیں ڈاؤنلوڈ کریں۔ پہلے سے موجود فائلیں خودبخود چھوڑ دی جائیں گی۔',
        AppLanguage.english =>
          'Download all 114 surahs for offline listening. Already-cached files are skipped automatically.',
      };

  String get downloadAllSurahs => switch (lang) {
        AppLanguage.arabic => 'تنزيل جميع السور',
        AppLanguage.urdu => 'تمام سورتیں ڈاؤنلوڈ کریں',
        AppLanguage.english => 'Download All Surahs',
      };

  String downloading(int c, int t) => switch (lang) {
        AppLanguage.arabic =>
          'جارٍ التنزيل ${toLocalNum(c)} / ${toLocalNum(t)}',
        AppLanguage.urdu => 'ڈاؤنلوڈ ${toLocalNum(c)} / ${toLocalNum(t)}',
        AppLanguage.english => 'Downloading $c / $t',
      };

  String get downloadAllTitle => switch (lang) {
        AppLanguage.arabic => 'تنزيل كل الصوتيات',
        AppLanguage.urdu => 'تمام آڈیو ڈاؤنلوڈ',
        AppLanguage.english => 'Download All Audio',
      };

  String get downloadAllConfirm => switch (lang) {
        AppLanguage.arabic =>
          'سيتم تنزيل جميع السور الـ 114 (~500 ميغابايت).\nالملفات الموجودة تُتجاوز تلقائيًا.\n\nهل تريد المتابعة؟',
        AppLanguage.urdu =>
          'تمام 114 سورتیں (~500 MB) ڈاؤنلوڈ ہوں گی۔\nموجود فائلیں چھوڑ دی جائیں گی۔\n\nجاری رکھیں؟',
        AppLanguage.english =>
          'This will download all 114 surahs (~500 MB).\nAlready-downloaded files will be skipped.\n\nContinue?',
      };

  String get download => switch (lang) {
        AppLanguage.arabic => 'تنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ',
        AppLanguage.english => 'Download',
      };

  String get allDownloaded => switch (lang) {
        AppLanguage.arabic => 'تم تنزيل جميع السور بنجاح',
        AppLanguage.urdu => 'تمام سورتیں کامیابی سے ڈاؤنلوڈ ہوئیں',
        AppLanguage.english => 'All surahs downloaded successfully',
      };

  String get readingStats => switch (lang) {
        AppLanguage.arabic => 'إحصائيات القراءة',
        AppLanguage.urdu => 'پڑھنے کے اعداد',
        AppLanguage.english => 'Reading Statistics',
      };

  String get today => switch (lang) {
        AppLanguage.arabic => 'اليوم',
        AppLanguage.urdu => 'آج',
        AppLanguage.english => 'Today',
      };

  String get dayStreak => switch (lang) {
        AppLanguage.arabic => 'أيام متتالية',
        AppLanguage.urdu => 'مسلسل دن',
        AppLanguage.english => 'Day Streak',
      };

  String get manageSurahs => switch (lang) {
        AppLanguage.arabic => 'إدارة السور',
        AppLanguage.urdu => 'سورتیں منیج کریں',
        AppLanguage.english => 'Manage Surahs',
      };

  String get downloaded => switch (lang) {
        AppLanguage.arabic => 'تم التنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ شدہ',
        AppLanguage.english => 'Downloaded',
      };

  String get notDownloaded => switch (lang) {
        AppLanguage.arabic => 'لم يتم التنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ نہیں',
        AppLanguage.english => 'Not Downloaded',
      };

  String get totalTime => switch (lang) {
        AppLanguage.arabic => 'إجمالي الوقت',
        AppLanguage.urdu => 'کل وقت',
        AppLanguage.english => 'Total Time',
      };

  String get resetStats => switch (lang) {
        AppLanguage.arabic => 'إعادة تعيين الإحصائيات',
        AppLanguage.urdu => 'اعداد ری سیٹ',
        AppLanguage.english => 'Reset Stats',
      };

  String get readingGoals => switch (lang) {
        AppLanguage.arabic => 'أهداف القراءة',
        AppLanguage.urdu => 'پڑھنے کے اہداف',
        AppLanguage.english => 'Reading Goals',
      };

  String get dailyGoal => switch (lang) {
        AppLanguage.arabic => 'الهدف اليومي',
        AppLanguage.urdu => 'روزانہ ہدف',
        AppLanguage.english => 'Daily Goal',
      };

  String get totalGoal => switch (lang) {
        AppLanguage.arabic => 'الهدف الإجمالي',
        AppLanguage.urdu => 'کل ہدف',
        AppLanguage.english => 'Total Goal',
      };

  String get minutes => switch (lang) {
        AppLanguage.arabic => 'دقيقة',
        AppLanguage.urdu => 'منٹ',
        AppLanguage.english => 'minutes',
      };

  String get hours => switch (lang) {
        AppLanguage.arabic => 'ساعة',
        AppLanguage.urdu => 'گھنٹے',
        AppLanguage.english => 'hours',
      };

  /// Formats a Duration into a localized short string e.g. ٢س ١٥د / 2h 15m.
  String formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    switch (lang) {
      case AppLanguage.arabic:
        if (h > 0) return '${toLocalNum(h)}س ${toLocalNum(m)}د';
        if (m > 0) return '${toLocalNum(m)}د ${toLocalNum(s)}ث';
        return '${toLocalNum(s)}ث';
      case AppLanguage.urdu:
        if (h > 0) return '${toLocalNum(h)}گھ ${toLocalNum(m)}م';
        if (m > 0) return '${toLocalNum(m)}م ${toLocalNum(s)}س';
        return '${toLocalNum(s)}س';
      case AppLanguage.english:
        if (h > 0) return '${h}h ${m}m';
        if (m > 0) return '${m}m ${s}s';
        return '${s}s';
    }
  }

  String goalMinutes(int mins) => switch (lang) {
        AppLanguage.arabic => '/ ${toLocalNum(mins)} دقيقة',
        AppLanguage.urdu => '/ ${toLocalNum(mins)} منٹ',
        AppLanguage.english => '/ ${mins}m goal',
      };

  String goalHours(int hrs) => switch (lang) {
        AppLanguage.arabic => '/ ${toLocalNum(hrs)} ساعة',
        AppLanguage.urdu => '/ ${toLocalNum(hrs)} گھنٹے',
        AppLanguage.english => '/ ${hrs}h goal',
      };

  String get resetStatsTitle => switch (lang) {
        AppLanguage.arabic => 'إعادة تعيين الإحصائيات',
        AppLanguage.urdu => 'اعداد ری سیٹ کریں',
        AppLanguage.english => 'Reset Statistics',
      };

  String get resetStatsConfirm => switch (lang) {
        AppLanguage.arabic =>
          'سيتم مسح سلسلة الأيام ووقت القراءة. لا يمكن التراجع.',
        AppLanguage.urdu =>
          'آپ کا اسٹریک اور پڑھنے کا وقت مٹ جائے گا۔ یہ واپس نہیں ہوگا۔',
        AppLanguage.english =>
          'This will clear your streak and reading time. This cannot be undone.',
      };

  String get reset => switch (lang) {
        AppLanguage.arabic => 'إعادة تعيين',
        AppLanguage.urdu => 'ری سیٹ',
        AppLanguage.english => 'Reset',
      };

  String get prayerLocation => switch (lang) {
        AppLanguage.arabic => 'موقع الصلاة',
        AppLanguage.urdu => 'نماز کی جگہ',
        AppLanguage.english => 'Prayer Location',
      };

  String get prayerLocationDesc => switch (lang) {
        AppLanguage.arabic => 'حدد موقعك للحصول على أوقات الصلاة الدقيقة.',
        AppLanguage.urdu => 'نماز کے اوقات کے لیے اپنی جگہ منتخب کریں۔',
        AppLanguage.english => 'Select your location for prayer times.',
      };

  String get selectCity => switch (lang) {
        AppLanguage.arabic => 'اختر المدينة',
        AppLanguage.urdu => 'شہر منتخب کریں',
        AppLanguage.english => 'Select City',
      };

  String get about => switch (lang) {
        AppLanguage.arabic => 'حول',
        AppLanguage.urdu => 'بارے میں',
        AppLanguage.english => 'About',
      };

  String get aboutVersion => switch (lang) {
        AppLanguage.arabic => 'الإصدار: $kAppVersion',
        AppLanguage.urdu => 'ورژن: $kAppVersion',
        AppLanguage.english => 'Version: $kAppVersion',
      };

  String get language => switch (lang) {
        AppLanguage.arabic => 'اللغة',
        AppLanguage.urdu => 'زبان',
        AppLanguage.english => 'Language',
      };

  String get reciterLabel => switch (lang) {
        AppLanguage.arabic => 'عبد الرشيد صوفي  •  خلف عن حمزة',
        AppLanguage.urdu => 'عبد الرشید صوفی  •  خلف عن حمزہ',
        AppLanguage.english => 'Abd Al-Rashid Sufi  •  Khalaf ʿan Ḥamzah',
      };

  String get play => switch (lang) {
        AppLanguage.arabic => 'تشغيل',
        AppLanguage.urdu => 'چلائیں',
        AppLanguage.english => 'Play',
      };

  String get downloadAndPlay => switch (lang) {
        AppLanguage.arabic => 'تنزيل وتشغيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ اور چلائیں',
        AppLanguage.english => 'Download & Play',
      };

  String get recitation => switch (lang) {
        AppLanguage.arabic => 'التلاوة',
        AppLanguage.urdu => 'تلاوت',
        AppLanguage.english => 'Recitation',
      };

  String get goToPage => switch (lang) {
        AppLanguage.arabic => 'انتقل إلى صفحة',
        AppLanguage.urdu => 'صفحے پر جائیں',
        AppLanguage.english => 'Go to page',
      };

  String get go => switch (lang) {
        AppLanguage.arabic => 'انتقال',
        AppLanguage.urdu => 'جائیں',
        AppLanguage.english => 'Go',
      };

  String get downloadLocationReset => switch (lang) {
        AppLanguage.arabic => 'تمت إعادة تعيين موقع التنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ مقام ری سیٹ ہوا',
        AppLanguage.english => 'Download location reset to default',
      };

  String get renderQuality => switch (lang) {
        AppLanguage.arabic => 'جودة العرض',
        AppLanguage.urdu => 'رینڈر کوالٹی',
        AppLanguage.english => 'Render Quality',
      };

  String get maxDpi => switch (lang) {
        AppLanguage.arabic => 'الحد الأقصى للدقة (DPI)',
        AppLanguage.urdu => 'زیادہ سے زیادہ ریزولیوشن (DPI)',
        AppLanguage.english => 'Maximum DPI',
      };

  String get maxDpiDesc => switch (lang) {
        AppLanguage.arabic =>
          'موصى به: 380–500. القيم الأعلى تستهلك مزيدًا من الذاكرة.',
        AppLanguage.urdu =>
          'تجویز کردہ: 380–500۔ زیادہ قدریں زیادہ میموری استعمال کرتی ہیں۔',
        AppLanguage.english =>
          'Recommended: 380–500. Higher values use more memory.',
      };

  String get selectFolder => switch (lang) {
        AppLanguage.arabic => 'اختر مجلدًا',
        AppLanguage.urdu => 'فولڈر منتخب کریں',
        AppLanguage.english => 'Select Folder',
      };

  String get lockCamera => switch (lang) {
        AppLanguage.arabic => 'قفل الحركة',
        AppLanguage.urdu => 'حرکت کو لاک کریں',
        AppLanguage.english => 'Lock Movement',
      };

  String get cameraLocked => switch (lang) {
        AppLanguage.arabic => 'الحركة مقفلة',
        AppLanguage.urdu => 'حرکت لاک شدہ ہے',
        AppLanguage.english => 'Movement locked',
      };

  String get cameraUnlocked => switch (lang) {
        AppLanguage.arabic => 'الحركة غير مقفلة',
        AppLanguage.urdu => 'حرکت غیر مقفل',
        AppLanguage.english => 'Movement unlocked',
      };

  // ── Hizb tab ───────────────────────────────────────────────────────────────
  String get tabHizb => switch (lang) {
        AppLanguage.arabic => 'الأحزاب',
        AppLanguage.urdu => 'احزاب',
        AppLanguage.english => 'Hizb',
      };

  String hizbLabel(int n) => switch (lang) {
        AppLanguage.arabic => 'الحزب ${toLocalNum(n)}',
        AppLanguage.urdu => 'حزب ${toLocalNum(n)}',
        AppLanguage.english => 'Hizb $n',
      };

  // ── Bookmark labels ────────────────────────────────────────────────────────
  String get bookmarkLabelTitle => switch (lang) {
        AppLanguage.arabic => 'إضافة ملاحظة (اختياري)',
        AppLanguage.urdu => 'نوٹ شامل کریں (اختیاری)',
        AppLanguage.english => 'Add a note (optional)',
      };

  String get bookmarkLabelHint => switch (lang) {
        AppLanguage.arabic => 'مثلاً: توقفت هنا…',
        AppLanguage.urdu => 'مثلاً: یہاں رکا…',
        AppLanguage.english => 'e.g. Stopped here…',
      };

  // ── Daily reminder ─────────────────────────────────────────────────────────
  String get dailyReminder => switch (lang) {
        AppLanguage.arabic => 'تذكير القراءة اليومي',
        AppLanguage.urdu => 'روزانہ یاددہانی',
        AppLanguage.english => 'Daily Reading Reminder',
      };

  String get dailyReminderDesc => switch (lang) {
        AppLanguage.arabic =>
          'إشعار يومي في وقت محدد إذا لم تقرأ بعد. لا يظهر إذا قرأت في ذلك اليوم.',
        AppLanguage.urdu =>
          'اگر آج کوئی پڑھائی نہ ہو تو مقررہ وقت پر یاددہانی آئے گی۔',
        AppLanguage.english =>
          'A daily nudge if you haven\'t read yet. Skipped automatically on days you\'ve already read.',
      };

  String get reminderTime => switch (lang) {
        AppLanguage.arabic => 'وقت التذكير',
        AppLanguage.urdu => 'یاددہانی کا وقت',
        AppLanguage.english => 'Reminder Time',
      };

  String get reminderEnabled => switch (lang) {
        AppLanguage.arabic => 'تفعيل التذكير',
        AppLanguage.urdu => 'یاددہانی فعال کریں',
        AppLanguage.english => 'Enable reminder',
      };

  String get testNotification => switch (lang) {
        AppLanguage.arabic => 'اختبار الإشعار',
        AppLanguage.urdu => 'اطلاع ٹیسٹ کریں',
        AppLanguage.english => 'Test Notification',
      };

  String get sent => switch (lang) {
        AppLanguage.arabic => 'تم الإرسال',
        AppLanguage.urdu => 'بھیجا گیا',
        AppLanguage.english => 'sent',
      };

  String resumeFrom(String t) => switch (lang) {
        AppLanguage.arabic => 'استئناف من $t',
        AppLanguage.urdu => '$t سے جاری رکھیں',
        AppLanguage.english => 'Resume from $t',
      };

  String get sleepOff => switch (lang) {
        AppLanguage.arabic => 'إيقاف',
        AppLanguage.urdu => 'بند',
        AppLanguage.english => 'Off',
      };

  String sleepMin(int m) => switch (lang) {
        AppLanguage.arabic => '${toLocalNum(m)}د',
        AppLanguage.urdu => '${toLocalNum(m)}م',
        AppLanguage.english => '${m}m',
      };

  String get allFilesAccessTitle => switch (lang) {
        AppLanguage.arabic => 'الوصول إلى جميع الملفات',
        AppLanguage.urdu => 'تمام فائلوں تک رسائی',
        AppLanguage.english => 'All Files Access',
      };

  String get allFilesAccessBody => switch (lang) {
        AppLanguage.arabic =>
          'لحفظ الصوت في أي مجلد — بما في ذلك بطاقات SD — يتطلب أندرويد منح هذا التطبيق إذن "الوصول إلى جميع الملفات".\n\nاضغط "فتح الإعدادات" وقم بتفعيل الخيار، ثم عد إلى هنا.',
        AppLanguage.urdu =>
          'کسی بھی فولڈر — بشمول SD کارڈ — میں آڈیو محفوظ کرنے کے لیے اینڈرائیڈ کو "تمام فائلوں تک رسائی" کی اجازت درکار ہے۔\n\n"ترتیبات کھولیں" پر ٹیپ کریں اور ٹوگل آن کریں، پھر یہاں واپس آئیں۔',
        AppLanguage.english =>
          'To save audio to any folder — including SD cards — Android requires "All files access" for this app.\n\nTap Open Settings and turn on the toggle, then come back here.',
      };

  String get notifPermissionTitle => switch (lang) {
        AppLanguage.arabic => 'إذن الإشعارات',
        AppLanguage.urdu => 'اطلاعات کی اجازت',
        AppLanguage.english => 'Notification Permission',
      };

  String get notifPermissionBody => switch (lang) {
        AppLanguage.arabic =>
          'للحصول على تذكيرات يومية للقراءة، يحتاج التطبيق إذنًا لإرسال الإشعارات.\n\nاضغط "فتح الإعدادات" وقم بتفعيل الإشعارات، ثم عد إلى هنا.',
        AppLanguage.urdu =>
          'روزانہ پڑھنے کی یاددہانیاں پانے کے لیے ایپ کو اطلاعات بھیجنے کی اجازت درکار ہے۔\n\n"ترتیبات کھولیں" پر ٹیپ کریں اور اطلاعات فعال کریں، پھر یہاں واپس آئیں۔',
        AppLanguage.english =>
          'To receive daily reading reminders and test notifications, this app needs permission to send notifications.\n\nTap Open Settings and enable notifications, then come back here.',
      };

  String get openSettings => switch (lang) {
        AppLanguage.arabic => 'فتح الإعدادات',
        AppLanguage.urdu => 'ترتیبات کھولیں',
        AppLanguage.english => 'Open Settings',
      };

  String downloadError(int n) => switch (lang) {
        AppLanguage.arabic => 'خطأ في تنزيل السورة ${toLocalNum(n)}',
        AppLanguage.urdu => 'سورت ${toLocalNum(n)} ڈاؤنلوڈ میں خرابی',
        AppLanguage.english => 'Error downloading surah $n',
      };

  String get permissionDenied => switch (lang) {
        AppLanguage.arabic =>
          'تم رفض إذن الإشعارات. يرجى تمكينها من إعدادات التطبيق.',
        AppLanguage.urdu =>
          'اطلاعات کی اجازت مسترد کی گئی۔ براہ کرم ایپ کی ترتیبات سے اسے فعال کریں۔',
        AppLanguage.english =>
          'Notification permission denied. Please enable it in app settings.',
      };

  // ── City picker ──────────────────────────────────────────────────────────────
  String get searchCities => switch (lang) {
        AppLanguage.arabic => 'ابحث عن مدينة…',
        AppLanguage.urdu => 'شہر تلاش کریں…',
        AppLanguage.english => 'Search cities…',
      };

  String get noCitiesFound => switch (lang) {
        AppLanguage.arabic => 'لا توجد مدن',
        AppLanguage.urdu => 'کوئی شہر نہیں ملا',
        AppLanguage.english => 'No cities found',
      };

  // ── Heatmap legend ───────────────────────────────────────────────────────────
  String get heatmapLess => switch (lang) {
        AppLanguage.arabic => 'أقل',
        AppLanguage.urdu => 'کم',
        AppLanguage.english => 'less',
      };

  String get heatmapMore => switch (lang) {
        AppLanguage.arabic => 'أكثر',
        AppLanguage.urdu => 'زیادہ',
        AppLanguage.english => 'more',
      };

  // ── Snackbar messages ────────────────────────────────────────────────────────
  String get widgetsRefreshed => switch (lang) {
        AppLanguage.arabic => 'تم تحديث الأدوات',
        AppLanguage.urdu => 'ویجٹ تازہ ہو گئے',
        AppLanguage.english => 'Widgets refreshed',
      };

  String get errorResettingDownloadLocation => switch (lang) {
        AppLanguage.arabic => 'خطأ في إعادة تعيين مجلد التنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ مقام ری سیٹ میں خرابی',
        AppLanguage.english => 'Error resetting download location',
      };

  String get folderResolveError => switch (lang) {
        AppLanguage.arabic =>
          'تعذّر تحديد المجلد المحدد. يرجى اختيار مجلد آخر.',
        AppLanguage.urdu =>
          'منتخب فولڈر کا تعین نہیں ہو سکا۔ براہ کرم دوسرا فولڈر منتخب کریں۔',
        AppLanguage.english =>
          'Could not resolve the selected folder. Please try a different one.',
      };

  String get folderWriteError => switch (lang) {
        AppLanguage.arabic =>
          'لا يمكن الكتابة في هذا المجلد. تحقق من منح صلاحية التخزين.',
        AppLanguage.urdu =>
          'اس فولڈر میں لکھنا ممکن نہیں۔ اسٹوریج کی اجازت چیک کریں۔',
        AppLanguage.english =>
          'Cannot write to that folder. Check storage permission is granted.',
      };

  String bulkDownloadResult(int succeeded, int total, String failedList) =>
      switch (lang) {
        AppLanguage.arabic =>
          'تم تنزيل ${toLocalNum(succeeded)}/${toLocalNum(total)}. فشل: $failedList',
        AppLanguage.urdu =>
          'ڈاؤنلوڈ ہوئے ${toLocalNum(succeeded)}/${toLocalNum(total)}۔ ناکام: $failedList',
        AppLanguage.english =>
          'Downloaded $succeeded/$total. Failed: $failedList',
      };

  // ── Update checker ───────────────────────────────────────────────────────────
  String get checkForUpdates => switch (lang) {
        AppLanguage.arabic => 'التحقق من التحديثات',
        AppLanguage.urdu => 'اپڈیٹ چیک کریں',
        AppLanguage.english => 'Check for updates',
      };

  String get checking => switch (lang) {
        AppLanguage.arabic => 'جارٍ التحقق…',
        AppLanguage.urdu => 'جانچ ہو رہی ہے…',
        AppLanguage.english => 'Checking…',
      };

  String upToDate(String v) => switch (lang) {
        AppLanguage.arabic => 'أنت على آخر إصدار ($v)',
        AppLanguage.urdu => 'آپ کا ورژن تازہ ترین ہے ($v)',
        AppLanguage.english => 'You\'re up to date ($v)',
      };

  String updateAvailableTitle(String v) => switch (lang) {
        AppLanguage.arabic => 'تحديث متاح — $v',
        AppLanguage.urdu => 'اپڈیٹ دستیاب ہے — $v',
        AppLanguage.english => 'Update available — $v',
      };

  String currentlyOn(String v) => switch (lang) {
        AppLanguage.arabic => 'الإصدار الحالي $v',
        AppLanguage.urdu => 'موجودہ ورژن $v',
        AppLanguage.english => 'Currently on $v',
      };

  String get downloadAndInstall => switch (lang) {
        AppLanguage.arabic => 'تنزيل وتثبيت',
        AppLanguage.urdu => 'ڈاؤنلوڈ اور انسٹال کریں',
        AppLanguage.english => 'Download & Install',
      };

  String get later => switch (lang) {
        AppLanguage.arabic => 'لاحقاً',
        AppLanguage.urdu => 'بعد میں',
        AppLanguage.english => 'Later',
      };

  String downloadingPercent(int pct) => switch (lang) {
        AppLanguage.arabic => 'جارٍ التنزيل… ${toLocalNum(pct)}%',
        AppLanguage.urdu => 'ڈاؤنلوڈ ہو رہا ہے… ${toLocalNum(pct)}%',
        AppLanguage.english => 'Downloading… $pct%',
      };

  String get downloadingLabel => switch (lang) {
        AppLanguage.arabic => 'جارٍ التنزيل…',
        AppLanguage.urdu => 'ڈاؤنلوڈ ہو رہا ہے…',
        AppLanguage.english => 'Downloading…',
      };

  String readyToInstall(String v) => switch (lang) {
        AppLanguage.arabic => '$v جاهز للتثبيت',
        AppLanguage.urdu => '$v انسٹال کے لیے تیار',
        AppLanguage.english => '$v ready to install',
      };

  String get downloadComplete => switch (lang) {
        AppLanguage.arabic => 'اكتمل التنزيل',
        AppLanguage.urdu => 'ڈاؤنلوڈ مکمل',
        AppLanguage.english => 'Download complete',
      };

  String get installNow => switch (lang) {
        AppLanguage.arabic => 'تثبيت الآن',
        AppLanguage.urdu => 'ابھی انسٹال کریں',
        AppLanguage.english => 'Install Now',
      };

  String get installStarted => switch (lang) {
        AppLanguage.arabic => 'بدأ التثبيت',
        AppLanguage.urdu => 'انسٹالیشن شروع ہو گئی',
        AppLanguage.english => 'Install started',
      };

  String get somethingWentWrong => switch (lang) {
        AppLanguage.arabic => 'حدث خطأ ما.',
        AppLanguage.urdu => 'کچھ غلط ہو گیا۔',
        AppLanguage.english => 'Something went wrong.',
      };

  String get updateNetworkError => switch (lang) {
        AppLanguage.arabic =>
          'تعذّر الوصول إلى GitHub. تحقق من الاتصال.',
        AppLanguage.urdu =>
          'GitHub تک رسائی نہیں ہو سکی۔ کنکشن چیک کریں۔',
        AppLanguage.english =>
          'Could not reach GitHub. Check your connection.',
      };

  String get downloadFailed => switch (lang) {
        AppLanguage.arabic => 'فشل التنزيل. حاول مرة أخرى.',
        AppLanguage.urdu => 'ڈاؤنلوڈ ناکام ہوا۔ دوبارہ کوشش کریں۔',
        AppLanguage.english => 'Download failed. Try again.',
      };

  String autoInstallUnavailable(String path) => switch (lang) {
        AppLanguage.arabic =>
          'التثبيت التلقائي غير متاح. تم حفظ ملف APK في:\n$path',
        AppLanguage.urdu =>
          'خودکار انسٹال دستیاب نہیں۔ APK محفوظ ہے:\n$path',
        AppLanguage.english =>
          'Auto-install unavailable. APK saved to:\n$path',
      };

  String get retry => switch (lang) {
        AppLanguage.arabic => 'إعادة المحاولة',
        AppLanguage.urdu => 'دوبارہ کوشش کریں',
        AppLanguage.english => 'Retry',
      };

  String get notificationsPerDay => switch (lang) {
        AppLanguage.arabic => 'إشعارات يومياً',
        AppLanguage.urdu => 'روزانہ اطلاعات',
        AppLanguage.english => 'Notifications per day',
      };

  String get notSelected => switch (lang) {
        AppLanguage.arabic => 'لم يُحدَّد',
        AppLanguage.urdu => 'منتخب نہیں',
        AppLanguage.english => 'Not selected',
      };

  String get refreshWidgets => switch (lang) {
        AppLanguage.arabic => 'تحديث الأدوات',
        AppLanguage.urdu => 'ویجٹ تازہ کریں',
        AppLanguage.english => 'Refresh widgets',
      };

  /// Formats hour + minute as a localised 12-hour time string, e.g.
  /// English: "9:05 AM", Arabic: "٩:٠٥ ص", Urdu: "٩:٠٥ ص"
  ///
  /// Optimised: reuses toLocalNum for both hour and the zero-padded minute
  /// instead of duplicating the digit-map inline.
  String formatReminderTime(int hour, int minute) {
    final h12 = hour % 12 == 0 ? 12 : hour % 12;
    final amPm = hour < 12;
    switch (lang) {
      case AppLanguage.english:
        final min = minute.toString().padLeft(2, '0');
        return '$h12:$min ${amPm ? 'AM' : 'PM'}';
      case AppLanguage.arabic:
        final min = toLocalNum(minute ~/ 10) + toLocalNum(minute % 10);
        return '${toLocalNum(h12)}:$min ${amPm ? 'ص' : 'م'}';
      case AppLanguage.urdu:
        final min = toLocalNum(minute ~/ 10) + toLocalNum(minute % 10);
        return '${toLocalNum(h12)}:$min ${amPm ? 'ص' : 'م'}';
    }
  }
  String get notifPlayingNow => switch (lang) {
        AppLanguage.arabic => 'يُشغَّل الآن',
        AppLanguage.urdu => 'ابھی چل رہا ہے',
        AppLanguage.english => 'Playing now',
      };

  String get notifPaused => switch (lang) {
        AppLanguage.arabic => 'متوقف',
        AppLanguage.urdu => 'رکا ہوا',
        AppLanguage.english => 'Paused',
      };

  String get notifActionPlay => switch (lang) {
        AppLanguage.arabic => 'تشغيل',
        AppLanguage.urdu => 'چلائیں',
        AppLanguage.english => 'Play',
      };

  String get notifActionPause => switch (lang) {
        AppLanguage.arabic => 'إيقاف مؤقت',
        AppLanguage.urdu => 'روکیں',
        AppLanguage.english => 'Pause',
      };

  // ── Dark mode (reader) ─────────────────────────────────────────────────────────
  String get darkMode => switch (lang) {
        AppLanguage.arabic => 'الوضع الداكن',
        AppLanguage.urdu => 'ڈارک موڈ',
        AppLanguage.english => 'Dark Mode',
      };
  String get darkModeDesc => switch (lang) {
        AppLanguage.arabic => 'عكس ألوان صفحة القرآن مع الحفاظ على ألوان التجويد',
        AppLanguage.urdu => 'قرآن کے صفحے کے رنگ الٹائیں، تجوید کے رنگ محفوظ رہیں گے',
        AppLanguage.english => 'Invert page colours while preserving tajweed markers',
      };

  // ── Test notification ────────────────────────────────────────────────────────
  String get testNotifTitle => switch (lang) {
        AppLanguage.arabic => 'إشعار تجريبي',
        AppLanguage.urdu => 'ٹیسٹ اطلاع',
        AppLanguage.english => 'Test Notification',
      };

  String get testNotifBody => switch (lang) {
        AppLanguage.arabic => 'إذا رأيت هذا، فالإشعارات تعمل! ✓',
        AppLanguage.urdu => 'اگر آپ یہ دیکھ رہے ہیں تو اطلاعات کام کر رہی ہیں! ✓',
        AppLanguage.english => 'If you see this, notifications are working! ✓',
      };

  // ── Daily reminder notification ──────────────────────────────────────────────
  String reminderTitle(int index, int total) => switch (lang) {
        AppLanguage.arabic => total > 1
            ? 'تذكير ${toLocalNum(index)}/${toLocalNum(total)}'
            : 'حان وقت قراءة القرآن',
        AppLanguage.urdu => total > 1
            ? 'یاددہانی ${toLocalNum(index)}/${toLocalNum(total)}'
            : 'قرآن پڑھنے کا وقت ہو گیا',
        AppLanguage.english => total > 1
            ? 'Reminder $index/$total'
            : 'Time to read Quran',
      };

  String get reminderBody => switch (lang) {
        AppLanguage.arabic => 'تلاوتك القرآنية اليومية في انتظارك 📖',
        AppLanguage.urdu => 'آپ کی روزانہ قرآن تلاوت انتظار میں ہے 📖',
        AppLanguage.english => 'Your daily Quran reading awaits 📖',
      };
}

// ─── App State ─────────────────────────────────────────────────────────────────

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();

  AppState._();

  AppLanguage _language = AppLanguage.english;
  AppLanguage get language => _language;
  // Cached L10n — recreated only when language actually changes.
  L10n _l = const L10n(AppLanguage.english);
  L10n get l => _l;

  // ── Dark mode (reader) ─────────────────────────────────────────────────────
  bool _darkMode = true;
  bool get darkMode => _darkMode;

  Future<void> loadDarkMode() async {
    final p = await SharedPreferences.getInstance();
    _darkMode = p.getBool('reader_dark_mode') ?? true;
  }

  Future<void> setDarkMode(bool value) async {
    if (_darkMode == value) return;
    _darkMode = value;
    final p = await SharedPreferences.getInstance();
    await p.setBool('reader_dark_mode', value);
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    final p = await SharedPreferences.getInstance();
    final stored = p.getString('app_language') ?? 'english';

    _language = AppLanguage.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => AppLanguage.english,
    );
    _l = L10n(_language);
    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage lang) async {
    if (_language == lang) return;
    _language = lang;
    _l = L10n(_language);
    final p = await SharedPreferences.getInstance();
    await p.setString('app_language', lang.name);

    // Refresh all widgets immediately when language changes
    try {
      await HomeWidget.updateWidget(androidName: 'QuranWidgetProvider');
      await HomeWidget.updateWidget(androidName: 'QuranWidgetProviderLarge');
      await HomeWidget.updateWidget(androidName: 'AyahWidgetProvider');
      const platform = MethodChannel('com.abuhashim.khalafquran/widget');
      await platform.invokeMethod('scheduleWidgetUpdate');
    } catch (_) {}

    notifyListeners();
  }
}

// ─── Helpers ───────────────────────────────────────────────────────────────────

/// Converts a SAF content URI returned by FilePicker on Android into a real
/// filesystem path that File() and Dio can use.
///
/// Android's Storage Access Framework returns URIs like:
///   content://com.android.externalstorage.documents/tree/primary%3ADownload
///   content://com.android.externalstorage.documents/tree/1A2B-3C4D%3ADCIM
///
/// The volume before the colon is either "primary" (→ /storage/emulated/0)
/// or the SD-card UUID (→ /storage/UUID).
String? _safUriToPath(String uri) {
  const prefix = 'content://com.android.externalstorage.documents/tree/';
  if (!uri.startsWith(prefix)) return null;
  try {
    final treeId = Uri.decodeComponent(uri.substring(prefix.length));
    final sep = treeId.indexOf(':');
    if (sep == -1) return null;
    final volume = treeId.substring(0, sep);
    final relative = treeId.substring(sep + 1);
    final root =
        volume == 'primary' ? '/storage/emulated/0' : '/storage/$volume';
    return relative.isEmpty ? root : '$root/$relative';
  } catch (_) {
    return null;
  }
}

// Pre-built lookup table: Quran page (1–604) → surah index in kSurahs.
// Built lazily on first call and reused forever (114 surahs, 604 pages).
List<int>? _surahIndexForPageTable;

List<int> _buildSurahTable() {
  final table = List<int>.filled(605, 0); // index 0 unused; pages 1-604
  var surahIdx = 0;
  for (var page = 1; page <= 604; page++) {
    // Advance to the last surah whose start page <= current page.
    while (surahIdx + 1 < kSurahs.length &&
        (kSurahs[surahIdx + 1]['page'] as int) <= page) {
      surahIdx++;
    }
    table[page] = surahIdx;
  }
  return table;
}

String surahNameForPage(int page, [AppLanguage lang = AppLanguage.english]) {
  final safePage = page.clamp(1, 604);
  final table = _surahIndexForPageTable ??= _buildSurahTable();
  final surah = kSurahs[table[safePage]];
  return lang == AppLanguage.english
      ? surah['english'] as String
      : surah['arabic'] as String;
}

const List<String> kJuzNames = [
  'Alif Lam Mim',
  'Sayaqul',
  'Tilka\'r-Rusul',
  'Lan Tana\'lu',
  'Wal Muhsanat',
  'La Yuhibbullah',
  'Wa Idha Samiu',
  'Wa Law Annana',
  'Qalal Mala\'u',
  'Wa Alamu',
  'Yatadhiru',
  'Wa Ma Min Dabbah',
  'Wa Ma Ubarri\'u',
  'Rubama',
  'Subhanalladhi',
  'Qal Alam',
  'Iqtaraba',
  'Qad Aflaha',
  'Wa Qalal Ladhina',
  'Amman Khalaqa',
  'Utlu Ma Uhiya',
  'Wa Man Yaqnut',
  'Wa Mali',
  'Fa Man Azlam',
  'Ilayhi Yuraddu',
  'Ha Mim',
  'Qala Fa Ma Khatbukum',
  'Qad Sami\'allah',
  'Tabaraka\'lladhi',
  'Juz Amma',
];

// ─── Data ──────────────────────────────────────────────────────────────────────

const List<Map<String, dynamic>> kJuz = [
  {"juz": 1, "page": 1, "arabic": "الم"},
  {"juz": 2, "page": 22, "arabic": "سيقول"},
  {"juz": 3, "page": 42, "arabic": "تلك الرسل"},
  {"juz": 4, "page": 62, "arabic": "لن تنالوا"},
  {"juz": 5, "page": 82, "arabic": "والمحصنات"},
  {"juz": 6, "page": 102, "arabic": "لا يحب الله"},
  {"juz": 7, "page": 121, "arabic": "وإذا سمعوا"},
  {"juz": 8, "page": 142, "arabic": "ولو أننا"},
  {"juz": 9, "page": 162, "arabic": "قال الملأ"},
  {"juz": 10, "page": 182, "arabic": "واعلموا"},
  {"juz": 11, "page": 201, "arabic": "يعتذرون"},
  {"juz": 12, "page": 222, "arabic": "وما من دابة"},
  {"juz": 13, "page": 242, "arabic": "وما أبرئ"},
  {"juz": 14, "page": 262, "arabic": "ربما"},
  {"juz": 15, "page": 282, "arabic": "سبحان الذي"},
  {"juz": 16, "page": 302, "arabic": "قال ألم"},
  {"juz": 17, "page": 322, "arabic": "اقترب"},
  {"juz": 18, "page": 342, "arabic": "قد أفلح"},
  {"juz": 19, "page": 362, "arabic": "وقال الذين"},
  {"juz": 20, "page": 382, "arabic": "أمن خلق"},
  {"juz": 21, "page": 402, "arabic": "اتل ما أوحي"},
  {"juz": 22, "page": 422, "arabic": "ومن يقنت"},
  {"juz": 23, "page": 442, "arabic": "وما لي"},
  {"juz": 24, "page": 462, "arabic": "فمن أظلم"},
  {"juz": 25, "page": 482, "arabic": "إليه يرد"},
  {"juz": 26, "page": 502, "arabic": "حم"},
  {"juz": 27, "page": 522, "arabic": "قال فما خطبكم"},
  {"juz": 28, "page": 542, "arabic": "قد سمع"},
  {"juz": 29, "page": 562, "arabic": "تبارك"},
  {"juz": 30, "page": 582, "arabic": "عم"},
];

// 60 hizbos — each entry is the first page of that hizb.
// Page boundaries are approximate mid-juz values for the 604-page Uthmani mushaf.
const List<Map<String, dynamic>> kHizb = [
  {"hizb": 1, "juz": 1, "page": 1},
  {"hizb": 2, "juz": 1, "page": 11},
  {"hizb": 3, "juz": 2, "page": 22},
  {"hizb": 4, "juz": 2, "page": 32},
  {"hizb": 5, "juz": 3, "page": 42},
  {"hizb": 6, "juz": 3, "page": 52},
  {"hizb": 7, "juz": 4, "page": 62},
  {"hizb": 8, "juz": 4, "page": 72},
  {"hizb": 9, "juz": 5, "page": 82},
  {"hizb": 10, "juz": 5, "page": 92},
  {"hizb": 11, "juz": 6, "page": 102},
  {"hizb": 12, "juz": 6, "page": 112},
  {"hizb": 13, "juz": 7, "page": 121},
  {"hizb": 14, "juz": 7, "page": 131},
  {"hizb": 15, "juz": 8, "page": 142},
  {"hizb": 16, "juz": 8, "page": 152},
  {"hizb": 17, "juz": 9, "page": 162},
  {"hizb": 18, "juz": 9, "page": 172},
  {"hizb": 19, "juz": 10, "page": 182},
  {"hizb": 20, "juz": 10, "page": 192},
  {"hizb": 21, "juz": 11, "page": 201},
  {"hizb": 22, "juz": 11, "page": 211},
  {"hizb": 23, "juz": 12, "page": 222},
  {"hizb": 24, "juz": 12, "page": 232},
  {"hizb": 25, "juz": 13, "page": 242},
  {"hizb": 26, "juz": 13, "page": 252},
  {"hizb": 27, "juz": 14, "page": 262},
  {"hizb": 28, "juz": 14, "page": 272},
  {"hizb": 29, "juz": 15, "page": 282},
  {"hizb": 30, "juz": 15, "page": 292},
  {"hizb": 31, "juz": 16, "page": 302},
  {"hizb": 32, "juz": 16, "page": 312},
  {"hizb": 33, "juz": 17, "page": 322},
  {"hizb": 34, "juz": 17, "page": 332},
  {"hizb": 35, "juz": 18, "page": 342},
  {"hizb": 36, "juz": 18, "page": 352},
  {"hizb": 37, "juz": 19, "page": 362},
  {"hizb": 38, "juz": 19, "page": 372},
  {"hizb": 39, "juz": 20, "page": 382},
  {"hizb": 40, "juz": 20, "page": 392},
  {"hizb": 41, "juz": 21, "page": 402},
  {"hizb": 42, "juz": 21, "page": 412},
  {"hizb": 43, "juz": 22, "page": 422},
  {"hizb": 44, "juz": 22, "page": 432},
  {"hizb": 45, "juz": 23, "page": 442},
  {"hizb": 46, "juz": 23, "page": 452},
  {"hizb": 47, "juz": 24, "page": 462},
  {"hizb": 48, "juz": 24, "page": 472},
  {"hizb": 49, "juz": 25, "page": 482},
  {"hizb": 50, "juz": 25, "page": 492},
  {"hizb": 51, "juz": 26, "page": 502},
  {"hizb": 52, "juz": 26, "page": 512},
  {"hizb": 53, "juz": 27, "page": 522},
  {"hizb": 54, "juz": 27, "page": 532},
  {"hizb": 55, "juz": 28, "page": 542},
  {"hizb": 56, "juz": 28, "page": 552},
  {"hizb": 57, "juz": 29, "page": 562},
  {"hizb": 58, "juz": 29, "page": 572},
  {"hizb": 59, "juz": 30, "page": 582},
  {"hizb": 60, "juz": 30, "page": 594},
];

const List<Map<String, dynamic>> kSurahs = [
  {"number": 1, "arabic": "الفاتحة", "english": "Al-Fatihah", "page": 1},
  {"number": 2, "arabic": "البقرة", "english": "Al-Baqarah", "page": 2},
  {"number": 3, "arabic": "آل عمران", "english": "Al-e-'Imran", "page": 50},
  {"number": 4, "arabic": "النساء", "english": "An-Nisa", "page": 77},
  {"number": 5, "arabic": "المائدة", "english": "Al-Ma'idah", "page": 106},
  {"number": 6, "arabic": "الأنعام", "english": "Al-An'am", "page": 128},
  {"number": 7, "arabic": "الأعراف", "english": "Al-A'raf", "page": 151},
  {"number": 8, "arabic": "الأنفال", "english": "Al-Anfal", "page": 177},
  {"number": 9, "arabic": "التوبة", "english": "At-Tawbah", "page": 187},
  {"number": 10, "arabic": "يونس", "english": "Yunus", "page": 208},
  {"number": 11, "arabic": "هود", "english": "Hud", "page": 221},
  {"number": 12, "arabic": "يوسف", "english": "Yusuf", "page": 235},
  {"number": 13, "arabic": "الرعد", "english": "Ar-Ra'd", "page": 249},
  {"number": 14, "arabic": "إبراهيم", "english": "Ibrahim", "page": 255},
  {"number": 15, "arabic": "الحجر", "english": "Al-Hijr", "page": 262},
  {"number": 16, "arabic": "النحل", "english": "An-Nahl", "page": 267},
  {"number": 17, "arabic": "الإسراء", "english": "Al-Isra", "page": 282},
  {"number": 18, "arabic": "الكهف", "english": "Al-Kahf", "page": 293},
  {"number": 19, "arabic": "مريم", "english": "Maryam", "page": 305},
  {"number": 20, "arabic": "طه", "english": "Ta-Ha", "page": 312},
  {"number": 21, "arabic": "الأنبياء", "english": "Al-Anbiya", "page": 322},
  {"number": 22, "arabic": "الحج", "english": "Al-Hajj", "page": 332},
  {"number": 23, "arabic": "المؤمنون", "english": "Al-Mu'minun", "page": 342},
  {"number": 24, "arabic": "النور", "english": "An-Nur", "page": 350},
  {"number": 25, "arabic": "الفرقان", "english": "Al-Furqan", "page": 359},
  {"number": 26, "arabic": "الشعراء", "english": "Ash-Shu'ara", "page": 367},
  {"number": 27, "arabic": "النمل", "english": "An-Naml", "page": 377},
  {"number": 28, "arabic": "القصص", "english": "Al-Qasas", "page": 385},
  {"number": 29, "arabic": "العنكبوت", "english": "Al-'Ankabut", "page": 396},
  {"number": 30, "arabic": "الروم", "english": "Ar-Rum", "page": 404},
  {"number": 31, "arabic": "لقمان", "english": "Luqman", "page": 411},
  {"number": 32, "arabic": "السجدة", "english": "As-Sajdah", "page": 415},
  {"number": 33, "arabic": "الأحزاب", "english": "Al-Ahzab", "page": 418},
  {"number": 34, "arabic": "سبأ", "english": "Saba", "page": 428},
  {"number": 35, "arabic": "فاطر", "english": "Fatir", "page": 434},
  {"number": 36, "arabic": "يس", "english": "Ya-Sin", "page": 440},
  {"number": 37, "arabic": "الصافات", "english": "As-Saffat", "page": 446},
  {"number": 38, "arabic": "ص", "english": "Sad", "page": 453},
  {"number": 39, "arabic": "الزمر", "english": "Az-Zumar", "page": 458},
  {"number": 40, "arabic": "غافر", "english": "Ghafir", "page": 467},
  {"number": 41, "arabic": "فصلت", "english": "Fussilat", "page": 477},
  {"number": 42, "arabic": "الشورى", "english": "Ash-Shura", "page": 483},
  {"number": 43, "arabic": "الزخرف", "english": "Az-Zukhruf", "page": 489},
  {"number": 44, "arabic": "الدخان", "english": "Ad-Dukhan", "page": 496},
  {"number": 45, "arabic": "الجاثية", "english": "Al-Jathiyah", "page": 499},
  {"number": 46, "arabic": "الأحقاف", "english": "Al-Ahqaf", "page": 502},
  {"number": 47, "arabic": "محمد", "english": "Muhammad", "page": 507},
  {"number": 48, "arabic": "الفتح", "english": "Al-Fath", "page": 511},
  {"number": 49, "arabic": "الحجرات", "english": "Al-Hujurat", "page": 515},
  {"number": 50, "arabic": "ق", "english": "Qaf", "page": 518},
  {"number": 51, "arabic": "الذاريات", "english": "Adh-Dhariyat", "page": 520},
  {"number": 52, "arabic": "الطور", "english": "At-Tur", "page": 523},
  {"number": 53, "arabic": "النجم", "english": "An-Najm", "page": 526},
  {"number": 54, "arabic": "القمر", "english": "Al-Qamar", "page": 528},
  {"number": 55, "arabic": "الرحمن", "english": "Ar-Rahman", "page": 531},
  {"number": 56, "arabic": "الواقعة", "english": "Al-Waqi'ah", "page": 534},
  {"number": 57, "arabic": "الحديد", "english": "Al-Hadid", "page": 537},
  {"number": 58, "arabic": "المجادلة", "english": "Al-Mujadila", "page": 542},
  {"number": 59, "arabic": "الحشر", "english": "Al-Hashr", "page": 545},
  {"number": 60, "arabic": "الممتحنة", "english": "Al-Mumtahanah", "page": 549},
  {"number": 61, "arabic": "الصف", "english": "As-Saf", "page": 551},
  {"number": 62, "arabic": "الجمعة", "english": "Al-Jumu'ah", "page": 553},
  {"number": 63, "arabic": "المنافقون", "english": "Al-Munafiqun", "page": 554},
  {"number": 64, "arabic": "التغابن", "english": "At-Taghabun", "page": 556},
  {"number": 65, "arabic": "الطلاق", "english": "At-Talaq", "page": 558},
  {"number": 66, "arabic": "التحريم", "english": "At-Tahrim", "page": 560},

  {"number": 67, "arabic": "الملك", "english": "Al-Mulk", "page": 562},
  {"number": 68, "arabic": "القلم", "english": "Al-Qalam", "page": 564},
  {"number": 69, "arabic": "الحاقة", "english": "Al-Haqqah", "page": 566},
  {"number": 70, "arabic": "المعارج", "english": "Al-Ma'arij", "page": 568},
  {"number": 71, "arabic": "نوح", "english": "Nuh", "page": 570},
  {"number": 72, "arabic": "الجن", "english": "Al-Jinn", "page": 572},
  {"number": 73, "arabic": "المزمل", "english": "Al-Muzzammil", "page": 574},
  {"number": 74, "arabic": "المدثر", "english": "Al-Muddaththir", "page": 575},
  {"number": 75, "arabic": "القيامة", "english": "Al-Qiyamah", "page": 577},
  {"number": 76, "arabic": "الإنسان", "english": "Al-Insaan", "page": 578},
  {"number": 77, "arabic": "المرسلات", "english": "Al-Mursalat", "page": 580},
  {"number": 78, "arabic": "النبأ", "english": "An-Naba", "page": 582},
  {"number": 79, "arabic": "النازعات", "english": "An-Nazi'at", "page": 583},
  {"number": 80, "arabic": "عبس", "english": "Abasa", "page": 585},
  {"number": 81, "arabic": "التكوير", "english": "At-Takwir", "page": 586},
  {"number": 82, "arabic": "الانفطار", "english": "Al-Infitar", "page": 587},
  {"number": 83, "arabic": "المطففين", "english": "Al-Mutaffifin", "page": 587},
  {"number": 84, "arabic": "الانشقاق", "english": "Al-Inshiqaq", "page": 589},
  {"number": 85, "arabic": "البروج", "english": "Al-Buruj", "page": 590},
  {"number": 86, "arabic": "الطارق", "english": "At-Tariq", "page": 591},
  {"number": 87, "arabic": "الأعلى", "english": "Al-A'la", "page": 591},
  {"number": 88, "arabic": "الغاشية", "english": "Al-Ghashiyah", "page": 592},
  {"number": 89, "arabic": "الفجر", "english": "Al-Fajr", "page": 593},
  {"number": 90, "arabic": "البلد", "english": "Al-Balad", "page": 594},
  {"number": 91, "arabic": "الشمس", "english": "Ash-Shams", "page": 595},
  {"number": 92, "arabic": "الليل", "english": "Al-Layl", "page": 595},
  {"number": 93, "arabic": "الضحى", "english": "Ad-Duha", "page": 596},
  {"number": 94, "arabic": "الشرح", "english": "Ash-Sharh", "page": 596},
  {"number": 95, "arabic": "التين", "english": "At-Tin", "page": 597},
  {"number": 96, "arabic": "العلق", "english": "Al-'Alaq", "page": 597},
  {"number": 97, "arabic": "القدر", "english": "Al-Qadr", "page": 598},
  {"number": 98, "arabic": "البينة", "english": "Al-Bayyinah", "page": 598},
  {"number": 99, "arabic": "الزلزلة", "english": "Az-Zalzalah", "page": 599},
  {"number": 100, "arabic": "العاديات", "english": "Al-'Adiyat", "page": 599},
  {"number": 101, "arabic": "القارعة", "english": "Al-Qari'ah", "page": 600},
  {"number": 102, "arabic": "التكاثر", "english": "At-Takathur", "page": 600},
  {"number": 103, "arabic": "العصر", "english": "Al-'Asr", "page": 601},
  {"number": 104, "arabic": "الهمزة", "english": "Al-Humazah", "page": 601},
  {"number": 105, "arabic": "الفيل", "english": "Al-Fil", "page": 601},
  {"number": 106, "arabic": "قريش", "english": "Quraysh", "page": 602},
  {"number": 107, "arabic": "الماعون", "english": "Al-Ma'un", "page": 602},
  {"number": 108, "arabic": "الكوثر", "english": "Al-Kawthar", "page": 602},
  {"number": 109, "arabic": "الكافرون", "english": "Al-Kafirun", "page": 603},
  {"number": 110, "arabic": "النصر", "english": "An-Nasr", "page": 603},
  {"number": 111, "arabic": "المسد", "english": "Al-Masad", "page": 603},
  {"number": 112, "arabic": "الإخلاص", "english": "Al-Ikhlas", "page": 604},
  {"number": 113, "arabic": "الفلق", "english": "Al-Falaq", "page": 604},
  {"number": 114, "arabic": "الناس", "english": "An-Nas", "page": 604},
];

// ─── Constants ─────────────────────────────────────────────────────────────────

const _kGreen = Color(0xFF1B5E20);
const _kGreenLight = Color(0xFF81C784);
const _kGreenMid = Color(0xFF66BB6A);
const _kGreenLabel = Color(0xFF6FCF87);
const _kBgDeep = Color(0xFF0A140A);
const _kBgCard = Color(0xFF161C16);
const _kBgSheet = Color(0xFF091409);

// ── iOS Animation Curves ─────────────────────────────────────────────────────────
const iosStandard = Cubic(0.4, 0.0, 0.2, 1.0);
const iosEaseOut = Cubic(0.0, 0.0, 0.2, 1.0);
const iosSpring = Cubic(0.175, 0.885, 0.32, 1.275);
const iosDecelerate = Cubic(0.0, 0.0, 0.2, 1.0);

// ─── Entry point ───────────────────────────────────────────────────────────────

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await HomeWidget.setAppGroupId('com.abuhashim.khalafquran');
  }
  await AudioNotificationService.instance.initialize();
  await QuranAudioManager.instance.initialize();
  await AppState.instance.loadLanguage();
  await AppState.instance.loadDarkMode();

  // Save location for widget use
  unawaited(_saveLocationForWidget());

  // Schedule (or cancel) the daily reminder based on persisted setting.
  unawaited(AudioNotificationService.instance.scheduleDailyReminder());
  runApp(const QuranApp());
}

Future<void> _saveLocationForWidget() async {
  // Manual location selection is used; no automatic location fetching needed.
}

Future<void> _updateWidgetPrayerTimes() async {
  if (!Platform.isAndroid && !Platform.isIOS) return;
  try {
    await HomeWidget.updateWidget(androidName: 'QuranWidgetProvider');
    await HomeWidget.updateWidget(androidName: 'QuranWidgetProviderLarge');

    // Update iOS widgets by their 'kind' identifiers
    await HomeWidget.updateWidget(iOSName: 'com.abuhashim.khalafquran.quranwidget.small');
    await HomeWidget.updateWidget(iOSName: 'com.abuhashim.khalafquran.quranwidget.large');
    await HomeWidget.updateWidget(iOSName: 'com.abuhashim.khalafquran.ayahwidget');
  } catch (e) {
    debugPrint('QuranApp: Error updating widget: $e');
  }
}

// ─── App ───────────────────────────────────────────────────────────────────────

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  Timer? _widgetUpdateTimer;

  @override
  void initState() {
    super.initState();
    AppState.instance.addListener(_rebuild);

    // Update widget with current prayer times immediately
    unawaited(_updateWidgetPrayerTimes());

    // Set up periodic updates every minute when app is running
    _widgetUpdateTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      unawaited(_updateWidgetPrayerTimes());
    });
  }

  @override
  void dispose() {
    AppState.instance.removeListener(_rebuild);
    _widgetUpdateTimer?.cancel();
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'قرآن خلف',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _kGreen,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ─── Splash ────────────────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  Timer? _navTimer;

  // ── Diamond ornament ─────────────────────────────────────────────────────────
  late final Animation<double> _diamondFade;
  late final Animation<double> _diamondScale;

  // ── Khaaf letter ─────────────────────────────────────────────────────────────
  late final Animation<double> _khaafFade;
  late final Animation<double> _khaafScale;

  // ── App name ─────────────────────────────────────────────────────────────────
  late final Animation<double> _nameFade;
  late final Animation<Offset> _nameSlide;

  // ── Riwayah subtitle ─────────────────────────────────────────────────────────
  late final Animation<double> _riwayahFade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Phase 1 — diamond grows in from small
    _diamondFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.4, curve: iosEaseOut),
    );
    _diamondScale = Tween<double>(begin: 0.28, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.45, curve: iosSpring),
      ),
    );

    // Phase 2 — Khaaf letter fades + scales in
    _khaafFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.2, 0.6, curve: iosEaseOut),
    );
    _khaafScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.2, 0.55, curve: iosSpring),
      ),
    );

    // Phase 3 — app name slides up and fades in
    _nameFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.4, 0.8, curve: iosEaseOut),
    );
    _nameSlide = Tween<Offset>(
      begin: const Offset(0, 0.22),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.4, 0.8, curve: iosStandard),
    ));

    // Phase 4 — riwayah follows name
    _riwayahFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.55, 0.95, curve: iosEaseOut),
    );

    _ctrl.forward();
    _navTimer = Timer(const Duration(milliseconds: 2000), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;

    final alreadyRequested = await PrefsService.hasRequestedPermissions();
    if (!alreadyRequested) {
      await _requestStartupPermissions();
      await PrefsService.markPermissionsRequested();
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SurahListScreen(),
        transitionsBuilder: (_, anim, __, child) {
          final curvedAnim = CurvedAnimation(parent: anim, curve: iosStandard);
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: const Interval(0.0, 0.3, curve: iosEaseOut)),
            ),
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(curvedAnim),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  Future<void> _requestStartupPermissions() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    // POST_NOTIFICATIONS (Android 13+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Storage for audio downloads (Android < 13)
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;
    return Scaffold(
      backgroundColor: const Color(0xFF0A140A),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Diamond + Khaaf ──────────────────────────────────────────────
            FadeTransition(
              opacity: _diamondFade,
              child: ScaleTransition(
                scale: _diamondScale,
                child: RepaintBoundary(
                  child: _SplashOrnament(
                    khaafFade: _khaafFade,
                    khaafScale: _khaafScale,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            // ── App name ─────────────────────────────────────────────────────
            FadeTransition(
              opacity: _nameFade,
              child: SlideTransition(
                position: _nameSlide,
                child: Text(
                  l.appName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Color(0x66000000),
                        blurRadius: 18,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // ── Riwayah ──────────────────────────────────────────────────────
            FadeTransition(
              opacity: _riwayahFade,
              child: Text(
                l.riwayah,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 15,
                  color: _kGreenMid,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashOrnament extends StatelessWidget {
  final Animation<double> khaafFade;
  final Animation<double> khaafScale;

  const _SplashOrnament({
    required this.khaafFade,
    required this.khaafScale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Diamond rings with soft glow
          const CustomPaint(
            size: Size(90, 90),
            painter: _DiamondPainter(),
          ),
          // Khaaf letter — inspired by the about tile
          FadeTransition(
            opacity: khaafFade,
            child: ScaleTransition(
              scale: khaafScale,
              child: const Text(
                'خ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Scheherazade New',
                  fontSize: 36,
                  color: Color(0xFF81C784),
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  shadows: [
                    Shadow(

                      color: Color(0xAA2E7D32),
                      blurRadius: 14,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  const _DiamondPainter();

  // Paths are size-dependent so we cache them per size.
  // Since the splash widget never resizes, these will be built exactly once.
  static Size? _cachedSize;
  static Path? _outerPath;
  static Path? _innerPath;

  static (Path outer, Path inner) _buildPaths(Size size) {
    if (_cachedSize == size && _outerPath != null && _innerPath != null) {
      return (_outerPath!, _innerPath!);
    }
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.22;
    _outerPath = Path()
      ..moveTo(cx, 3)
      ..lineTo(size.width - 3, cy)
      ..lineTo(cx, size.height - 3)
      ..lineTo(3, cy)
      ..close();
    _innerPath = Path()
      ..moveTo(cx, cy - r)
      ..lineTo(cx + r, cy)
      ..lineTo(cx, cy + r)
      ..lineTo(cx - r, cy)
      ..close();
    _cachedSize = size;
    return (_outerPath!, _innerPath!);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final (outerPath, innerPath) = _buildPaths(size);

    // ── Outer diamond glow ───────────────────────────────────────────────────
    final outerGlow = Paint()
      ..color = const Color(0xFF2E7D32).withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
    canvas.drawPath(outerPath, outerGlow);

    // ── Outer diamond stroke ─────────────────────────────────────────────────
    final outer = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(outerPath, outer);

    // ── Inner diamond glow ───────────────────────────────────────────────────
    final innerGlow = Paint()
      ..color = _kGreen.withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(innerPath, innerGlow);

    // ── Inner diamond stroke ─────────────────────────────────────────────────
    final inner = Paint()
      ..color = _kGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(innerPath, inner);
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}

/// Stroke-only, faded diamond ornament used for the empty search state.
class _FadedDiamondPainter extends CustomPainter {
  const _FadedDiamondPainter();

  // Size-keyed path cache (same sizing logic as _DiamondPainter).
  static Size? _cachedSize;
  static Path? _outerPath;
  static Path? _innerPath;

  static (Path outer, Path inner) _buildPaths(Size size) {
    if (_cachedSize == size && _outerPath != null && _innerPath != null) {
      return (_outerPath!, _innerPath!);
    }
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.22;
    _outerPath = Path()
      ..moveTo(cx, 3)
      ..lineTo(size.width - 3, cy)
      ..lineTo(cx, size.height - 3)
      ..lineTo(3, cy)
      ..close();
    _innerPath = Path()
      ..moveTo(cx, cy - r)
      ..lineTo(cx + r, cy)
      ..lineTo(cx, cy + r)
      ..lineTo(cx - r, cy)
      ..close();
    _cachedSize = size;
    return (_outerPath!, _innerPath!);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final (outerPath, innerPath) = _buildPaths(size);

    // Outer diamond — faded stroke only
    final outer = Paint()
      ..color = const Color(0xFF2E7D32).withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(outerPath, outer);

    // Outer glow
    final outerGlow = Paint()
      ..color = const Color(0xFF2E7D32).withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawPath(outerPath, outerGlow);

    // Inner diamond
    final inner = Paint()
      ..color = _kGreen.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawPath(innerPath, inner);
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}

// ─── Preferences ──────────────────────────────────────────────────────────────

class PrefsService {
  PrefsService._();

  // ── Cached SharedPreferences instance ─────────────────────────────────────
  static SharedPreferences? _prefs;
  static Future<SharedPreferences> get _p async =>
      _prefs ??= await SharedPreferences.getInstance();
  // Same-file accessor for ReadingStatsService and other services in this file
  static Future<SharedPreferences> get sharedPrefs => _p;

  static const _lastPageKey = 'last_page';
  static const _lastSurahKey = 'last_surah';
  static const _bookmarksKey = 'bookmarks';
  static const _audioBaseUrlKey = 'audio_base_url';
  static const _maxDpiKey = 'max_dpi';
  static const _dailyGoalMinutesKey = 'daily_goal_minutes';
  static const _totalGoalHoursKey = 'total_goal_hours';

  // ── Daily reminder constants ───────────────────────────────────────────────
  static const _dailyReminderEnabledKey = 'daily_reminder_enabled';
  static const _dailyReminderHourKey = 'daily_reminder_hour';
  static const _dailyReminderMinuteKey = 'daily_reminder_minute';
  static const _reminderCountKey = 'daily_reminder_count';
  static const int defaultReminderHour = 9;
  static const int defaultReminderMinute = 0;
  static const int defaultReminderCount = 1;

  // ── Bookmark labels ────────────────────────────────────────────────────────
  static const _bookmarkLabelsKey = 'bookmark_labels_json';

  // ── First-launch permissions ───────────────────────────────────────────────
  static const _kPermissionsRequested = 'permissions_requested';

  static Future<bool> hasRequestedPermissions() async {
    final p = await _p;
    return p.getBool(_kPermissionsRequested) ?? false;
  }

  static Future<void> markPermissionsRequested() async {
    final p = await _p;
    await p.setBool(_kPermissionsRequested, true);
  }

  // ── Audio position memory ──────────────────────────────────────────────────
  static const _audioPositionSurahKey = 'audio_pos_surah';
  static const _audioPositionMsKey = 'audio_pos_ms';

  static Future<void> saveAudioPosition(int surahNum, Duration position) async {
    if (position.inSeconds < 3) return;
    final p = await _p;
    await p.setInt(_audioPositionSurahKey, surahNum);
    await p.setInt(_audioPositionMsKey, position.inMilliseconds);
  }

  static Future<({int surah, Duration position})?>
      getSavedAudioPosition() async {
    final p = await _p;
    final surah = p.getInt(_audioPositionSurahKey);
    final ms = p.getInt(_audioPositionMsKey);
    if (surah == null || ms == null) return null;
    return (surah: surah, position: Duration(milliseconds: ms));
  }

  static Future<void> clearAudioPosition() async {
    final p = await _p;
    await p.remove(_audioPositionSurahKey);
    await p.remove(_audioPositionMsKey);
  }

  static const int defaultDailyGoalMinutes = 30;
  static const int defaultTotalGoalHours = 100;

  static const String defaultAudioBaseUrl =
      'https://github.com/deccandewan/khalafquran-audio/releases/download/1.0';

  static const int defaultMaxDpi = 420;

  // ── Dark mode (reader) — delegated to AppState for reactivity ─────────────
  // Kept as thin wrappers for backward compatibility; AppState is the source
  // of truth so PdfScreen can listen via ChangeNotifier.
  static Future<bool> getDarkMode() async {
    final p = await _p;
    return p.getBool('reader_dark_mode') ?? false;
  }
  static Future<void> saveDarkMode(bool value) async {
    final p = await _p;
    await p.setBool('reader_dark_mode', value);
  }

  static Future<void> saveLastRead(int page, String surahName) async {
    final p = await _p;
    await p.setInt(_lastPageKey, page);
    await p.setString(_lastSurahKey, surahName);
  }

  static Future<Map<String, dynamic>?> getLastRead() async {
    final p = await _p;
    final page = p.getInt(_lastPageKey);
    if (page == null) return null;
    return {'page': page, 'surah': p.getString(_lastSurahKey) ?? ''};
  }

  static Future<List<int>> getBookmarks() async {
    final p = await _p;
    return (p.getStringList(_bookmarksKey) ?? [])
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList()
      ..sort();
  }

  static Future<void> toggleBookmark(int page) async {
    final p = await _p;
    final bookmarks = await getBookmarks();
    if (bookmarks.contains(page)) {
      bookmarks.remove(page);
    } else {
      bookmarks.add(page);
    }
    await p.setStringList(
        _bookmarksKey, bookmarks.map((e) => e.toString()).toList());
  }

  static Future<bool> isBookmarked(int page) async =>
      (await getBookmarks()).contains(page);

  static Future<Map<int, String>> getBookmarkLabels() async {
    final p = await _p;
    final json = p.getString(_bookmarkLabelsKey) ?? '{}';
    try {
      final raw = jsonDecode(json) as Map;
      return raw.map((k, v) => MapEntry(int.parse(k.toString()), v.toString()));
    } catch (_) {
      return {};
    }
  }

  static Future<void> setBookmarkLabel(int page, String label) async {
    final p = await _p;
    final labels = await getBookmarkLabels();
    final trimmed = label.trim();
    if (trimmed.isEmpty) {
      labels.remove(page);
    } else {
      labels[page] = trimmed;
    }
    await p.setString(
      _bookmarkLabelsKey,
      jsonEncode(labels.map((k, v) => MapEntry(k.toString(), v))),
    );
  }

  static Future<void> removeBookmarkLabel(int page) async {
    final p = await _p;
    final labels = await getBookmarkLabels();
    labels.remove(page);
    await p.setString(
      _bookmarkLabelsKey,
      jsonEncode(labels.map((k, v) => MapEntry(k.toString(), v))),
    );
  }

  static Future<String> getAudioBaseUrl() async {
    final p = await _p;
    return p.getString(_audioBaseUrlKey) ?? defaultAudioBaseUrl;
  }

  static Future<void> setAudioBaseUrl(String url) async {
    final p = await _p;
    await p.setString(_audioBaseUrlKey, url);
  }

  static Future<String> defaultAudioFolder() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/khalaf_audio';
  }

  static Future<String> effectiveAudioFolder() async {
    return defaultAudioFolder();
  }

  static Future<int> getMaxDpi() async {
    final p = await _p;
    return (p.getInt(_maxDpiKey) ?? defaultMaxDpi).clamp(150, 800);
  }

  static Future<void> setMaxDpi(int dpi) async {
    final p = await _p;
    await p.setInt(_maxDpiKey, dpi.clamp(150, 800));
  }

  static Future<int> getDailyGoalMinutes() async {
    final p = await _p;
    return p.getInt(_dailyGoalMinutesKey) ?? defaultDailyGoalMinutes;
  }

  static Future<void> setDailyGoalMinutes(int minutes) async {
    final p = await _p;
    await p.setInt(_dailyGoalMinutesKey, minutes.clamp(5, 480));
  }

  static Future<int> getTotalGoalHours() async {
    final p = await _p;
    return p.getInt(_totalGoalHoursKey) ?? defaultTotalGoalHours;
  }

  static Future<void> setTotalGoalHours(int hours) async {
    final p = await _p;
    await p.setInt(_totalGoalHoursKey, hours.clamp(1, 10000));
  }

  // Production-level: Daily reminder settings
  static Future<bool> isDailyReminderEnabled() async {
    final p = await _p;
    return p.getBool(_dailyReminderEnabledKey) ?? false;
  }

  static Future<void> setDailyReminderEnabled(bool enabled) async {
    final p = await _p;
    await p.setBool(_dailyReminderEnabledKey, enabled);
  }

  /// [index] is 1-based (1, 2, 3). Index 1 uses the legacy keys for backward compatibility.
  static Future<(int hour, int minute)> getReminderTime(int index) async {
    final p = await _p;
    final hourKey =
        index == 1 ? _dailyReminderHourKey : 'daily_reminder_${index}_hour';
    final minuteKey =
        index == 1 ? _dailyReminderMinuteKey : 'daily_reminder_${index}_minute';
    final hour = p.getInt(hourKey) ?? defaultReminderHour;
    final minute = p.getInt(minuteKey) ?? defaultReminderMinute;
    return (hour, minute);
  }

  /// [index] is 1-based (1, 2, 3).
  static Future<void> setReminderTime(int index, int hour, int minute) async {
    final p = await _p;
    final hourKey =
        index == 1 ? _dailyReminderHourKey : 'daily_reminder_${index}_hour';
    final minuteKey =
        index == 1 ? _dailyReminderMinuteKey : 'daily_reminder_${index}_minute';
    await p.setInt(hourKey, hour.clamp(0, 23));
    await p.setInt(minuteKey, minute.clamp(0, 59));
  }

  static Future<int> getReminderCount() async {
    final p = await _p;
    return (p.getInt(_reminderCountKey) ?? defaultReminderCount).clamp(1, 3);
  }

  static Future<void> setReminderCount(int count) async {
    final p = await _p;
    await p.setInt(_reminderCountKey, count.clamp(1, 3));
  }
}

// ─── Reading Stats ─────────────────────────────────────────────────────────────

class ReadingStatsService {
  ReadingStatsService._();

  static const _totalSecondsKey = 'reading_seconds';
  static const _lastReadDateKey = 'last_read_date';
  static const _streakKey = 'reading_streak';
  static const _todaySecondsKey = 'reading_seconds_today';
  static const _todayDateKey = 'reading_today_date';

  // Production-level: Track reading by date for calendar heatmap
  static const _readingHistoryKey = 'reading_history_json';

  // Production-level: Maximum reasonable reading session in one day (24 hours)
  static const _maxSessionSeconds = 86400;

  // ── In-memory cache for reading history (avoids repeated JSON decode) ─────
  static Map<String, int>? _historyCache;

  static Future<void> addReadingTime(Duration d) async {
    // Production-level: Validate input
    if (d.inSeconds < 2) return;
    if (d.inSeconds > _maxSessionSeconds) {
      debugPrint('Warning: Reading session too long, clamping to 24 hours');
      return; // Likely a device clock issue
    }

    try {
      final p = await PrefsService.sharedPrefs;
      final current = p.getInt(_totalSecondsKey) ?? 0;

      // Add to today's total and track date in calendar history
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final todayStr = today.toIso8601String().split('T')[0];
      final storedDate = p.getString(_todayDateKey) ?? '';
      final todayIso = today.toIso8601String();

      final int newTodaySeconds;
      if (storedDate == todayIso) {
        newTodaySeconds = (p.getInt(_todaySecondsKey) ?? 0) + d.inSeconds;
      } else {
        newTodaySeconds = d.inSeconds;
      }

      // Use cached history map to avoid repeated JSON decode
      if (_historyCache == null) {
        final historyJson = p.getString(_readingHistoryKey) ?? '{}';
        _historyCache = Map<String, int>.from(jsonDecode(historyJson) as Map);
      }
      _historyCache![todayStr] = (_historyCache![todayStr] ?? 0) + d.inSeconds;

      // Batch all writes together
      await Future.wait([
        p.setInt(_totalSecondsKey, current + d.inSeconds),
        p.setString(_todayDateKey, todayIso),
        p.setInt(_todaySecondsKey, newTodaySeconds),
        p.setString(_readingHistoryKey, jsonEncode(_historyCache)),
      ]);

      await _updateStreak(p);
    } catch (e) {
      debugPrint('Error adding reading time: $e');
    }
  }

  static Future<void> _updateStreak(SharedPreferences p) async {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final todayStr = today.toIso8601String().split('T')[0];
      final storedStr = p.getString(_lastReadDateKey);
      int streak = p.getInt(_streakKey) ?? 0;

      if (storedStr != null && storedStr.isNotEmpty) {
        try {
          // Parse as local date by splitting components — DateTime.parse on a
          // YYYY-MM-DD string returns UTC midnight, which gives wrong day
          // differences for users in timezones behind UTC.
          final parts = storedStr.split('-');
          final prev = DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
          final diff = today.difference(prev).inDays;
          if (diff == 0) return; // already updated today
          streak = diff == 1 ? streak + 1 : 1;
        } catch (e) {
          debugPrint('Error parsing date, resetting streak: $e');
          streak = 1;
        }
      } else {
        streak = 1;
      }

      await p.setString(_lastReadDateKey, todayStr);
      await p.setInt(_streakKey, streak.clamp(0, 999)); // Cap at 999 days
    } catch (e) {
      debugPrint('Error updating streak: $e');
    }
  }

  static Future<int> streak() async {
    try {
      final p = await PrefsService.sharedPrefs;
      return (p.getInt(_streakKey) ?? 0).clamp(0, 999);
    } catch (e) {
      debugPrint('Error reading streak: $e');
      return 0;
    }
  }

  static Future<Duration> totalTime() async {
    try {
      final p = await PrefsService.sharedPrefs;
      return Duration(
          seconds: (p.getInt(_totalSecondsKey) ?? 0).clamp(0, 999999999));
    } catch (e) {
      debugPrint('Error reading total time: $e');
      return Duration.zero;
    }
  }

  static Future<Duration> todayTime() async {
    try {
      final p = await PrefsService.sharedPrefs;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day).toIso8601String();
      final storedDate = p.getString(_todayDateKey) ?? '';

      if (storedDate == today) {
        return Duration(
            seconds:
                (p.getInt(_todaySecondsKey) ?? 0).clamp(0, _maxSessionSeconds));
      }
      return Duration.zero;
    } catch (e) {
      debugPrint('Error reading today time: $e');
      return Duration.zero;
    }
  }

  /// Batched read: all four stat values in a single SharedPreferences await.
  ///
  /// Previously each caller did streak() + totalTime() + todayTime() +
  /// getReadingHistory() in sequence — four separate prefs awaits.  This does
  /// one await and reads every key synchronously from the in-memory prefs
  /// object, then returns a named record so callers can destructure cleanly.
  static Future<({
    int streak,
    Duration totalTime,
    Duration todayTime,
    Map<String, int> history,
  })> getStats() async {
    try {
      final p = await PrefsService.sharedPrefs;

      final streakVal = (p.getInt(_streakKey) ?? 0).clamp(0, 999);
      final totalVal = Duration(
          seconds: (p.getInt(_totalSecondsKey) ?? 0).clamp(0, 999999999));

      final now = DateTime.now();
      final todayIso =
          DateTime(now.year, now.month, now.day).toIso8601String();
      final storedDate = p.getString(_todayDateKey) ?? '';
      final todayVal = storedDate == todayIso
          ? Duration(
              seconds: (p.getInt(_todaySecondsKey) ?? 0)
                  .clamp(0, _maxSessionSeconds))
          : Duration.zero;

      // Reuse in-memory history cache when available.
      if (_historyCache == null) {
        final json = p.getString(_readingHistoryKey) ?? '{}';
        _historyCache =
            Map<String, int>.from(jsonDecode(json) as Map);
      }
      final historyVal = Map<String, int>.from(_historyCache!);

      return (
        streak: streakVal,
        totalTime: totalVal,
        todayTime: todayVal,
        history: historyVal,
      );
    } catch (e) {
      debugPrint('Error reading stats: $e');
      return (
        streak: 0,
        totalTime: Duration.zero,
        todayTime: Duration.zero,
        history: <String, int>{},
      );
    }
  }

  /// Get which of the last 7 calendar days had reading sessions.
  /// Returns a list of DateTime objects for the past 7 days that had reading.
  /// Production-level: True calendar heatmap, not just streak fill-from-left.
  static Future<List<DateTime>> getLastSevenDaysWithReading() async {
    try {
      final p = await PrefsService.sharedPrefs;
      final historyJson = p.getString(_readingHistoryKey) ?? '{}';
      final history = Map<String, int>.from(jsonDecode(historyJson) as Map);

      final now = DateTime.now();
      final result = <DateTime>[];

      for (int i = 0; i < 7; i++) {
        final date =
            DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
        final dateStr = date.toIso8601String().split('T')[0];
        if (history.containsKey(dateStr) && history[dateStr]! > 0) {
          result.add(date);
        }
      }
      return result;
    } catch (e) {
      debugPrint('Error reading calendar history: $e');
      return [];
    }
  }

  static Future<void> reset() async {
    try {
      final p = await PrefsService.sharedPrefs;
      _historyCache = null; // invalidate in-memory cache
      await Future.wait([
        p.remove(_totalSecondsKey),
        p.remove(_lastReadDateKey),
        p.remove(_streakKey),
        p.remove(_todaySecondsKey),
        p.remove(_todayDateKey),
        p.remove(_readingHistoryKey),
      ]);
    } catch (e) {
      debugPrint('Error resetting stats: $e');
    }
  }

  /// Returns the full reading-history map: ISO-date string → seconds read that day.
  /// Used by the calendar heatmap to compute per-cell intensity.
  static Future<Map<String, int>> getReadingHistory() async {
    try {
      if (_historyCache != null) return Map<String, int>.from(_historyCache!);
      final p = await PrefsService.sharedPrefs;
      final json = p.getString(_readingHistoryKey) ?? '{}';
      _historyCache = Map<String, int>.from(jsonDecode(json) as Map);
      return Map<String, int>.from(_historyCache!);
    } catch (e) {
      debugPrint('Error reading history: $e');
      return {};
    }
  }
}

// ─── Audio Notification Service ────────────────────────────────────────────────

class AudioNotificationService {
  AudioNotificationService._();
  static final AudioNotificationService instance = AudioNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const String _channelId = 'khalaf_audio_channel';
  static const String _channelName = 'Khalaf Quran Audio';
  static const Duration _skipInterval = Duration(seconds: 10);

  // Throttle notification updates to at most once per second
  DateTime _lastNotificationSync = DateTime.fromMillisecondsSinceEpoch(0);

  bool get _isMobilePlatform => Platform.isAndroid || Platform.isIOS;

  Future<void> initialize() async {
    if (_initialized || !_isMobilePlatform) {
      _initialized = true;
      return;
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    // Request iOS permissions explicitly
    if (Platform.isIOS) {
      final bool? granted = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      debugPrint('iOS Notification Permissions Granted: $granted');
    }

    // Initialize timezone data so scheduled notifications fire at the correct
    // local time on every device regardless of timezone.
    tz_data.initializeTimeZones();

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    // Create main notification channel
    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: 'Khalaf Quran reminders and playback',
        importance: Importance.defaultImportance,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      ),
    );

    // Create high-importance channel for test notifications
    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        'test_channel_high',
        'Test Notifications',
        description: 'High priority test notifications',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
        enableLights: true,
      ),
    );

    _initialized = true;
  }

  // Static callback — safe to call singleton methods
  static void _onNotificationResponse(NotificationResponse response) {
    final svc = QuranAudioManager.instance;
    switch (response.actionId) {
      case 'toggle_play':
        svc.toggle();
      case 'skip_backward':
        svc.seekBackward(_skipInterval);
      case 'skip_forward':
        svc.seekForward(_skipInterval);
    }
  }

  static String _formatDuration(Duration value) {
    final m = value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> syncPlayback() async {
    if (!_initialized || !_isMobilePlatform) return;

    // Throttle: don't update the notification more than once per second
    final now = DateTime.now();
    if (now.difference(_lastNotificationSync).inMilliseconds < 1000) return;
    _lastNotificationSync = now;

    final currentSurah = QuranAudioManager.instance.currentSurah;
    if (currentSurah == null) {
      await hide();
      return;
    }

    final surah = kSurahs[currentSurah - 1];
    final lang = AppState.instance.language;
    final title = lang == AppLanguage.english
        ? surah['english'] as String
        : surah['arabic'] as String;
    final subtitle = surah['arabic'] as String;
    final isPlaying = QuranAudioManager.instance.player.playing;
    final position = QuranAudioManager.instance.position;
    final duration = QuranAudioManager.instance.duration;

    final progressLabel = duration == null
        ? _formatDuration(position)
        : '${_formatDuration(position)} / ${_formatDuration(duration)}';
    final progressPercent = (duration == null || duration.inMilliseconds <= 0)
        ? 0
        : ((position.inMilliseconds / duration.inMilliseconds) * 100)
            .clamp(0.0, 100.0)
            .round();

    try {
      final androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Playback controls for Quran recitation',
        importance: Importance.low,
        priority: Priority.low,
        styleInformation: const MediaStyleInformation(),
        showProgress: duration != null,
        maxProgress: 100,
        progress: progressPercent,
        ongoing: true,
        autoCancel: false,
        onlyAlertOnce: true,
        playSound: false,
        enableVibration: false,
        color: _kGreen,
        colorized: true,
        subText: isPlaying
            ? AppState.instance.l.notifPlayingNow
            : AppState.instance.l.notifPaused,
        actions: [
          const AndroidNotificationAction('skip_backward', '−10s'),
          AndroidNotificationAction(
              'toggle_play',
              isPlaying
                  ? AppState.instance.l.notifActionPause
                  : AppState.instance.l.notifActionPlay),
          const AndroidNotificationAction('skip_forward', '+10s'),
        ],
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      );
      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: false,
      );
      final details =
          NotificationDetails(android: androidDetails, iOS: iosDetails);
      await _plugin.show(
        1,
        title,
        '$subtitle • $progressLabel',
        details,
        payload: 'audio_player',
      );
    } catch (_) {}
  }

  Future<void> hide() async {
    if (!_initialized || !_isMobilePlatform) return;
    try {
      await _plugin.cancel(1);
    } catch (_) {}
  }

  /// Send a test notification without permission handling (UI handles permissions)
  /// Returns true if notification was sent successfully, false otherwise.
  Future<bool> sendTestNotification() async {
    if (!_initialized || !_isMobilePlatform) return false;

    try {
      // Add a small delay to ensure the app is fully focused and ready
      // iOS sometimes suppresses notifications fired during the first few seconds of launch.
      await Future.delayed(const Duration(seconds: 2));

      // For test notification, use a dedicated high-importance channel
      await _plugin.show(
        999, // Unique ID for test notification
        AppState.instance.l.testNotifTitle,
        AppState.instance.l.testNotifBody,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'test_channel_high',
            'Test Notifications',
            channelDescription: 'High priority test notifications',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            color: Color.fromARGB(255, 76, 175, 80),
            largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            tag: 'test_notification',
            showWhen: true,
            enableLights: true,
            ledColor: Color.fromARGB(255, 76, 175, 80),
            ledOnMs: 1000,
            ledOffMs: 3000,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
      debugPrint('Test notification sent successfully');
      return true;
    } catch (e) {
      debugPrint('Error sending test notification: $e');
      return false;
    }
  }

  // Notification IDs for reminders (distinct from audio ID 1 and test ID 999)
  static const List<int> _reminderIds = [10, 11, 12];

  Future<void> scheduleDailyReminder() async {
    if (!_initialized || !_isMobilePlatform) return;

    try {
      // Always cancel all reminder slots first
      for (final id in _reminderIds) {
        await _plugin.cancel(id);
      }

      final enabled = await PrefsService.isDailyReminderEnabled();
      if (!enabled) return;

      final count = await PrefsService.getReminderCount();

      for (int i = 1; i <= count; i++) {
        final (hour, minute) = await PrefsService.getReminderTime(i);
        await _scheduleOneReminder(
          id: _reminderIds[i - 1],
          hour: hour,
          minute: minute,
          index: i,
          total: count,
        );
      }
    } catch (e) {
      debugPrint('Error scheduling reminders: $e');
    }
  }

  Future<void> _scheduleOneReminder({
    required int id,
    required int hour,
    required int minute,
    required int index,
    required int total,
  }) async {
    try {
      final now = DateTime.now();
      var target = DateTime(now.year, now.month, now.day, hour, minute);
      // If time already passed today, schedule for tomorrow
      if (target.isBefore(now)) {
        target = target.add(const Duration(days: 1));
      }

      // Convert to UTC milliseconds — no flutter_timezone needed.
      // tz.UTC is always available after initializeTimeZones().
      final tzTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
        tz.UTC,
        target.toUtc().millisecondsSinceEpoch,
      );

      final l = AppState.instance.l;
      final title = l.reminderTitle(index, total);
      final body = l.reminderBody;

      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tzTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: 'Daily reading reminder',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents.time → OS repeats this notification every day
        // at the same hour:minute, so it fires even if the user never relaunches
        // the app. The initial tzTime still determines the first firing (today or
        // tomorrow if the time has already passed).
        matchDateTimeComponents: DateTimeComponents.time,
      );
      debugPrint(
          'Reminder $index/$total scheduled for ${target.toIso8601String()}');
    } catch (e) {
      debugPrint('Error scheduling reminder $index: $e');
    }
  }
}

// ─── Audio Service ─────────────────────────────────────────────────────────────

enum PlaybackMode { off, autoPlay, repeatOne }

class QuranAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  QuranAudioHandler() {
    // Sync player state to audio_service playback state
    _player.playbackEventStream.listen((event) {
      _updatePlaybackState();
    });

    _player.positionStream.listen((pos) {
      // Position is handled by the system via the player's position stream
      // and the duration provided in the MediaItem.
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    final current = QuranAudioManager.instance.currentSurah;
    if (current != null && current < 114) {
      await QuranAudioManager.instance.skipTo(current + 1);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    final current = QuranAudioManager.instance.currentSurah;
    if (current != null && current > 1) {
      await QuranAudioManager.instance.skipTo(current - 1);
    }
  }

  void updateMetadata(int surahNum) {
    final surah = kSurahs[surahNum - 1];
    final lang = AppState.instance.language;
    final title = lang == AppLanguage.english
        ? surah['english'] as String
        : surah['arabic'] as String;
    final artist = "Abd Al-Rashid Sufi · Khalaf an Hamzah";

    mediaItem.add(MediaItem(
      id: surahNum.toString(),
      album: "Quran",
      title: title,
      artist: artist,
      duration: _player.duration,
    ));
  }

  void _updatePlaybackState() {
    playbackState.add(playbackState.value.copyWith(
      playing: _player.playing,
      processingState: _player.processingState
          .index == 0 // ready
              ? AudioProcessingState.ready
          : _player.processingState.index == 1 // buffering
              ? AudioProcessingState.buffering
              : _player.processingState.index == 2 // completed
                  ? AudioProcessingState.completed
                  : AudioProcessingState.idle,
    ));
  }

  AudioPlayer get player => _player;
}

class QuranAudioManager with WidgetsBindingObserver {

  QuranAudioManager._() {
    // The handler is initialized asynchronously in initialize().
    // We use a listener on the handler's player state.
    // Since this is a singleton, we can't easily await initialize() here.
    // We'll set up the listener once the handler is available.
  }

  void _persistPosition() {
    final s = currentSurah;
    if (s == null) return;
    PrefsService.saveAudioPosition(s, player.position);
  }

  // ── Playback mode ─────────────────────────────────────────────────────────
  PlaybackMode playbackMode = PlaybackMode.off;

  void cyclePlaybackMode() {
    playbackMode = PlaybackMode
        .values[(playbackMode.index + 1) % PlaybackMode.values.length];
    _notify();
  }

  void _onTrackCompleted() {
    switch (playbackMode) {
      case PlaybackMode.repeatOne:
        player.seek(Duration.zero).then((_) => player.play());
      case PlaybackMode.autoPlay:
        if (currentSurah != null && currentSurah! < 114) {
          final next = currentSurah! + 1;
          downloadAndPlay(next);
        }
      case PlaybackMode.off:
        break;
    }
  }

  // ── Sleep timer ───────────────────────────────────────────────────────────
  int sleepTimerMinutes = 0; // 0 = off
  Timer? _sleepTimer;
  DateTime? _sleepTimerEnd;

  Duration? get sleepTimerRemaining {
    if (_sleepTimerEnd == null) return null;
    final remaining = _sleepTimerEnd!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  void setSleepTimer(int minutes) {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    _sleepTimerEnd = null;
    sleepTimerMinutes = minutes;
    if (minutes > 0) {
      _sleepTimerEnd = DateTime.now().add(Duration(minutes: minutes));
      _sleepTimer = Timer(Duration(minutes: minutes), () {
        handler.pause();
        sleepTimerMinutes = 0;
        _sleepTimerEnd = null;
        _sleepTimer = null;
        _notify();
      });
    }
    _notify();
  }

  static final QuranAudioManager instance = QuranAudioManager._();

  Future<void> initialize() async {
    final handler = await AudioService.init(
      builder: () => QuranAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'khalaf_audio_channel',
        androidNotificationChannelName: 'Khalaf Quran Audio',
        androidStopForegroundOnPause: true,
      ),
    );
    _handler = handler;

    // Setup player state listener
    handler.player.playerStateStream.listen((state) {
      _notify();
      AudioNotificationService.instance.syncPlayback();
      if (!state.playing && state.processingState != ProcessingState.completed) {
        _persistPosition();
      }
      if (state.processingState == ProcessingState.completed) {
        PrefsService.clearAudioPosition();
        _onTrackCompleted();
      }
    });

    // Pre-scan downloaded files
    await _preloadDownloadedCache();
  }

  AudioHandler? _handler;
  QuranAudioHandler get handler => _handler as QuranAudioHandler;

  void init() {
    WidgetsBinding.instance.addObserver(this);
    // Pre-populate the downloaded-files cache with a single directory scan
    // so all 114 isKnownDownloaded() checks are O(1) set lookups.
    _preloadDownloadedCache();
  }

  Future<void> _preloadDownloadedCache() async {
    try {
      final folder = await PrefsService.effectiveAudioFolder();
      _cachedAudioFolder = folder;
      final dir = Directory(folder);
      if (!await dir.exists()) return;
      await for (final entity in dir.list()) {
        final name = entity.path.split('/').last;
        final match = RegExp(r'^(\d{3})\.mp3$').firstMatch(name);
        if (match != null) {
          final n = int.tryParse(match.group(1)!);
          if (n != null && n >= 1 && n <= 114) _knownDownloaded.add(n);
        }
      }
      _notify();
    } catch (e) {
      debugPrint('Error preloading download cache: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _persistPosition();
    }
  }

  static final Dio _dio = Dio();

  int? currentSurah;

  // ── Cached settings (invalidated when user changes them) ─────────────────
  String? _cachedBaseUrl;
  String? _cachedAudioFolder;

  /// Call this whenever the user changes the audio base URL or download dir.
  void invalidateSettingsCache() {
    _cachedBaseUrl = null;
    _cachedAudioFolder = null;
  }

  // Download progress: surah number → 0.0–1.0
  final Map<int, double> downloadProgress = {};
  final Set<int> _knownDownloaded = {};

  // Active single-download cancel token
  CancelToken? _cancelToken;

  // Bulk download cancel token and failed surahs tracker
  CancelToken? _bulkCancelToken;
  final List<int> _bulkFailedSurahs = [];

  // Throttle progress notifications: min 120 ms gap OR 2% change
  DateTime _lastProgressNotify = DateTime.fromMillisecondsSinceEpoch(0);

  bool isBulkDownloading = false;
  int bulkDownloadCurrent = 0;
  int bulkDownloadTotal = 0;

  // Exponential backoff for failed downloads: tracks retry attempts
  final Map<int, int> _surahRetryAttempts = {};
  static const int _maxRetryAttempts = 3;

  List<int> get bulkFailedSurahs => List<int>.from(_bulkFailedSurahs);

  AudioPlayer get player => handler.player;
  Duration get position => player.position;
  Duration? get duration => player.duration;

  Future<String> _audioUrl(int n) async {
    _cachedBaseUrl ??= await PrefsService.getAudioBaseUrl();
    return '$_cachedBaseUrl/${n.toString().padLeft(3, '0')}.mp3';
  }

  Future<String> _localPath(int n) async {
    if (_cachedAudioFolder == null) {
      final folder = await PrefsService.effectiveAudioFolder();
      final dir = Directory(folder);
      if (!await dir.exists()) await dir.create(recursive: true);
      _cachedAudioFolder = folder;
    }
    return '$_cachedAudioFolder/${n.toString().padLeft(3, '0')}.mp3';
  }

  bool isKnownDownloaded(int n) => _knownDownloaded.contains(n);

  Future<bool> isDownloaded(int n) async {
    if (_knownDownloaded.contains(n)) return true;
    final exists = await File(await _localPath(n)).exists();
    if (exists) _knownDownloaded.add(n);
    return exists;
  }

  /// Must be called whenever the download directory changes so that stale
  /// in-memory cache entries from the old folder are discarded.
  void clearDownloadCache() {
    _knownDownloaded.clear();
    _cachedAudioFolder = null;
    _notify();
  }

  void _updateDownloadProgress(int surahNum, double value) {
    final previous = downloadProgress[surahNum] ?? 0.0;
    final now = DateTime.now();
    final elapsed = now.difference(_lastProgressNotify).inMilliseconds;
    if (value < 1.0 && value - previous < 0.02 && elapsed < 120) return;
    downloadProgress[surahNum] = value.clamp(0.0, 1.0);
    _lastProgressNotify = now;
    _notify();
  }

  /// Download a single surah and play it immediately when ready.
  /// If [seekTo] is provided the player jumps to that position after loading.
  Future<void> downloadAndPlay(int surahNum, {Duration? seekTo}) async {
    final path = await _localPath(surahNum);

    if (!await File(path).exists()) {
      // Cancel any in-progress single download

      _cancelToken?.cancel();
      _cancelToken = CancelToken();
      _updateDownloadProgress(surahNum, 0.0);
      try {
        final url = await _audioUrl(surahNum);
        await _dio.download(
          url,
          path,
          cancelToken: _cancelToken,
          onReceiveProgress: (got, total) {
            if (total > 0) _updateDownloadProgress(surahNum, got / total);
          },
        );
        _knownDownloaded.add(surahNum);
      } catch (e) {
        // Clean up partial file on failure (not on cancel)
        final partial = File(path);
        if (await partial.exists()) await partial.delete();
      } finally {
        downloadProgress.remove(surahNum);
        _cancelToken = null;
        _notify();
      }
    } else {
      _knownDownloaded.add(surahNum);
    }

    if (_knownDownloaded.contains(surahNum)) {
      currentSurah = surahNum;
      handler.updateMetadata(surahNum);
      await player.setFilePath(path);
      if (seekTo != null && seekTo.inSeconds > 0) {
        await player.seek(seekTo);
      }
      await player.play();
      // Clear saved position — we've resumed, so it's consumed
      PrefsService.clearAudioPosition();
      _notify();
    }
  }

  Future<void> downloadOnly(int surahNum) async {
    final path = await _localPath(surahNum);
    if (await File(path).exists()) {
      _knownDownloaded.add(surahNum);
      _notify();
      return;
    }
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    _updateDownloadProgress(surahNum, 0.0);
    try {
      final url = await _audioUrl(surahNum);
      await _dio.download(
        url,
        path,
        cancelToken: _cancelToken,
        onReceiveProgress: (got, total) {
          if (total > 0) _updateDownloadProgress(surahNum, got / total);
        },
      );
      _knownDownloaded.add(surahNum);
    } catch (e) {
      final partial = File(path);
      if (await partial.exists()) await partial.delete();
    } finally {
      downloadProgress.remove(surahNum);
      _cancelToken = null;
      _notify();
    }
  }

  Future<void> downloadAllSurahs({
    void Function(int current, int total)? onProgress,
    void Function()? onComplete,
  }) async {
    if (isBulkDownloading) return;
    isBulkDownloading = true;
    bulkDownloadTotal = 114;
    bulkDownloadCurrent = 0;
    _bulkFailedSurahs.clear();
    _bulkCancelToken = CancelToken();
    _notify();

    // Download up to 3 surahs concurrently for significantly faster bulk download
    const int concurrency = 3;

    Future<void> downloadOne(int n) async {
      if (!isBulkDownloading) return;
      bulkDownloadCurrent = n;
      onProgress?.call(n, 114);
      _notify();

      final path = await _localPath(n);
      if (await File(path).exists()) {
        _knownDownloaded.add(n);
        return;
      }

      int attempts = _surahRetryAttempts[n] ?? 0;
      bool downloaded = false;

      while (attempts < _maxRetryAttempts && !downloaded && isBulkDownloading) {
        try {
          final url = await _audioUrl(n);
          await _dio.download(
            url,
            path,
            cancelToken: _bulkCancelToken,
          );
          _knownDownloaded.add(n);
          _surahRetryAttempts.remove(n);
          downloaded = true;
        } catch (e) {
          attempts++;
          _surahRetryAttempts[n] = attempts;
          if (attempts >= _maxRetryAttempts) {
            if (e is! DioException || e.type != DioExceptionType.cancel) {
              _bulkFailedSurahs.add(n);
              debugPrint(
                  'Failed to download surah $n after $attempts attempts: $e');
            }
          } else {
            final backoffDuration = Duration(seconds: 1 << (attempts - 1));
            debugPrint(
                'Retrying surah $n in ${backoffDuration.inSeconds}s (attempt $attempts/$_maxRetryAttempts)');
            await Future.delayed(backoffDuration);
          }
          final partial = File(path);
          if (await partial.exists()) {
            try {
              await partial.delete();
            } catch (e) {
              debugPrint('Failed to delete partial file for surah $n: $e');
            }
          }
        }
      }
    }

    // Process in batches of [concurrency]
    for (int batch = 0; batch < 114; batch += concurrency) {
      if (!isBulkDownloading) break;
      final end = math.min(batch + concurrency, 114);
      final futures = <Future>[];
      for (int n = batch + 1; n <= end; n++) {
        futures.add(downloadOne(n));
      }
      await Future.wait(futures);
    }

    isBulkDownloading = false;
    bulkDownloadCurrent = 0;
    bulkDownloadTotal = 0;
    _bulkCancelToken = null;
    _notify();
    onComplete?.call();
  }

  void cancelSingleDownload() {
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  void cancelBulkDownload() {
    isBulkDownloading = false;
    _bulkCancelToken?.cancel('User cancelled bulk download');
    _notify();
  }

  void cancelSleepTimer() => setSleepTimer(0);

  Future<void> toggle() async {
    if (player.playing) {
      await handler.pause();
    } else {
      await handler.play();
    }
  }

  Future<void> seek(Duration pos) => handler.seek(pos);

  Future<void> seekBackward(Duration amount) async {
    final target = position - amount;
    await handler.seek(target < Duration.zero ? Duration.zero : target);
    AudioNotificationService.instance.syncPlayback();
  }

  Future<void> seekForward(Duration amount) async {
    final dur = player.duration;
    final target = position + amount;
    await handler.seek(dur != null && target > dur ? dur : target);
    AudioNotificationService.instance.syncPlayback();
  }

  Future<void> skipTo(int surahNum) => downloadAndPlay(surahNum);

  bool get hasActiveAudio =>
      currentSurah != null || downloadProgress.isNotEmpty;

  // ── Listener management ─────────────────────────────────────────────────────
  /// Use Set to prevent duplicate listener registration
  final Set<VoidCallback> _listeners = {};
  void addListener(VoidCallback cb) => _listeners.add(cb);
  void removeListener(VoidCallback cb) => _listeners.remove(cb);
  void _notify() {
    // Iterate over a snapshot only if a listener might mutate _listeners
    // during dispatch (rare). For the common case, direct iteration is enough;
    // toList() is kept as a safety net but is cheaper than always copying.
    if (_listeners.isEmpty) return;
    for (final cb in _listeners.toList(growable: false)) {
      cb();
    }
  }
}

// ─── Settings Screen ───────────────────────────────────────────────────────────

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  int _maxDpi = PrefsService.defaultMaxDpi;

  // Cache stats to avoid rebuilding the future on every setState
  int _streak = 0;
  Duration _readingTime = Duration.zero;
  Duration _todayTime = Duration.zero;
  bool _statsLoaded = false;
  int _dailyGoalMinutes = PrefsService.defaultDailyGoalMinutes;
  int _totalGoalHours = PrefsService.defaultTotalGoalHours;

  // Reading history for the in-settings heatmap
  Map<String, int> _readingHistory = {};
  DateTime _settingsHeatmapMonth =
      DateTime(DateTime.now().year, DateTime.now().month);

  final _audioSvc = QuranAudioManager.instance;
  bool _downloading = false;
  int _dlCurrent = 0;
  int _dlTotal = 114;


  // Production-level: Prevent rapid successive stats updates
  DateTime? _lastStatsUpdate;
  static const _minStatsUpdateInterval = Duration(milliseconds: 500);

  // Daily reminder state
  bool _reminderEnabled = false;
  int _reminderCount = PrefsService.defaultReminderCount;
  // Index 0 = reminder 1, index 1 = reminder 2, index 2 = reminder 3
  final List<int> _reminderHours = [
    PrefsService.defaultReminderHour,
    12,
    18,
  ];
  final List<int> _reminderMinutes = [0, 0, 0];

  String? _prayerLocationName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadSettings();
    _loadStats();
    _audioSvc.addListener(_onAudioUpdate);
    AppState.instance.addListener(_rebuild);
    _refreshLocationName();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioSvc.removeListener(_onAudioUpdate);
    AppState.instance.removeListener(_rebuild);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
  }

  /// Optimized: Only trigger targeted rebuilds on audio events
  void _rebuild() {
    if (mounted) setState(() {});
  }

  /// Optimized: Update only download progress instead of full rebuild
  void _onAudioUpdate() {
    if (!mounted) return;

    setState(() {
      _downloading = _audioSvc.isBulkDownloading;
      _dlCurrent = _audioSvc.bulkDownloadCurrent;
      _dlTotal =
          _audioSvc.bulkDownloadTotal > 0 ? _audioSvc.bulkDownloadTotal : 114;
    });
  }

  Future<void> _loadSettings() async {
    try {
      final maxDpi = await PrefsService.getMaxDpi();
      final dailyGoal = await PrefsService.getDailyGoalMinutes();
      final totalGoal = await PrefsService.getTotalGoalHours();
      final reminderEnabled = await PrefsService.isDailyReminderEnabled();
      final reminderCount = await PrefsService.getReminderCount();
      final times = await Future.wait([
        PrefsService.getReminderTime(1),
        PrefsService.getReminderTime(2),
        PrefsService.getReminderTime(3),
      ]);
      // Add mounted checks before EACH setState for safety
      if (!mounted) return;
      setState(() {
        _maxDpi = maxDpi;
        _dailyGoalMinutes = dailyGoal;
        _totalGoalHours = totalGoal;
        _reminderEnabled = reminderEnabled;
        _reminderCount = reminderCount;
        _reminderHours[0] = times[0].$1;
        _reminderHours[1] = times[1].$1;
        _reminderHours[2] = times[2].$1;
        _reminderMinutes[0] = times[0].$2;
        _reminderMinutes[1] = times[1].$2;
        _reminderMinutes[2] = times[2].$2;
      });
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> _loadStats() async {
    // Production-level: Debounce rapid calls to prevent update loops
    final now = DateTime.now();
    if (_lastStatsUpdate != null &&
        now.difference(_lastStatsUpdate!).inMilliseconds <
            _minStatsUpdateInterval.inMilliseconds) {
      return;
    }
    _lastStatsUpdate = now;

    try {
      // Single prefs await instead of four separate ones.
      final stats = await ReadingStatsService.getStats();
      if (!mounted) return;
      setState(() {
        _streak = stats.streak;
        _readingTime = stats.totalTime;
        _todayTime = stats.todayTime;
        _readingHistory = stats.history;
        _statsLoaded = true;
      });
    } catch (e) {
      debugPrint('Error loading stats: $e');
      if (mounted) {
        setState(() => _statsLoaded = true);
      }
    }
  }

  Future<void> _startDownloadAll() async {
    final l = AppState.instance.l;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF102110),
        title: Text(l.downloadAllTitle),
        content: SingleChildScrollView(child: Text(l.downloadAllConfirm)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: _kGreen, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.download,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    _audioSvc.downloadAllSurahs(
      onProgress: (c, t) {
        if (mounted) {
          setState(() {
            _dlCurrent = c;
            _dlTotal = t;
          });
        }
      },
      onComplete: () {
        if (!mounted) return;
        final failed = _audioSvc.bulkFailedSurahs;
        if (failed.isEmpty) {
          _showSnack(l.allDownloaded);
        } else {
          // Production-level: Surface failed surahs to user
          final failedList =
              failed.map((n) => kSurahs[n - 1]['english']).join(', ');
          _showSnack(
            AppState.instance.l.bulkDownloadResult(
              114 - failed.length, 114, failedList),
          );
        }
      },
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF2A4D2A),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// Shows a bottom-sheet picker for a numeric goal.
  /// [options] is a list of [int] values to display.
  /// [currentValue] is the currently selected value.
  /// [labelBuilder] converts each option to a display string.
  Future<void> _showGoalPicker({
    required String title,
    required List<int> options,
    required int currentValue,
    required String Function(int) labelBuilder,
    required Future<void> Function(int) onSelected,
  }) async {
    final l = AppState.instance.l;
    // Hoisted outside StatefulBuilder so it survives rebuilds.
    int selected = currentValue;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1E0D),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text(l.cancel,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Wrap of chip-style options
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: options.map((opt) {
                          final isSelected = opt == selected;
                          return GestureDetector(
                            onTap: () {
                              setSheetState(() => selected = opt);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 9),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? _kGreen
                                    : Colors.white.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? _kGreenLight.withValues(alpha: 0.5)
                                      : Colors.white.withValues(alpha: 0.07),
                                ),
                              ),
                              child: Text(
                                labelBuilder(opt),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white60,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: _kGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () async {
                            Navigator.pop(ctx);
                            await onSelected(selected);
                          },
                          child: Text(l.save,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatTime(Duration d) => AppState.instance.l.formatDuration(d);

  Widget _buildCard(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: _kBgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;
    return Scaffold(
      backgroundColor: _kBgDeep,
      appBar: AppBar(
        backgroundColor: _kBgDeep,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(l.settings,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
              height: 0.5, color: Colors.white.withValues(alpha: 0.07)),
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          final isDesktop = !Platform.isAndroid && !Platform.isIOS;
          final isLandscape = orientation == Orientation.landscape;
          final useDesktopLayout = isDesktop || isLandscape;
          final hPad = 16.0 + MediaQuery.of(context).padding.left;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
                children: _buildSettingsSections(context, l, useDesktopLayout),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildSettingsSections(
      BuildContext ctx, L10n l, bool isLandscape) {
    // Portrait order (unchanged)
    final portraitSections = <(String, Widget)>[
      (l.language, _secLanguage(l)),
      (l.darkMode, _secDarkMode(l)),
      (l.readingGoals, _secReadingGoals(l)),
      (l.readingStats, _secReadingStats(l)),
      (l.offlineAudio, _secOfflineAudio(l)),
      (l.prayerLocation, _secPrayerLocation(l, ctx)),
      (l.renderQuality, _secRenderQuality(l, ctx)),
      (l.dailyReminder, _secDailyReminder(l, ctx)),
      (l.about, _secAbout(l)),
    ];

    if (!isLandscape) {
      final items = <Widget>[];
      for (int i = 0; i < portraitSections.length; i++) {
        if (i > 0) items.add(const SizedBox(height: 24));
        // About is the last section — banner is self-contained, skip the header
        if (i == portraitSections.length - 1) {
          items.add(_secAbout(l));
          continue;
        }
        items.add(_SectionHeader(label: portraitSections[i].$1));
        items.add(const SizedBox(height: 10));
        items.add(portraitSections[i].$2);
      }
      items.add(const SizedBox(height: 16));
      items.add(const _UpdateChecker());
      items.add(const SizedBox(height: 40));
      return items;
    }

    // ── Landscape layout ────────────────────────────────────────────────────
    // Row 1+2: Language & Reading Goals stacked on left | Reading Stats tall on right
    // Row 3:   Offline Audio / Manage Surahs            | Daily Reminder
    // Row 4:   Render Quality / DPI                     | Download Location
    // Row 5:   Full-width Khalaf about banner

    final items = <Widget>[];

    // ── Rows 1 & 2: Language + Goals stacked left, Stats tall on right ──────
    items.add(
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left column: Language on top, Reading Goals below
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _settingsTile(l.language, _secLanguage(l)),
                  const SizedBox(height: 12),
                  _settingsTile(l.darkMode, _secDarkMode(l)),
                  const SizedBox(height: 12),
                  Expanded(
                      child:
                          _settingsTile(l.readingGoals, _secReadingGoals(l))),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Right column: Reading Stats, stretches to fill both rows

            Expanded(
              child: _settingsTile(l.readingStats, _secReadingStats(l)),
            ),
          ],
        ),
      ),
    );

    items.add(const SizedBox(height: 12));

    // ── Row 3: Offline Audio | Daily Reminder ───────────────────────────────
    items.add(
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _settingsTile(l.offlineAudio, _secOfflineAudio(l))),
            const SizedBox(width: 12),
            Expanded(
                child:
                    _settingsTile(l.dailyReminder, _secDailyReminder(l, ctx))),
          ],
        ),
      ),
    );

    items.add(const SizedBox(height: 12));

    // ── Row 4: Render Quality / DPI ──────────────────────────────────────────
    items.add(
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child:
                    _settingsTile(l.renderQuality, _secRenderQuality(l, ctx))),
          ],
        ),
      ),
    );

    items.add(const SizedBox(height: 12));

    // ── Row 6: Full-width Khalaf about banner ────────────────────────────────
    items.add(_secAbout(l));

    items.add(const SizedBox(height: 16));
    items.add(const _UpdateChecker());

    items.add(const SizedBox(height: 32));
    return items;
  }

  Widget _settingsTile(String label, Widget card) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SectionHeader(label: label),
          const SizedBox(height: 8),
          card
        ],
      );

  Widget _secLanguage(L10n l) => _buildCard(
        Row(
          children: AppLanguage.values.map((lang) {
            final selected = AppState.instance.language == lang;
            final label = switch (lang) {
              AppLanguage.english => 'English',
              AppLanguage.arabic => 'العربية',
              AppLanguage.urdu => 'اردو',
            };
            return Expanded(
              child: GestureDetector(
                onTap: () => AppState.instance.setLanguage(lang),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? _kGreen
                        : Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10),
                    border: selected
                        ? Border.all(color: _kGreenMid.withValues(alpha: 0.35))
                        : null,
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                      color: selected ? _kGreenLight : Colors.white38,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );

  Widget _secDarkMode(L10n l) => _buildCard(
        Row(
          children: [
            const Icon(Icons.dark_mode_rounded, size: 20, color: _kGreenLight),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l.darkMode,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(l.darkModeDesc,
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 11)),
                ],
              ),
            ),
            Switch(
              value: AppState.instance.darkMode,
              activeColor: _kGreen,
              inactiveThumbColor: Colors.white24,
              inactiveTrackColor: Colors.white10,
              onChanged: (v) => AppState.instance.setDarkMode(v),
            ),
          ],
        ),
      );

  Widget _secReadingGoals(L10n l) => _buildCard(
        Column(
          children: [
            // Daily goal row
            _GoalRow(
              icon: Icons.wb_sunny_rounded,
              iconColor: _kGreenLight,
              label: l.dailyGoal,
              value: '${l.toLocalNum(_dailyGoalMinutes)} ${l.minutes}',
              onTap: () async {
                await _showGoalPicker(
                  title: l.dailyGoal,
                  options: [5, 10, 15, 20, 30, 45, 60, 90, 120],
                  currentValue: _dailyGoalMinutes,
                  labelBuilder: (v) => '${l.toLocalNum(v)} ${l.minutes}',
                  onSelected: (v) async {
                    await PrefsService.setDailyGoalMinutes(v);
                    if (mounted) setState(() => _dailyGoalMinutes = v);
                  },
                );
              },
            ),
            const SizedBox(height: 4),
            Container(height: 0.5, color: Colors.white.withValues(alpha: 0.06)),
            const SizedBox(height: 4),
            // Total goal row
            _GoalRow(
              icon: Icons.flag_rounded,
              iconColor: const Color(0xFF64B5F6),
              label: l.totalGoal,
              value: '${l.toLocalNum(_totalGoalHours)} ${l.hours}',
              onTap: () async {
                await _showGoalPicker(
                  title: l.totalGoal,
                  options: [10, 25, 50, 100, 200, 300, 500, 1000],
                  currentValue: _totalGoalHours,
                  labelBuilder: (v) => '${l.toLocalNum(v)} ${l.hours}',
                  onSelected: (v) async {
                    await PrefsService.setTotalGoalHours(v);
                    if (mounted) setState(() => _totalGoalHours = v);
                  },
                );
              },
            ),
          ],
        ),
      );

  Widget _secReadingStats(L10n l) {
    // Intensity helper — same tiers as the modal heatmap
    double intensity(String dateKey) {
      final secs = _readingHistory[dateKey] ?? 0;
      if (secs == 0) return 0.0;
      if (secs < 5 * 60) return 0.25;
      if (secs < 15 * 60) return 0.50;
      if (secs < 30 * 60) return 0.75;
      return 1.0;
    }

    final todayFrac = _dailyGoalMinutes > 0
        ? (_todayTime.inSeconds / (_dailyGoalMinutes * 60)).clamp(0.0, 1.0)
        : 0.0;
    final totalFrac = _totalGoalHours > 0
        ? (_readingTime.inSeconds / (_totalGoalHours * 3600)).clamp(0.0, 1.0)
        : 0.0;

    return _buildCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: streak + two stat chips ─────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Streak badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7043).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFF7043).withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_fire_department,
                        color: Color(0xFFFF7043), size: 18),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _statsLoaded ? l.toLocalNum(_streak) : '–',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          l.dayStreak,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Today chip
              Expanded(
                child: _StatChip(
                  icon: Icons.wb_sunny_rounded,
                  iconColor: _kGreenLight,
                  label: l.today,
                  value: _statsLoaded ? _formatTime(_todayTime) : '–',
                  valueColor: _kGreenLight,
                  fraction: _statsLoaded ? todayFrac : 0.0,
                  barColor: _kGreenLight,
                  sublabel: l.goalMinutes(_dailyGoalMinutes),
                ),
              ),
              const SizedBox(width: 8),
              // Total chip
              Expanded(
                child: _StatChip(
                  icon: Icons.access_time_rounded,
                  iconColor: const Color(0xFF64B5F6),
                  label: l.totalTime,
                  value: _statsLoaded ? _formatTime(_readingTime) : '–',
                  valueColor: const Color(0xFF64B5F6),
                  fraction: _statsLoaded ? totalFrac : 0.0,
                  barColor: const Color(0xFF64B5F6),
                  sublabel: l.goalHours(_totalGoalHours),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Container(height: 0.5, color: Colors.white.withValues(alpha: 0.06)),
          const SizedBox(height: 16),

          // ── Heatmap ───────────────────────────────────────────────────────
          _ReadingHeatmap(
            month: _settingsHeatmapMonth,
            history: _readingHistory,
            intensity: intensity,
            heatColor: const Color(0xFF43A047),
            monthLabel: _heatmapMonthLabel(l),
            isCurrentMonth: _isSettingsCurrentMonth,
            onPrev: () => setState(() {
              _settingsHeatmapMonth = DateTime(
                  _settingsHeatmapMonth.year, _settingsHeatmapMonth.month - 1);
            }),
            onNext: () {
              final now = DateTime.now();
              final next = DateTime(
                  _settingsHeatmapMonth.year, _settingsHeatmapMonth.month + 1);
              if (!next.isAfter(DateTime(now.year, now.month))) {
                setState(() => _settingsHeatmapMonth = next);
              }
            },
            l: l,
          ),

          const SizedBox(height: 16),
          Container(height: 0.5, color: Colors.white.withValues(alpha: 0.06)),
          const SizedBox(height: 12),

          // ── Reset button ─────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side:
                    BorderSide(color: Colors.redAccent.withValues(alpha: 0.35)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                foregroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: const Color(0xFF102110),
                    title: Text(l.resetStatsTitle),
                    content:
                        SingleChildScrollView(child: Text(l.resetStatsConfirm)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text(l.cancel,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text(l.reset,
                            style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                );
                if (confirmed == true && mounted) {
                  await ReadingStatsService.reset();
                  await _loadStats();
                }
              },
              child: Text(l.resetStats,
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  bool get _isSettingsCurrentMonth {
    final now = DateTime.now();
    return _settingsHeatmapMonth.year == now.year &&
        _settingsHeatmapMonth.month == now.month;
  }

  String _heatmapMonthLabel(L10n l) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    const monthsAr = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    const monthsUr = [
      'جنوری', 'فروری', 'مارچ', 'اپریل', 'مئی', 'جون',
      'جولائی', 'اگست', 'ستمبر', 'اکتوبر', 'نومبر', 'دسمبر',
    ];
    final idx = _settingsHeatmapMonth.month - 1;
    final year = _settingsHeatmapMonth.year.toString();
    return switch (l.lang) {
      AppLanguage.english => '${months[idx]} $year',
      AppLanguage.arabic  => '${monthsAr[idx]} $year',
      AppLanguage.urdu    => '${monthsUr[idx]} $year',
    };
  }

  Widget _secOfflineAudio(L10n l) => _buildCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_downloading) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l.downloading(_dlCurrent, _dlTotal),
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: _audioSvc.cancelBulkDownload,
                    child: Text(l.cancel,
                        style: const TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _dlTotal > 0 ? _dlCurrent / _dlTotal : 0,
                  minHeight: 3,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(_kGreenMid),
                ),
              ),
            ] else ...[
              Text(
                l.downloadAllDesc,
                style: const TextStyle(
                    fontSize: 13, color: Colors.white54, height: 1.5),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: _kGreenMid.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: _kGreenLight,
                  ),
                  icon: const Icon(Icons.apps_rounded,
                      size: 18, color: _kGreenLight),
                  label: Text(l.manageSurahs,
                      style: const TextStyle(
                          color: _kGreenLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const _SurahGalleryModal(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton.icon(

                  style: FilledButton.styleFrom(
                    backgroundColor: _kGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.download_for_offline_rounded,
                      size: 18, color: Colors.white),
                  label: Text(l.downloadAllSurahs,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  onPressed: _startDownloadAll,
                ),
              ),
            ],
          ],
        ),
      );

  Widget _secRenderQuality(L10n l, BuildContext ctx) => _buildCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l.maxDpi,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        fontSize: 13)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kGreen.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_maxDpi',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _kGreenLight),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l.maxDpiDesc,
              style: const TextStyle(
                  fontSize: 11, color: Colors.white38, height: 1.5),
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderTheme.of(ctx).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                activeTrackColor: const Color(0xFF4CAF50),
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
                overlayColor: Colors.white10,
              ),
              child: Slider(
                min: 150,
                max: 800,
                // 14 stops: 150,200,250,300,350,400,450,500,550,600,650,700,750,800
                divisions: 13,
                value: _maxDpi.toDouble(),
                onChanged: (v) => setState(() => _maxDpi = v.round()),
                onChangeEnd: (v) => PrefsService.setMaxDpi(v.round()),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('150',
                      style: TextStyle(fontSize: 10, color: Colors.white24)),
                  Text('380–500',
                      style: TextStyle(
                          fontSize: 10,
                          color: _kGreenMid,
                          fontWeight: FontWeight.w600)),
                  Text('800',
                      style: TextStyle(fontSize: 10, color: Colors.white24)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _secDailyReminder(L10n l, BuildContext ctx) => _buildCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.dailyReminderDesc,
              style: const TextStyle(
                  fontSize: 12, color: Colors.white38, height: 1.5),
            ),
            const SizedBox(height: 14),
            // Enable toggle row
            Row(
              children: [
                Expanded(
                  child: Text(
                    l.reminderEnabled,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
                Switch(
                  value: _reminderEnabled,
                  activeThumbColor: _kGreenLight,
                  activeTrackColor: _kGreen,
                  inactiveThumbColor: Colors.white38,
                  inactiveTrackColor: Colors.white12,
                  onChanged: (val) async {
                    await PrefsService.setDailyReminderEnabled(val);
                    if (mounted) setState(() => _reminderEnabled = val);
                    await AudioNotificationService.instance
                        .scheduleDailyReminder();
                  },
                ),
              ],
            ),
            // Expanded section — only when enabled
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Container(
                      height: 0.5, color: Colors.white.withValues(alpha: 0.06)),
                  const SizedBox(height: 12),
                  // ── Notifications per day ──────────────────────
                  Row(
                    children: [
                      const Icon(Icons.notifications_rounded,
                          size: 16, color: Colors.white38),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l.notificationsPerDay,
                          style: const TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: _reminderCount <= 1
                            ? null
                            : () async {
                                final newCount = _reminderCount - 1;
                                await PrefsService.setReminderCount(newCount);
                                setState(() => _reminderCount = newCount);
                                await AudioNotificationService.instance
                                    .scheduleDailyReminder();
                              },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _reminderCount <= 1
                                ? Colors.white.withValues(alpha: 0.04)
                                : _kGreenLight.withValues(alpha: 0.12),
                            border: Border.all(
                              color: _reminderCount <= 1
                                  ? Colors.white12
                                  : _kGreenLight.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(Icons.remove,
                              size: 14,
                              color: _reminderCount <= 1
                                  ? Colors.white24
                                  : _kGreenLight),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l.toLocalNum(_reminderCount),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      // + button
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: _reminderCount >= 3
                            ? null
                            : () async {
                                final newCount = _reminderCount + 1;
                                await PrefsService.setReminderCount(newCount);
                                setState(() => _reminderCount = newCount);
                                await AudioNotificationService.instance
                                    .scheduleDailyReminder();
                              },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _reminderCount >= 3
                                ? Colors.white.withValues(alpha: 0.04)
                                : _kGreenLight.withValues(alpha: 0.12),
                            border: Border.all(
                              color: _reminderCount >= 3
                                  ? Colors.white12
                                  : _kGreenLight.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(Icons.add,
                              size: 14,
                              color: _reminderCount >= 3
                                  ? Colors.white24
                                  : _kGreenLight),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                      height: 0.5, color: Colors.white.withValues(alpha: 0.06)),
                  // ── Individual time pickers ────────────────────
                  ...List.generate(_reminderCount, (i) {
                    final idx = i + 1; // 1-based
                    return InkWell(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: ctx,
                          initialTime: TimeOfDay(
                              hour: _reminderHours[i],
                              minute: _reminderMinutes[i]),
                          builder: (ctx, child) => Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: _kGreen,
                                onPrimary: Colors.white,
                                surface: Color(0xFF102110),
                                onSurface: Colors.white,
                              ),
                            ),
                            child: child!,
                          ),
                        );
                        if (picked == null || !mounted) return;
                        await PrefsService.setReminderTime(
                            idx, picked.hour, picked.minute);
                        setState(() {
                          _reminderHours[i] = picked.hour;
                          _reminderMinutes[i] = picked.minute;
                        });
                        await AudioNotificationService.instance
                            .scheduleDailyReminder();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _kGreenLight.withValues(alpha: 0.1),
                                border: Border.all(
                                    color: _kGreenLight.withValues(alpha: 0.3),
                                    width: 1.2),
                              ),
                              child: const Icon(Icons.access_time_rounded,
                                  color: _kGreenLight, size: 17),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _reminderCount > 1
                                    ? '${l.reminderTime} $idx'
                                    : l.reminderTime,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white70),
                              ),
                            ),
                            Text(
                              l.formatReminderTime(
                                  _reminderHours[i], _reminderMinutes[i]),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.chevron_right,
                                size: 16, color: Colors.white24),
                          ],
                        ),
                      ),
                    );
                  }),
                  Container(
                      height: 0.5, color: Colors.white.withValues(alpha: 0.06)),
                  const SizedBox(height: 8),
                  // Test notification button
                  InkWell(
                    onTap: () async {
                      if (Platform.isAndroid) {
                        final status = await Permission.notification.status;
                        if (!status.isGranted) {
                          // Show permission dialog
                          if (!mounted) return;
                          final shouldOpen = await showDialog<bool>(
                            context: ctx,
                            barrierDismissible: false,
                            builder: (_) => AlertDialog(
                              backgroundColor: const Color(0xFF102110),
                              title: Text(l.notifPermissionTitle),
                              content: SingleChildScrollView(
                                  child: Text(l.notifPermissionBody)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: Text(l.cancel,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: _kGreen,
                                      foregroundColor: Colors.white),
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: Text(l.openSettings,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                          );
                          if (shouldOpen != true) return;
                          // Open app settings
                          await openAppSettings();
                          return;

                        }
                      }

                      // Send test notification
                      final success = await AudioNotificationService.instance
                          .sendTestNotification();
                      if (mounted) {
                        if (success) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text('${l.testNotification} ${l.sent}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text(l.permissionDenied),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _kGreenLight.withValues(alpha: 0.1),
                              border: Border.all(
                                  color: _kGreenLight.withValues(alpha: 0.3),
                                  width: 1.2),
                            ),
                            child: const Icon(
                                Icons.notifications_active_rounded,
                                color: _kGreenLight,
                                size: 17),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(l.testNotification,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white70)),
                          ),
                          const Icon(Icons.send_rounded,
                              size: 16, color: Colors.white24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              crossFadeState: _reminderEnabled
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      );

  Widget _secPrayerLocation(L10n l, BuildContext ctx) => _buildCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.prayerLocationDesc,
              style: const TextStyle(
                  fontSize: 12, color: Colors.white38, height: 1.5),
            ),
            const SizedBox(height: 14),
            // Current location display
            InkWell(
              onTap: () => _showCityPicker(ctx, l),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        size: 18, color: _kGreenLight),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _prayerLocationName ?? l.notSelected,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        size: 18, color: Colors.white38),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Refresh widgets button
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    _hapticLight();
                    try {
                      await HomeWidget.updateWidget(
                          androidName: 'QuranWidgetProvider');
                      await HomeWidget.updateWidget(
                          androidName: 'QuranWidgetProviderLarge');
                      await HomeWidget.updateWidget(
                          androidName: 'AyahWidgetProvider');
                      const platform =
                          MethodChannel('com.abuhashim.khalafquran/widget');
                      await platform.invokeMethod('scheduleWidgetUpdate');
                    } catch (_) {}
                    _showSnack(AppState.instance.l.widgetsRefreshed);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          size: 13,
                          color: _kGreenMid.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          l.refreshWidgets,
                          style: TextStyle(
                            fontSize: 11,
                            color: _kGreenMid.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> _refreshLocationName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('prayer_location_name');
    if (mounted) setState(() => _prayerLocationName = name);
  }

  Future<void> _showCityPicker(BuildContext ctx, L10n l) async {
    // Comprehensive list of cities with coordinates
    final cities = [
      // Middle East & Gulf
      ('Mecca, Saudi Arabia', 21.4225, 39.8262),
      ('Medina, Saudi Arabia', 24.4644, 39.5891),
      ('Jeddah, Saudi Arabia', 21.5433, 39.1727),
      ('Riyadh, Saudi Arabia', 24.7136, 46.6753),
      ('Dubai, UAE', 25.2048, 55.2708),
      ('Abu Dhabi, UAE', 24.4539, 54.3773),
      ('Doha, Qatar', 25.2854, 51.5310),
      ('Kuwait City, Kuwait', 29.3759, 47.9774),
      ('Manama, Bahrain', 26.0667, 50.5577),
      ('Muscat, Oman', 23.6100, 58.5400),
      ('Amman, Jordan', 31.9454, 35.9284),
      ('Baghdad, Iraq', 33.3128, 44.3615),
      ('Damascus, Syria', 33.5138, 36.2765),
      ('Beirut, Lebanon', 33.8886, 35.4955),
      ('Cairo, Egypt', 30.0444, 31.2357),
      ('Alexandria, Egypt', 31.2001, 29.9187),
      ('Giza, Egypt', 30.0131, 31.2089),

      // Pakistan
      ('Karachi, Pakistan', 24.8607, 67.0011),
      ('Lahore, Pakistan', 31.5204, 74.3587),
      ('Islamabad, Pakistan', 33.6844, 73.0479),
      ('Rawalpindi, Pakistan', 33.5651, 73.0169),
      ('Faisalabad, Pakistan', 31.4181, 72.9790),
      ('Multan, Pakistan', 30.1575, 71.5249),
      ('Hyderabad, Pakistan', 25.3960, 68.4753),
      ('Peshawar, Pakistan', 34.0151, 71.5249),
      ('Quetta, Pakistan', 30.1798, 66.9750),
      ('Gujranwala, Pakistan', 32.1814, 74.1857),
      ('Sialkot, Pakistan', 32.4917, 74.5245),
      ('Sargodha, Pakistan', 32.0836, 72.6411),

      // India
      ('Delhi, India', 28.7041, 77.1025),
      ('Mumbai, India', 19.0760, 72.8777),
      ('Bangalore, India', 12.9716, 77.5946),
      ('Hyderabad, India', 17.3850, 78.4867),
      ('Chennai, India', 13.0827, 80.2707),
      ('Kolkata, India', 22.5726, 88.3639),
      ('Pune, India', 18.5204, 73.8567),
      ('Ahmedabad, India', 23.0225, 72.5714),
      ('Jaipur, India', 26.9124, 75.7873),
      ('Lucknow, India', 26.8467, 80.9462),
      ('Indore, India', 22.7196, 75.8577),
      ('Vadodara, India', 22.3072, 73.1812),
      ('Nagpur, India', 21.1458, 79.0882),
      ('Chandigarh, India', 30.7333, 76.7794),
      ('Bhopal, India', 23.1815, 79.9864),
      ('Visakhapatnam, India', 17.6869, 83.2185),
      ('Srinagar, India', 34.0837, 74.7973),
      ('Guwahati, India', 26.1445, 91.7362),

      // Bangladesh & Sri Lanka
      ('Dhaka, Bangladesh', 23.8103, 90.4125),
      ('Chittagong, Bangladesh', 22.3384, 91.8320),
      ('Khulna, Bangladesh', 22.8456, 89.5622),
      ('Rajshahi, Bangladesh', 24.3745, 88.6042),
      ('Colombo, Sri Lanka', 6.9271, 80.7789),
      ('Kandy, Sri Lanka', 6.9271, 80.6369),

      // Malaysia & Southeast Asia
      ('Kuala Lumpur, Malaysia', 3.1390, 101.6869),
      ('George Town, Malaysia', 5.4164, 100.3327),
      ('Johor Bahru, Malaysia', 1.4854, 103.7618),
      ('Jakarta, Indonesia', -6.2088, 106.8456),
      ('Surabaya, Indonesia', -7.2506, 112.7508),
      ('Bandung, Indonesia', -6.9175, 107.6123),
      ('Medan, Indonesia', 2.1968, 98.6722),
      ('Bangkok, Thailand', 13.7563, 100.5018),
      ('Chiang Mai, Thailand', 18.7883, 98.9853),
      ('Manila, Philippines', 14.5995, 120.9842),
      ('Cebu, Philippines', 10.3157, 123.8854),
      ('Davao, Philippines', 7.1315, 125.4521),

      // Africa - North
      ('Marrakech, Morocco', 31.6295, -8.0100),
      ('Fez, Morocco', 34.0333, -5.0000),
      ('Tangier, Morocco', 35.7595, -5.8336),
      ('Casablanca, Morocco', 33.5731, -7.5898),
      ('Tunis, Tunisia', 36.8065, 10.1686),
      ('Algiers, Algeria', 36.7538, 3.0588),
      ('Oran, Algeria', 35.7404, -0.6433),
      ('Constantine, Algeria', 36.3650, 6.6147),
      ('Tripoli, Libya', 32.8872, 13.1913),
      ('Benghazi, Libya', 32.1165, 20.0566),

      // Africa - East
      ('Nairobi, Kenya', -1.2865, 36.8172),
      ('Mombasa, Kenya', -4.0435, 39.6682),
      ('Addis Ababa, Ethiopia', 9.0320, 38.7469),
      ('Mogadishu, Somalia', 2.0469, 45.3182),
      ('Dar es Salaam, Tanzania', -6.8000, 39.2833),
      ('Zanzibar, Tanzania', -6.1592, 39.1955),
      ('Khartoum, Sudan', 15.5527, 32.5599),

      // Africa - West
      ('Lagos, Nigeria', 6.5244, 3.3792),
      ('Accra, Ghana', 5.6037, -0.1870),
      ('Kumasi, Ghana', 6.6753, -1.6236),
      ('Dakar, Senegal', 14.7167, -17.4674),
      ('Saint-Louis, Senegal', 16.0333, -16.4833),
      ('Conakry, Guinea', 9.5412, -13.7031),
      ('Abidjan, Ivory Coast', 5.3364, -4.0261),

      // Africa - South
      ('Cape Town, South Africa', -33.9249, 18.4241),
      ('Johannesburg, South Africa', -26.2023, 28.0436),
      ('Durban, South Africa', -29.8587, 31.0218),
      ('Pretoria, South Africa', -25.7461, 28.2293),
      ('Harare, Zimbabwe', -17.8252, 31.0335),
      ('Lusaka, Zambia', -15.3875, 28.2864),

      // Europe
      ('Istanbul, Turkey', 41.0082, 28.9784),
      ('London, UK', 51.5074, -0.1278),
      ('Paris, France', 48.8566, 2.3522),
      ('Berlin, Germany', 52.5200, 13.4050),
      ('Rome, Italy', 41.9028, 12.4964),
      ('Madrid, Spain', 40.4168, -3.7038),
      ('Amsterdam, Netherlands', 52.3676, 4.9041),
      ('Brussels, Belgium', 50.8503, 4.3517),
      ('Vienna, Austria', 48.2082, 16.3738),
      ('Lisbon, Portugal', 38.7223, -9.1393),
      ('Copenhagen, Denmark', 55.6761, 12.5683),
      ('Stockholm, Sweden', 59.3293, 18.0686),
      ('Moscow, Russia', 55.7558, 37.6173),

      // North America
      ('New York, USA', 40.7128, -74.0060),
      ('Los Angeles, USA', 34.0522, -118.2437),
      ('Chicago, USA', 41.8781, -87.6298),
      ('Houston, USA', 29.7604, -95.3698),
      ('Phoenix, USA', 33.4484, -112.0742),
      ('Toronto, Canada', 43.6532, -79.3832),
      ('Vancouver, Canada', 49.2827, -123.1207),
      ('Mexico City, Mexico', 19.4326, -99.1332),

      // South America
      ('Buenos Aires, Argentina', -34.6037, -58.3816),
      ('São Paulo, Brazil', -23.5505, -46.6333),
      ('Rio de Janeiro, Brazil', -22.9068, -43.1729),
      ('Lima, Peru', -12.0464, -77.0428),
      ('Bogotá, Colombia', 4.7110, -74.0721),

      // Asia - East & South East (additional)
      ('Singapore, Singapore', 1.3521, 103.8198),
      ('Hong Kong, China', 22.3193, 114.1694),
      ('Shanghai, China', 31.2304, 121.4737),
      ('Beijing, China', 39.9042, 116.4074),
      ('Tokyo, Japan', 35.6762, 139.6503),
      ('Seoul, South Korea', 37.5665, 126.9780),

      // Oceania
      ('Sydney, Australia', -33.8688, 151.2093),
      ('Melbourne, Australia', -37.8136, 144.9631),
      ('Auckland, New Zealand', -37.0082, 174.7850),
    ];

    final selected = await showDialog<(String, double, double)?>(
      context: ctx,
      builder: (context) => _CityPickerDialog(
        cities: cities,
        title: l.selectCity,
      ),
    );

    if (selected != null) {
      final (name, lat, lon) = selected;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('prayer_location_name', name);
      await prefs.setString('prayer_location_lat', lat.toString());
      await prefs.setString('prayer_location_lon', lon.toString());

      // Update widget
      await HomeWidget.saveWidgetData<String>(
          'widget_latitude', lat.toString());
      await HomeWidget.saveWidgetData<String>(
          'widget_longitude', lon.toString());
      await HomeWidget.updateWidget(androidName: 'QuranWidgetProvider');
      await HomeWidget.updateWidget(androidName: 'QuranWidgetProviderLarge');

      // Schedule background widget updates
      try {
        const platform =
            MethodChannel('com.abuhashim.khalafquran/widget');
        await platform.invokeMethod('scheduleWidgetUpdate');
      } catch (e) {
        debugPrint('Error scheduling widget updates: $e');
      }

      if (mounted) setState(() => _prayerLocationName = name);
    }
  }

  Widget _secAbout(L10n l) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _kGreen.withValues(alpha: 0.55),
              const Color(0xFF0D2B0D),
              _kBgCard,
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
          border: Border.all(
            color: _kGreenMid.withValues(alpha: 0.22),
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Arabic ligature / calligraphy accent
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _kGreen.withValues(alpha: 0.25),
                border: Border.all(
                  color: _kGreenMid.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
              child: const Center(
                child: Text(
                  'خ',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF81C784),
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            const SizedBox(width: 18),
            // App name + riwayah + version
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l.appName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    l.riwayah,
                    style: TextStyle(
                      fontSize: 13,
                      color: _kGreenLight.withValues(alpha: 0.85),
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Version badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                l.aboutVersion
                    .replaceAll('Version: ', 'v')
                    .replaceAll('الإصدار: ', 'v')
                    .replaceAll('ورژن: ', 'v'),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white38,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      );
}

// ─── City Picker Dialog ────────────────────────────────────────────────────

class _CityPickerDialog extends StatefulWidget {
  final List<(String, double, double)> cities;
  final String title;

  const _CityPickerDialog({
    required this.cities,
    required this.title,
  });

  @override
  State<_CityPickerDialog> createState() => _CityPickerDialogState();
}

class _CityPickerDialogState extends State<_CityPickerDialog> {
  final _searchController = TextEditingController();
  late List<(String, double, double)> _filteredCities;

  @override
  void initState() {
    super.initState();
    _filteredCities = widget.cities;
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCities = query.isEmpty
          ? widget.cities
          : widget.cities
              .where((city) => city.$1.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // Shrink when the soft keyboard is visible so the Column always fits.
    final availableHeight = (mq.size.height
            - mq.viewInsets.bottom
            - mq.padding.top
            - mq.padding.bottom
            - 32) // 16 px dialog inset top + bottom
        .clamp(200.0, 600.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        height: availableHeight,
        child: Container(
        decoration: BoxDecoration(
          color: _kBgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _kGreenMid.withValues(alpha: 0.22),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 28,
              spreadRadius: 4,
            ),
            BoxShadow(
              color: _kGreen.withValues(alpha: 0.18),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _kGreen.withValues(alpha: 0.55),
                    const Color(0xFF0D2B0D),
                    _kBgCard,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: _kGreen.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _kGreenMid.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: _kGreenLight,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            // Search box
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: AppState.instance.l.searchCities,
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: _kGreenMid.withValues(alpha: 0.7),
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _filterCities();
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white38,
                            size: 18,
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor: _kBgDeep.withValues(alpha: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _kGreenMid.withValues(alpha: 0.18),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _kGreenMid.withValues(alpha: 0.18),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: _kGreenMid,
                      width: 1.5,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            // Divider
            Container(
              height: 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              color: _kGreenMid.withValues(alpha: 0.12),
            ),
            // Cities list
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                child: _filteredCities.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_off_outlined,
                              size: 40,
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              AppState.instance.l.noCitiesFound,
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: _filteredCities.length,
                      itemBuilder: (context, index) {
                        final (name, lat, lon) = _filteredCities[index];
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _hapticLight();
                              Navigator.pop(context, (name, lat, lon));
                            },

                            splashColor: _kGreen.withValues(alpha: 0.2),
                            highlightColor: _kGreen.withValues(alpha: 0.08),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 11),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: 16,
                                    color: _kGreenMid.withValues(alpha: 0.55),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 16,
                                    color: Colors.white.withValues(alpha: 0.15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),   // ClipRRect
            ),   // Flexible
          ],
        ),
      ),
    ),  // SizedBox
    );
  }
}

// ─── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: Colors.white38,
        ),
      ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _GoalRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withValues(alpha: 0.1),
                  border: Border.all(
                      color: iconColor.withValues(alpha: 0.3), width: 1.2),
                ),
                child: Icon(icon, color: iconColor, size: 17),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(label,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.white70)),
              ),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, size: 16, color: Colors.white24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Stats Sheet ───────────────────────────────────────────────────────────────

class _StatsSheet extends StatefulWidget {
  final int streak;
  final Duration totalTime;
  final Duration todayTime;

  const _StatsSheet({
    required this.streak,
    required this.totalTime,
    required this.todayTime,
  });

  @override
  State<_StatsSheet> createState() => _StatsSheetState();
}

class _StatsSheetState extends State<_StatsSheet> {
  int _dailyGoalMinutes = PrefsService.defaultDailyGoalMinutes;
  int _totalGoalHours = PrefsService.defaultTotalGoalHours;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    try {
      final daily = await PrefsService.getDailyGoalMinutes();
      final total = await PrefsService.getTotalGoalHours();
      if (mounted) {
        setState(() {
          _dailyGoalMinutes = daily;
          _totalGoalHours = total;
        });
      }
    } catch (e) {
      debugPrint('Error loading goals in stats sheet: $e');
    }
  }

  String _fmt(Duration d) => AppState.instance.l.formatDuration(d);

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;
    final todayFrac = _dailyGoalMinutes > 0
        ? (widget.todayTime.inSeconds / (_dailyGoalMinutes * 60))
            .clamp(0.0, 1.0)
        : 0.0;
    final totalFrac = _totalGoalHours > 0
        ? (widget.totalTime.inSeconds / (_totalGoalHours * 3600))
            .clamp(0.0, 1.0)
        : 0.0;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1E0D),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 20),

            // Streak hero
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF7043).withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFFF7043).withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_fire_department,
                      color: Color(0xFFFF7043), size: 26),
                  Text(
                    l.toLocalNum(widget.streak),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l.dayStreak,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white38,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 12),

            // Streak dots — cycle + completed-weeks counter
            _StreakDots(streak: widget.streak),

            const SizedBox(height: 20),

            // Reading time cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Today card
                  Expanded(
                    child: _TimeRingCard(
                      label: l.today,
                      time: _fmt(widget.todayTime),
                      fraction: todayFrac,
                      color: _kGreenLight,
                      sublabel: l.goalMinutes(_dailyGoalMinutes),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Total card
                  Expanded(
                    child: _TimeRingCard(
                      label: l.totalTime,
                      time: _fmt(widget.totalTime),
                      fraction: totalFrac,
                      color: const Color(0xFF64B5F6),
                      sublabel: l.goalHours(_totalGoalHours),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}

// ─── Streak Dots (cycle + counter) ──────────────────────────────────────────
//
// Shows 7 dots representing the current 7-day "lap" of the streak.
// Dots that fall within today's lap are filled orange; the rest are dim.
// Completed full weeks are shown as a ×N badge to the right.
//
// Examples:
//   streak=3  → 3 filled, 4 dim, no badge
//   streak=7  → 7 filled, no badge   (just completed first week)
//   streak=8  → 1 filled, 6 dim, ×1
//   streak=18 → 4 filled, 3 dim, ×2

// Pre-calculated constant colors used by _StreakDots — avoids Color object
// allocation on every build call.
const _kStreakOrange = Color(0xFFFF7043);
const _kStreakDimDot = Color(0x1AFFFFFF); // white @ 10 %
const _kStreakBadgeBg = Color(0x26FF7043); // orange @ ~15 %
const _kStreakBadgeBorder = Color(0x66FF7043); // orange @ ~40 %

class _StreakDots extends StatelessWidget {
  final int streak;

  const _StreakDots({required this.streak});

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;
    final completedWeeks = streak ~/ 7;
    final dotsToFill = streak % 7;

    final filledCount = dotsToFill == 0 && streak > 0 ? 7 : dotsToFill;
    final badgeCount =
        dotsToFill == 0 && streak > 0 ? completedWeeks - 1 : completedWeeks;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(7, (i) {
          final filled = i < filledCount;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled ? _kStreakOrange : _kStreakDimDot,
            ),
          );
        }),
        if (badgeCount > 0) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: _kStreakBadgeBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _kStreakBadgeBorder,
                width: 1.0,
              ),
            ),
            child: Text(
              '×${l.toLocalNum(badgeCount)}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: _kStreakOrange,
                height: 1.0,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Stat Chip (used in settings reading stats card) ─────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;
  final double fraction;
  final Color barColor;
  final String sublabel;

  const _StatChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.fraction,
    required this.barColor,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 13),
              const SizedBox(width: 4),
              Expanded(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontSize: 10, color: Colors.white38)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: valueColor,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 3,
              backgroundColor: Colors.white.withValues(alpha: 0.07),
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
          const SizedBox(height: 3),
          Text(sublabel,
              style: const TextStyle(fontSize: 9, color: Colors.white24)),
        ],
      ),
    );
  }
}

// ─── Reading Heatmap Widget ────────────────────────────────────────────────────

class _ReadingHeatmap extends StatelessWidget {
  final DateTime month;
  final Map<String, int> history;
  final double Function(String dateKey) intensity;
  final Color heatColor;
  final String monthLabel;
  final bool isCurrentMonth;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final L10n l;

  const _ReadingHeatmap({
    required this.month,
    required this.history,
    required this.intensity,
    required this.heatColor,
    required this.monthLabel,
    required this.isCurrentMonth,
    required this.onPrev,
    required this.onNext,
    required this.l,
  });

  static const _dayLabels   = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _dayLabelsAr = ['إ', 'ث', 'أ', 'خ', 'ج', 'س', 'ح'];
  static const _dayLabelsUr = ['پ', 'م', 'ب', 'ج', 'ج', 'ہ', 'ا']; // Mon–Sun Urdu abbrevs

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final daysInMo = DateUtils.getDaysInMonth(month.year, month.month);
    final firstWd = DateTime(month.year, month.month, 1).weekday; // 1=Mon
    final startCol = firstWd - 1; // 0-indexed column offset
    final totalCells = startCol + daysInMo;
    final rows = (totalCells / 7).ceil();
    final labels = switch (l.lang) {
      AppLanguage.english => _dayLabels,
      AppLanguage.arabic  => _dayLabelsAr,
      AppLanguage.urdu    => _dayLabelsUr,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Month nav header
          Row(
            children: [
              _HeatNavBtn(icon: Icons.chevron_left_rounded, onTap: onPrev),
              Expanded(
                child: Text(
                  monthLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              _HeatNavBtn(
                icon: Icons.chevron_right_rounded,
                onTap: isCurrentMonth ? null : onNext,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Day-of-week labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                7,
                (i) => SizedBox(
                      width: 32,
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white24),
                      ),
                    )),
          ),

          const SizedBox(height: 6),

          // Calendar grid
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(rows, (row) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (col) {
                    final cellIndex = row * 7 + col;
                    final dayNum = cellIndex - startCol + 1;

                    if (dayNum < 1 || dayNum > daysInMo) {
                      return const SizedBox(width: 32, height: 32);
                    }

                    final cellDate = DateTime(month.year, month.month, dayNum);
                    final isFuture = cellDate.isAfter(today);
                    final isToday = cellDate == today;
                    final dateKey = '${month.year}-'
                        '${month.month.toString().padLeft(2, '0')}-'
                        '${dayNum.toString().padLeft(2, '0')}';
                    final ity = isFuture ? 0.0 : intensity(dateKey);

                    return _HeatCell(
                      day: dayNum,
                      intensity: ity,
                      isToday: isToday,
                      isFuture: isFuture,
                      heatColor: heatColor,
                    );
                  }),
                ),
              );
            }),
          ),

          const SizedBox(height: 10),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l.heatmapLess,
                  style: const TextStyle(fontSize: 9, color: Colors.white24)),
              const SizedBox(width: 4),
              ...[0.0, 0.25, 0.50, 0.75, 1.0].map((v) => Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: v == 0.0
                          ? Colors.white.withValues(alpha: 0.08)
                          : heatColor.withValues(alpha: v * 0.85 + 0.10),
                    ),
                  )),
              const SizedBox(width: 4),
              Text(l.heatmapMore,
                  style: const TextStyle(fontSize: 9, color: Colors.white24)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Single heatmap cell ───────────────────────────────────────────────────────

class _HeatCell extends StatelessWidget {
  final int day;
  final double intensity;
  final bool isToday;
  final bool isFuture;
  final Color heatColor;

  const _HeatCell({
    required this.day,
    required this.intensity,
    required this.isToday,
    required this.isFuture,
    required this.heatColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = intensity == 0.0
        ? Colors.white.withValues(alpha: isFuture ? 0.03 : 0.07)
        : heatColor.withValues(alpha: intensity * 0.85 + 0.15);

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: isToday
            ? Border.all(
                color: Colors.white.withValues(alpha: 0.55), width: 1.2)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '$day',
        style: TextStyle(
          fontSize: 11,

          fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
          color: intensity > 0.5
              ? Colors.white
              : isFuture
                  ? Colors.white12
                  : Colors.white38,
        ),
      ),
    );
  }
}

// ─── Heatmap navigation button ────────────────────────────────────────────────

class _HeatNavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeatNavBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 22,
        color: onTap == null ? Colors.white12 : Colors.white38,
      ),
    );
  }
}

class _TimeRingCard extends StatelessWidget {
  final String label;
  final String time;
  final double fraction;
  final Color color;
  final String sublabel;

  const _TimeRingCard({
    required this.label,
    required this.time,
    required this.fraction,
    required this.color,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white38,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 72,
            height: 72,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _RingPainter(fraction: fraction, color: color),
                child: Center(
                  child: Text(
                    time,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: time.length > 5 ? 11 : 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Mini bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 3,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: 6),

          Text(
            sublabel,
            style: const TextStyle(fontSize: 10, color: Colors.white24),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double fraction;
  final Color color;

  const _RingPainter({required this.fraction, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = (size.width / 2) - 5;
    const strokeWidth = 5.0;

    // Background ring
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.07)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    if (fraction <= 0) return;

    // Progress arc
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2, // start at top
      2 * math.pi * fraction,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.fraction != fraction || old.color != color;
}

// ─── Surah List Screen ─────────────────────────────────────────────────────────

class SearchIntent extends Intent {
  const SearchIntent();
}

class EscapeIntent extends Intent {
  const EscapeIntent();
}

class SurahTabIntent extends Intent {
  const SurahTabIntent();
}

class JuzTabIntent extends Intent {
  const JuzTabIntent();
}

class HizbTabIntent extends Intent {
  const HizbTabIntent();
}

class ContinueReadingIntent extends Intent {
  const ContinueReadingIntent();
}

class BookmarksIntent extends Intent {
  const BookmarksIntent();
}

class SettingsIntent extends Intent {
  const SettingsIntent();
}

class StreakIntent extends Intent {
  const StreakIntent();
}

class PrevPageIntent extends Intent {
  const PrevPageIntent();
}

class NextPageIntent extends Intent {
  const NextPageIntent();
}

class EscIntent extends Intent {
  const EscIntent();
}

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filtered = kSurahs;
  List<Map<String, dynamic>> _filteredJuz = kJuz;
  List<Map<String, dynamic>> _filteredHizb = kHizb;
  Map<String, dynamic>? _lastRead;
  List<int> _bookmarks = [];
  late TabController _tabController;
  int _streak = 0;
  String? _openPanel; // 'bookmarks' | 'settings' | 'find' | 'streak'

  // ── Sidebar sliding pill ──────────────────────────────────────────────────
  final _tabColumnKey = GlobalKey();
  double _tabStepHeight = 36.0; // estimated, measured after first layout

  void _togglePanel(String name, VoidCallback openFn) {
    if (_openPanel == name) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      _openPanel = null;
      return;
    }
    if (_openPanel != null && Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    _openPanel = name;
    openFn();
  }

  bool _handleGlobalKey(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    if (!mounted) return false;

    // Don't hijack keystrokes while the user is typing in a text field.
    final primary = FocusManager.instance.primaryFocus;
    final isTyping = primary != null &&
        primary.context != null &&
        primary.context!.widget is EditableText;
    if (isTyping && event.logicalKey != LogicalKeyboardKey.escape) {
      return false;
    }

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.keyF) {
      _togglePanel('find', _showSearchDialog);
      return true;
    }
    if (key == LogicalKeyboardKey.digit1) {
      setState(() => _tabController.animateTo(0));
      return true;
    }
    if (key == LogicalKeyboardKey.digit2) {
      setState(() => _tabController.animateTo(1));
      return true;
    }
    if (key == LogicalKeyboardKey.digit3) {
      setState(() => _tabController.animateTo(2));
      return true;
    }
    if (key == LogicalKeyboardKey.keyC) {
      if (_lastRead != null) {
        _openPdf(_lastRead!['page'] as int, _lastRead!['surah'] as String);
      }
      return true;
    }
    if (key == LogicalKeyboardKey.keyB) {
      _togglePanel('bookmarks', _showBookmarks);
      return true;
    }
    if (key == LogicalKeyboardKey.tab) {
      _togglePanel('settings', _openSettings);
      return true;
    }
    if (key == LogicalKeyboardKey.keyS) {
      _togglePanel('streak', _showStatsSheet);
      return true;
    }
    if (key == LogicalKeyboardKey.escape) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
        _openPanel = null;
      }
      return true;
    }
    return false;
  }
  Duration _readingTime = Duration.zero;
  Duration _todayTime = Duration.zero;

  // Production-level: Prevent rapid successive stats updates
  DateTime? _lastStatsUpdate;
  static const _minStatsUpdateInterval = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadPrefs();
    _loadStats();
    AppState.instance.addListener(_rebuild);
    _initQuickActions();
    HardwareKeyboard.instance.addHandler(_handleGlobalKey);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureSidebarTabs());
  }

  void _initQuickActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.setShortcutItems([
      const ShortcutItem(
        type: 'action_continue_reading',
        localizedTitle: 'Continue Reading',
        icon:
            'ic_shortcut_book', // drawable in android/app/src/main/res/drawable
      ),
      const ShortcutItem(
        type: 'action_bookmarks',
        localizedTitle: 'Bookmarks',
        icon: 'ic_shortcut_bookmark',
      ),
    ]);
    quickActions.initialize((shortcutType) {
      if (!mounted) return;
      if (shortcutType == 'action_continue_reading') {
        // Wait for _lastRead to load, then open
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          final lr = _lastRead;
          if (lr != null) {
            _openPdf(
              lr['page'] as int,
              lr['surah'] as String,
            );
          }
        });
      } else if (shortcutType == 'action_bookmarks') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _showBookmarks();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    AppState.instance.removeListener(_rebuild);
    HardwareKeyboard.instance.removeHandler(_handleGlobalKey);
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _onTabChanged() {
    if (mounted) setState(() {});
  }

  void _measureSidebarTabs() {
    if (!mounted) return;
    final ctx = _tabColumnKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox;
    final h = box.size.height;
    if (h > 0) {
      final newStep = h / 3;
      if ((newStep - _tabStepHeight).abs() > 1) {
        setState(() => _tabStepHeight = newStep);
      }
    }
  }

  Future<void> _loadPrefs() async {
    final lastRead = await PrefsService.getLastRead();
    final bookmarks = await PrefsService.getBookmarks();
    if (!mounted) return;
    setState(() {
      _lastRead = lastRead;
      _bookmarks = bookmarks;
    });
  }

  Future<void> _loadStats() async {
    // Production-level: Debounce rapid calls to prevent update loops
    final now = DateTime.now();
    if (_lastStatsUpdate != null &&
        now.difference(_lastStatsUpdate!).inMilliseconds <
            _minStatsUpdateInterval.inMilliseconds) {
      return;
    }
    _lastStatsUpdate = now;

    try {
      // Single prefs await instead of three separate ones.
      final stats = await ReadingStatsService.getStats();
      if (!mounted) return;
      setState(() {
        _streak = stats.streak;
        _readingTime = stats.totalTime;
        _todayTime = stats.todayTime;
      });
    } catch (e) {
      // Production-level: Graceful error handling for stats loading
      debugPrint('Error loading stats: $e');
    }
  }

  void _showStatsSheet() {
    _hapticLight();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _StatsSheet(
        streak: _streak,
        totalTime: _readingTime,
        todayTime: _todayTime,
      ),
    ).then((_) {
      if (_openPanel == 'streak') _openPanel = null;
    });
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _filtered = kSurahs;
        _filteredJuz = kJuz;
        _filteredHizb = kHizb;
      });
      return;
    }
    final q = query.toLowerCase();
    setState(() {
      _filtered = kSurahs.where((s) {
        return (s['english'] as String).toLowerCase().contains(q) ||
            (s['arabic'] as String).contains(query) ||
            s['number'].toString().contains(q);
      }).toList();

      _filteredJuz = kJuz.where((j) {
        final nameEn = kJuzNames[(j['juz'] as int) - 1].toLowerCase();
        final nameAr = (j['arabic'] as String).toLowerCase();
        final numStr = j['juz'].toString();
        return nameEn.contains(q) || nameAr.contains(q) || numStr.contains(q);
      }).toList();

      _filteredHizb = kHizb.where((h) {
        final name = AppState.instance.l.hizbLabel(h['hizb'] as int).toLowerCase();
        final numStr = h['hizb'].toString();
        return name.contains(q) || numStr.contains(q);
      }).toList();
    });
  }

  Future<void> _openPdf(int page, String name) async {
    _hapticLight();

    // Completely clear focus and dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    // Additional safety: Ensure the system knows we are unfocussing
    FocusScope.of(context).unfocus();

    // Small delay to allow keyboard to close before pushing the PDF screen.
    await Future.delayed(const Duration(milliseconds: 150));
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            PdfScreen(initialPage: page, surahName: name),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 280),
      ),
    );
    _loadPrefs();
    _loadStats();
  }

  void _showBookmarks() {
    _hapticLight();
    final l = AppState.instance.l;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F1A0F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => _bookmarks.isEmpty
          ? SizedBox(
              height: 200,
              child: Center(
                child: Text(l.noBookmarks,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, height: 1.6)),
              ),
            )
          : FutureBuilder<Map<int, String>>(
              future: PrefsService.getBookmarkLabels(),
              builder: (ctx, snapshot) {
                final labels = snapshot.data ?? {};
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  children: [
                    Text(l.bookmarks,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ..._bookmarks.map(
                      (page) {
                        final label = labels[page];
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          leading: const Icon(Icons.bookmark,
                              color: _kGreenLight, size: 18),
                          title: Text(l.page(page),
                              style: const TextStyle(fontSize: 14)),
                          subtitle: label != null && label.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(surahNameForPage(page, l.lang),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white54)),
                                    const SizedBox(height: 2),
                                    Text(label,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: _kGreenLabel,
                                            fontStyle: FontStyle.italic)),
                                  ],
                                )
                              : Text(surahNameForPage(page, l.lang),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white54)),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 12, color: Colors.white24),
                          onTap: () {
                            Navigator.pop(context);
                            _openPdf(page, surahNameForPage(page, l.lang));
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),

    ).then((_) {
      if (_openPanel == 'bookmarks') _openPanel = null;
    });
  }

  void _showAudio() {
    _hapticLight();
    final currentSurah = QuranAudioManager.instance.currentSurah;

    final currentPage = currentSurah == null
        ? (_lastRead?['page'] as int? ?? 1)
        : (kSurahs[currentSurah - 1]['page'] as int);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _AudioSheet(
        currentPage: currentPage,
        onPageJump: (page) {
          Navigator.pop(context);
          _openPdf(page, surahNameForPage(page, AppState.instance.language));
        },
      ),
    );
  }

  void _openSettings() {
    _hapticLight();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SettingsScreen(),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(
                CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    ).then((_) {
      if (_openPanel == 'settings') _openPanel = null;
    });
  }

  // ── Shared tab content ──────────────────────────────────────────────────────
  Widget _buildTabContent(L10n l) {
    return TabBarView(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
      children: [
        _SurahTab(
          filtered: _filtered,
          onTap: (s) => _openPdf(
            s['page'] as int,
            l.lang == AppLanguage.english
                ? s['english'] as String
                : s['arabic'] as String,
          ),
        ),
        _JuzTab(
          filtered: _filteredJuz,
          onTap: (juz) => _openPdf(
            juz['page'] as int,
            l.lang == AppLanguage.english
                ? kJuzNames[(juz['juz'] as int) - 1]
                : juz['arabic'] as String,
          ),
        ),
        _HizbTab(
          filtered: _filteredHizb,
          onTap: (hizb) => _openPdf(
            hizb['page'] as int,
            AppState.instance.l.hizbLabel(hizb['hizb'] as int),
          ),
        ),
      ],
    );
  }

  // ── Animated sidebar tabs with sliding pill ────────────────────────────────────
  Widget _buildAnimatedSidebarTabs(L10n l) {
    final anim = _tabController.animation;
    if (anim == null) {
      // Fallback (shouldn't happen in practice)
      return Column(
        key: _tabColumnKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SidebarTab(
            label: l.tabSurahs,
            selectedness: 1.0,
            onTap: () => _tabController.animateTo(0),
          ),
          _SidebarTab(
            label: l.tabJuz,
            selectedness: 0.0,
            onTap: () => _tabController.animateTo(1),
          ),
          _SidebarTab(
            label: l.tabHizb,
            selectedness: 0.0,
            onTap: () => _tabController.animateTo(2),
          ),
        ],
      );
    }

    return AnimatedBuilder(
      animation: anim,
      builder: (context, _) {
        final v = anim.value; // 0.0 → 2.0

        // Smooth text-color selectedness per tab
        final sel0 = (1.0 - v).clamp(0.0, 1.0);
        final sel1 = 1.0 - (v - 1.0).abs().clamp(0.0, 1.0);
        final sel2 = (v - 1.0).clamp(0.0, 1.0);

        // Pill position: top-margin(3) + animation-value * measured-step-height
        final pillTop = 3.0 + v * _tabStepHeight;
        final pillHeight = (_tabStepHeight - 6.0).clamp(10.0, 200.0);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Tab text buttons (transparent bg, smooth interpolated text color)
            Column(
              key: _tabColumnKey,
              mainAxisSize: MainAxisSize.min,
              children: [
                _SidebarTab(
                  label: l.tabSurahs,
                  selectedness: sel0,
                  onTap: () => _tabController.animateTo(0),
                ),
                _SidebarTab(
                  label: l.tabJuz,
                  selectedness: sel1,
                  onTap: () => _tabController.animateTo(1),
                ),
                _SidebarTab(
                  label: l.tabHizb,
                  selectedness: sel2,
                  onTap: () => _tabController.animateTo(2),
                ),
              ],
            ),
            // Sliding pill
            Positioned(
              top: pillTop,
              left: 0,
              right: 0,
              height: pillHeight,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3E1E).withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Landscape sidebar ────────────────────────────────────────────────────────
  Widget _buildLandscapeLayout(L10n l) {
    return Row(
      children: [
        // Left sidebar
        Container(
          width: 64,
          color: const Color(0xFF0C180C),
          child: SafeArea(
            right: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // ── Animated sidebar tabs with sliding pill ──────────────
                  _buildAnimatedSidebarTabs(l),
                  const Divider(
                      color: Colors.white12,
                      height: 20,
                      indent: 12,
                      endIndent: 12),
                  // Continue Reading (only when there's a last-read page)
                  if (_lastRead != null)
                    Tooltip(
                      message: l.continueReading,
                      child: GestureDetector(
                        onTap: () => _openPdf(
                          _lastRead!['page'] as int,
                          _lastRead!['surah'] as String,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 4),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _kGreen.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _kGreenMid.withValues(alpha: 0.4),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _kGreen.withValues(alpha: 0.12),
                                blurRadius: 8,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: _kGreenLight,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Search
                  _SidebarIcon(
                    icon: Icons.search,
                    onTap: _showSearchDialog,
                    tooltip: l.searchHint,
                  ),
                  // Bookmarks
                  _SidebarIcon(
                    icon: Icons.bookmark_outline,
                    onTap: _showBookmarks,
                    tooltip: l.bookmarks,
                  ),
                  const Divider(
                      color: Colors.white12,
                      height: 20,
                      indent: 12,
                      endIndent: 12),
                  // Streak
                  GestureDetector(
                    onTap: _showStatsSheet,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: _kGreenLight, size: 18),
                          const SizedBox(height: 2),
                          Text(l.toLocalNum(_streak),
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                  // Audio
                  _SidebarIcon(
                    icon: Icons.headphones_rounded,
                    onTap: _showAudio,
                    tooltip: l.recitation,
                  ),
                  // Settings
                  _SidebarIcon(
                    icon: Icons.settings_outlined,
                    onTap: _openSettings,
                    tooltip: l.settings,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        // Vertical divider
        Container(width: 0.5, color: Colors.white.withValues(alpha: 0.07)),
        // Main content
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  // Search result indicator (shown when filtering)
                  if (_searchController.text.isNotEmpty)
                    Container(
                      color: const Color(0xFF0C180C),
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 14, color: Colors.white38),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _searchController.text,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white54),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _onSearch('');
                            },
                            child: const Icon(Icons.close,
                                size: 16, color: Colors.white38),
                          ),
                        ],
                      ),
                    ),
                  Expanded(child: _buildTabContent(l)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSearchDialog() {
    _hapticLight();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF0F1A0F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _onSearch,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: AppState.instance.l.searchHint,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.white24),
              prefixIcon:
                  const Icon(Icons.search, size: 19, color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onSubmitted: (_) => Navigator.pop(context),
          ),
        ),
      ),
    ).then((_) {
      setState(() {});
      if (_openPanel == 'find') _openPanel = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;
    final width = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final useDesktopLayout = width > 800 || isLandscape;

    if (useDesktopLayout) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      return Focus(
        autofocus: true,
        child: Scaffold(
          backgroundColor: _kBgDeep,
          body: _buildLandscapeLayout(l),
        ),
      );
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // ── Portrait layout (unchanged) ──────────────────────────────────────────
    return Focus(
      autofocus: true,
      child: Scaffold(
        backgroundColor: _kBgDeep,
            appBar: AppBar(
        backgroundColor: _kBgDeep,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const SizedBox(
          width: 36,
          height: 36,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(36, 36),
                painter: _DiamondPainter(),
              ),
              Text(
                'خ',

                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Scheherazade New',
                  fontSize: 16,
                  color: Color(0xFF81C784),
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  shadows: [
                    Shadow(
                      color: Color(0xAA2E7D32),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined, size: 22),
          onPressed: _openSettings,
          tooltip: l.settings,
        ),
        actions: [
          GestureDetector(
            onTap: _showStatsSheet,
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department,
                      color: _kGreenLight, size: 15),
                  const SizedBox(width: 4),
                  Text(l.toLocalNum(_streak),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.white70)),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_outline, size: 22),
            onPressed: _showBookmarks,
            tooltip: l.bookmarks,
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Container(
              height: 36,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(11),
              ),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                 overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                   indicator: BoxDecoration(
                  color: const Color(0xFF1E3E1E),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.4)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: _kGreenLabel,
                unselectedLabelColor: Colors.white38,
                labelStyle: const TextStyle(
                    fontFamily: 'Scheherazade New',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Scheherazade New',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  Tab(text: l.tabSurahs, height: 30),
                  Tab(text: l.tabJuz, height: 30),
                  Tab(text: l.tabHizb, height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: RepaintBoundary(
        child: _BottomAudioBar(onOpenAudio: _showAudio),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: l.searchHint,
                hintStyle: const TextStyle(fontSize: 14, color: Colors.white24),
                prefixIcon:
                    const Icon(Icons.search, size: 19, color: Colors.white24),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18, color: Colors.white38),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _lastRead == null
                ? const SizedBox.shrink()
                : RepaintBoundary(
                    key: ValueKey(_lastRead!['page']),
                    child: GestureDetector(
                      onTap: () => _openPdf(
                        _lastRead!['page'] as int,
                        _lastRead!['surah'] as String,
                      ),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                const Color(0xFF2E7D32).withValues(alpha: 0.22),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              _kGreen.withValues(alpha: 0.18),
                              const Color(0xFF0C180C).withValues(alpha: 0.0),
                            ],
                            stops: const [0.0, 0.55],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _kGreen.withAlpha(22),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.menu_book,
                                color: _kGreenLight, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l.continueReading,
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 11),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${_lastRead!['surah']}  •  ${l.page(_lastRead!['page'] as int)}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white24, size: 13),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildTabContent(l)),
        ],
      ),
    ),
  ),
  );
  }
}

// ─── Sidebar helpers ───────────────────────────────────────────────────────────

class _SidebarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  const _SidebarIcon(
      {required this.icon, required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 22),
      color: Colors.white54,
      onPressed: onTap,
      tooltip: tooltip,
      padding: const EdgeInsets.symmetric(vertical: 6),
      constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
      style: IconButton.styleFrom(
        hoverColor: const Color(0xFF1E3E1E).withValues(alpha: 0.5),
      ),
    );
  }
}

class _SidebarTab extends StatelessWidget {
  final String label;
  final double selectedness; // 0.0 → unselected, 1.0 → selected
  final VoidCallback onTap;
  const _SidebarTab(
      {required this.label, required this.selectedness, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selectedness > 0.5 ? FontWeight.w600 : FontWeight.w400,
            color: Color.lerp(Colors.white38, _kGreenLabel, selectedness),
          ),
        ),
      ),
    );
  }
}

// ─── Surah Tab ─────────────────────────────────────────────────────────────────

class _SurahTab extends StatefulWidget {
  final List<Map<String, dynamic>> filtered;
  final void Function(Map<String, dynamic>) onTap;
  const _SurahTab({required this.filtered, required this.onTap});

  @override
  State<_SurahTab> createState() => _SurahTabState();
}

class _SurahTabState extends State<_SurahTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.filtered.isEmpty) {
      final l = AppState.instance.l;
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomPaint(
              size: Size(64, 64),
              painter: _FadedDiamondPainter(),
            ),
            const SizedBox(height: 16),
            Text(
              l.noResults,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    final isDesktop = !Platform.isAndroid && !Platform.isIOS;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final useGrid = isDesktop || isLandscape;

    return RepaintBoundary(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            sliver: useGrid
                ? SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 12,
                      childAspectRatio: 5.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final s = widget.filtered[index];
                        return _SurahListItem(
                          surah: s,
                          onTap: () => widget.onTap(s),
                        );
                      },
                      childCount: widget.filtered.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final s = widget.filtered[index];
                        return _SurahListItem(
                          surah: s,
                          onTap: () => widget.onTap(s),
                        );
                      },
                      childCount: widget.filtered.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SurahListItem extends StatefulWidget {
  final Map<String, dynamic> surah;
  final VoidCallback onTap;

  const _SurahListItem({
    required this.surah,
    required this.onTap,
  });

  @override
  State<_SurahListItem> createState() => _SurahListItemState();
}

class _SurahListItemState extends State<_SurahListItem> {
  // Cache previous download state to avoid unnecessary rebuilds
  bool _wasDownloaded = false;
  // Cache previous progress to detect changes
  double? _lastProgress;

  @override
  void initState() {
    super.initState();
    _checkDownloadStatus();
    // Optimize: Only listen to download progress for this specific surah
    QuranAudioManager.instance.addListener(_onAudioServiceUpdate);
  }

  @override
  void dispose() {
    QuranAudioManager.instance.removeListener(_onAudioServiceUpdate);
    super.dispose();
  }

  /// Optimized: Only rebuild if THIS surah's download status or progress changed
  void _onAudioServiceUpdate() {
    final surahNum = widget.surah['number'] as int;
    final isDownloaded = QuranAudioManager.instance.isKnownDownloaded(surahNum);
    final progress = QuranAudioManager.instance.downloadProgress[surahNum];

    // Only rebuild if download state or in-progress download changed
    if ((isDownloaded != _wasDownloaded || progress != _lastProgress) && mounted) {
      _wasDownloaded = isDownloaded;
      _lastProgress = progress;
      setState(() {});
    }
  }

  Future<void> _checkDownloadStatus() async {
    final downloaded = await QuranAudioManager.instance
        .isDownloaded(widget.surah['number'] as int);
    if (!mounted) return;
    setState(() => _wasDownloaded = downloaded);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14);
    final l = AppState.instance.l;

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: PressScale(
          onTap: widget.onTap,
          child: Material(
            color: _kBgCard,
            borderRadius: borderRadius,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: ClipRect(
                child: Row(
                children: [
                      // ── Number badge ──────────────────────────────────────
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E1A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          l.toLocalNum(widget.surah["number"] as int),
                          style: const TextStyle(
                            fontFamily: 'Scheherazade New',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: _kGreenLabel,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // ── Name + page ───────────────────────────────────────
                      Expanded(
                        child: l.lang == AppLanguage.english
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.surah['english'] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.surah['arabic'] as String,
                                          textDirection: TextDirection.rtl,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: 'Scheherazade New',
                                            fontSize: 14,
                                            color: _kGreenLabel,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l.page(widget.surah["page"] as int),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white38),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.surah['arabic'] as String,
                                    textDirection: TextDirection.rtl,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Scheherazade New',
                                      fontSize: 16,
                                      color: _kGreenLabel,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l.page(widget.surah["page"] as int),
                                    textDirection: TextDirection.rtl,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.white38),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
              ),
                ),
              ),
            ),
          ),
        );
  }
}

// ─── Juz Tab ───────────────────────────────────────────────────────────────────

class _JuzTab extends StatefulWidget {
  final List<Map<String, dynamic>> filtered;
  final void Function(Map<String, dynamic>) onTap;
  const _JuzTab({required this.filtered, required this.onTap});

  @override
  State<_JuzTab> createState() => _JuzTabState();
}

class _JuzTabState extends State<_JuzTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDesktop = !Platform.isAndroid && !Platform.isIOS;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final useGrid = isDesktop || isLandscape;

    return RepaintBoundary(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            sliver: useGrid
                ? SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 12,
                      childAspectRatio: 5.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final juz = widget.filtered[index];
                        return _JuzListItem(
                          juz: juz,
                          onTap: () => widget.onTap(juz),
                        );
                      },
                      childCount: widget.filtered.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final juz = widget.filtered[index];
                        return _JuzListItem(
                          juz: juz,
                          onTap: () => widget.onTap(juz),
                        );
                      },
                      childCount: widget.filtered.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _JuzListItem extends StatelessWidget {
  final Map<String, dynamic> juz;
  final VoidCallback onTap;

  const _JuzListItem({
    required this.juz,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final juzNum = juz['juz'] as int;
    final juzName = kJuzNames[juzNum - 1];
    final l = AppState.instance.l;

    final borderRadius = BorderRadius.circular(14);

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: PressScale(
          onTap: onTap,
          child: Material(
            color: _kBgCard,
            borderRadius: borderRadius,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: ClipRect(
                child: Row(
                children: [
                      // ── Number badge ──────────────────────────────────────
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF161E28),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          l.toLocalNum(juzNum),
                          style: const TextStyle(
                            fontFamily: 'Scheherazade New',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64B5F6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // ── Name + page ───────────────────────────────────────
                      Expanded(
                        child: l.lang == AppLanguage.english
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    juzName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          juz['arabic'] as String,
                                          textDirection: TextDirection.rtl,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: 'Scheherazade New',
                                            fontSize: 13,
                                            color: Color(0xFF64B5F6),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        l.startsPage(juz['page'] as int),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    juz['arabic'] as String,
                                    textDirection: TextDirection.rtl,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Scheherazade New',
                                      fontSize: 16,
                                      color: Color(0xFF64B5F6),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    l.startsPage(juz['page'] as int),
                                    textDirection: TextDirection.rtl,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white38, fontSize: 11),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
              ),
                ),
              ),
            ),
          ),
        );
  }
}

// ─── Hizb Tab ──────────────────────────────────────────────────────────────────

class _HizbTab extends StatefulWidget {
  final List<Map<String, dynamic>> filtered;
  final void Function(Map<String, dynamic>) onTap;
  const _HizbTab({required this.filtered, required this.onTap});

  @override
  State<_HizbTab> createState() => _HizbTabState();
}

class _HizbTabState extends State<_HizbTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDesktop = !Platform.isAndroid && !Platform.isIOS;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final useGrid = isDesktop || isLandscape;

    return RepaintBoundary(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            sliver: useGrid
                ? SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 12,
                      childAspectRatio: 5.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final hizb = widget.filtered[index];
                        return _HizbListItem(
                          hizb: hizb,
                          onTap: () => widget.onTap(hizb),
                        );
                      },
                      childCount: widget.filtered.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final hizb = widget.filtered[index];
                        return _HizbListItem(
                          hizb: hizb,
                          onTap: () => widget.onTap(hizb),
                        );
                      },
                      childCount: widget.filtered.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _HizbListItem extends StatelessWidget {
  final Map<String, dynamic> hizb;
  final VoidCallback onTap;

  const _HizbListItem({required this.hizb, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hizbNum = hizb['hizb'] as int;
    final juzNum = hizb['juz'] as int;
    final pageNum = hizb['page'] as int;
    final l = AppState.instance.l;

    // Within the juz, is this the 1st or 2nd hizb?
    final isSecondHalf = hizbNum.isEven;
    // Accent colour distinguishes second half within each juz
    const Color primaryColor = Color(0xFF80CBC4); // teal-ish
    const Color secondaryColor = Color(0xFF4DB6AC);

    final borderRadius = BorderRadius.circular(14);

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: PressScale(
          onTap: onTap,
          child: Material(
            color: _kBgCard,
            borderRadius: borderRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: ClipRect(
                child: Row(
                children: [
                  // ── Hizb number badge ─────────────────────────────────────
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSecondHalf
                          ? const Color(0xFF0E1E1E)
                          : const Color(0xFF0C1A18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      l.toLocalNum(hizbNum),
                      style: TextStyle(
                        fontFamily: 'Scheherazade New',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isSecondHalf ? secondaryColor : primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // ── Label + juz/page ──────────────────────────────────────
                  Expanded(
                    child: l.lang == AppLanguage.english
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.hizbLabel(hizbNum),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: isSecondHalf
                                      ? secondaryColor
                                      : primaryColor,
                                ),
                              ),
                              Text(
                                '${l.tabJuz} $juzNum  •  ${l.startsPage(pageNum)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white38, fontSize: 11),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                l.hizbLabel(hizbNum),
                                textDirection: TextDirection.rtl,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Scheherazade New',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: isSecondHalf
                                      ? secondaryColor
                                      : primaryColor,
                                ),
                              ),
                              Text(
                                '${l.tabJuz} ${l.toLocalNum(juzNum)}  •  ${l.startsPage(pageNum)}',
                                textDirection: TextDirection.rtl,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white38, fontSize: 11),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// OPTIMIZED PDF RENDERING SYSTEM
// ═══════════════════════════════════════════════════════════════════════════════

/// Device-aware rendering configuration
/// Automatically adapts to device capabilities
class _RenderingConfig {
  final int deviceDpi;
  final double devicePixelRatio;
  final Size screenSize;

  // Adaptive cache strategy
  late final double cacheExtent;
  late final int maxPixelBudget;
  late final double fastRenderScale;
  late final double renderQualityThreshold;

  _RenderingConfig({
    required this.deviceDpi,
    required this.devicePixelRatio,
    required this.screenSize,
  }) {
    _initializeAdaptiveValues();
  }

  /// Initialize adaptive rendering values based on device capabilities
  void _initializeAdaptiveValues() {
    final screenPixels =
        (screenSize.width * screenSize.height * devicePixelRatio).toInt();

    if (screenPixels > 3500000) {
      cacheExtent = 1.5;
      maxPixelBudget = 8000000;
      renderQualityThreshold = 1.8;

    } else if (screenPixels > 2000000) {
      cacheExtent = 1.0;
      maxPixelBudget = 6000000;
      renderQualityThreshold = 1.6;
    } else {
      cacheExtent = 0.5;
      maxPixelBudget = 4500000;
      renderQualityThreshold = 1.4;
    }

    // Fixed at 150 DPI — fast enough for instant rendering on any device
    // including SDM439-class SoCs, while still exceeding what most phone
    // screens physically display at 1x zoom.
    //
    // On a 720p 2x-DPR phone at fit-to-width, the screen only needs ~87 DPI.
    // At 150 DPI the page is rendered at 1.7x the screen resolution —
    // text looks pixel-perfect at 1x zoom and crisp up to ~2x pinch-zoom.
    // Beyond that, the quality pass at the user's DPI setting (default 420)
    // kicks in for deep-zoom sharpness.
    //
    // 150/72 = 2.08x → ~1240x1750px = 2.2MP per page
    // (was 300 DPI = 4.17x → ~2480x3300px = 8.2MP — nearly 4x slower)
    fastRenderScale = 150.0 / 72.0;
  }
}

/// Optimized rendering strategy for PDF pages
class _OptimizedRenderingStrategy {
  final _RenderingConfig config;
  final double maxDpiScale;

  late final double _computedFastScale;
  late final double _computedQualityScale;

  _OptimizedRenderingStrategy({
    required this.config,
    required this.maxDpiScale,
  }) {
    _computedFastScale = config.fastRenderScale;
    _computedQualityScale = maxDpiScale;
  }

  /// Get the optimal rendering scale for a given page.
  ///
  /// For normal reading (estimatedScale <= fast * 1.4), returns the fast scale —
  /// a single-pass render that's already 1.25x the device DPI, so text is
  /// pixel-perfect at 1x zoom with headroom for light pinch-zooming.
  ///
  /// For deep zoom (estimatedScale > fast * 1.4), returns a higher-quality
  /// scale capped by the pixel budget so the page stays sharp when zoomed.
  double getOptimalScale({
    required double estimatedScale,
    required double pageWidth,
    required double pageHeight,
    required bool isFastPass,
  }) {
    // Single-pass zone: normal reading + light zoom (up to ~1.75x device DPI).
    // Fast scale is already deviceDpi * 1.25, so 1.4x on top = deviceDpi * 1.75.
    // No quality pass needed — the fast render is already sharper than the screen.
    if (isFastPass || estimatedScale <= _computedFastScale * 1.4) {
      return _computedFastScale;
    }

    // Quality pass zone: user pinch-zoomed in significantly.
    // Render at the higher quality scale, but cap to pixel budget.
    final targetScale = _computedQualityScale;
    final pixelsAtTarget =
        (pageWidth * targetScale) * (pageHeight * targetScale);

    if (pixelsAtTarget <= config.maxPixelBudget) {
      return targetScale;
    }

    final scaleFactor = config.maxPixelBudget / pixelsAtTarget;
    final cappedScale = targetScale * math.sqrt(scaleFactor);

    return cappedScale.clamp(_computedFastScale, targetScale);
  }

}

// ─── Drawing Overlay (local pen/highlighter annotations) ───────────────────────
//
// Strokes are stored in *document space* (the same coordinate space used by
// PdfViewerController.value), so a single full-screen CustomPaint layer
// renders correctly under any pan/zoom without needing one paint widget per
// page. Strokes are bucketed by Quran page number purely for storage
// (load/save granularity, undo scoping), keeping the saved file small and
// edits scoped to the page the user is actually on. The active page for a
// new stroke is simply whichever page is currently on screen (_currentPage).

enum _DrawTool { pen, highlighter, eraser }

class _DrawPoint {
  final double x, y; // document-space coordinates
  const _DrawPoint(this.x, this.y);
  List<double> toJson() => [x, y];
  static _DrawPoint fromJson(List<dynamic> j) =>
      _DrawPoint((j[0] as num).toDouble(), (j[1] as num).toDouble());
}

class _Stroke {
  final int page;
  final _DrawTool tool;
  final Color color;
  final double width;
  final List<_DrawPoint> points;

  _Stroke({
    required this.page,
    required this.tool,
    required this.color,
    required this.width,
    required this.points,
  });

  // Computed once and cached — safe because `points` is only appended to
  // while a stroke is still `_current` (in progress); by the time a stroke
  // sits in `_strokes` and is eligible for erasing, it's finished and immutable.
  Rect? _boundsCache;
  Rect get bounds {
    final cached = _boundsCache;
    if (cached != null) return cached;
    var minX = points.first.x, maxX = points.first.x;
    var minY = points.first.y, maxY = points.first.y;
    for (final p in points.skip(1)) {
      if (p.x < minX) minX = p.x;
      if (p.x > maxX) maxX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.y > maxY) maxY = p.y;
    }
    final r = Rect.fromLTRB(minX, minY, maxX, maxY);
    _boundsCache = r;
    return r;
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'tool': tool.index,
        'color': color.toARGB32(),
        'width': width,
        'pts': points.map((p) => p.toJson()).toList(),
      };

  static _Stroke fromJson(Map<String, dynamic> j) => _Stroke(
        page: j['page'] as int,
        tool: _DrawTool.values[j['tool'] as int],
        color: Color(j['color'] as int),
        width: (j['width'] as num).toDouble(),
        points: (j['pts'] as List)
            .map((p) => _DrawPoint.fromJson(p as List<dynamic>))
            .toList(),
      );
}

/// Local on-disk persistence for one PDF's annotations (all pages, one file).
class _DrawingStore {
  static Future<File> _file(String docKey) async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/annotations');
    if (!await folder.exists()) await folder.create(recursive: true);
    return File('${folder.path}/$docKey.json');
  }

  static Future<List<_Stroke>> load(String docKey) async {
    try {
      final f = await _file(docKey);
      if (!await f.exists()) return [];
      final raw = await f.readAsString();
      if (raw.trim().isEmpty) return [];
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => _Stroke.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Drawing load error: $e');
      return [];
    }
  }

  static Future<void> save(String docKey, List<_Stroke> strokes) async {
    try {
      final f = await _file(docKey);
      await f.writeAsString(jsonEncode(strokes.map((s) => s.toJson()).toList()));
    } catch (e) {
      debugPrint('Drawing save error: $e');
    }
  }
}

// ── Undo/redo command types ───────────────────────────────────────────────────
abstract class _DrawCommand {}

class _AddStrokeCmd extends _DrawCommand {
  final _Stroke stroke;
  _AddStrokeCmd(this.stroke);
}

class _EraseCmd extends _DrawCommand {
  final List<_Stroke> removed; // strokes removed in one erase gesture
  _EraseCmd(this.removed);
}

/// Owns tool state, the in-memory stroke list, undo/redo, and debounced saves.
class _DrawingController extends ChangeNotifier {
  final String docKey;
  _DrawingController(this.docKey);

  static const int _maxHistory = 50;

  bool toolbarOpen = false;
  bool drawingEnabled = false;
  _DrawTool tool = _DrawTool.pen;
  Color color = const Color(0xFFFF5252);
  double strokeWidth = 4.0;

  static const List<Color> palette = [
    Color(0xFFFF5252),
    Color(0xFFFFD740),
    Color(0xFF40C4FF),
    Color(0xFF69F0AE),
    Color(0xFFE040FB),
    Colors.white,
  ];

  static const List<double> widthPresets = [2.0, 4.0, 7.0, 11.0];

  final List<_Stroke> _strokes = [];
  List<_Stroke> get strokes => _strokes;

  // `_strokes` is mutated in place (add/remove), never reassigned, so its
  // object identity never changes — CustomPainter.shouldRepaint can't detect
  // additions/removals by comparing the list reference. This counter is
  // bumped on every structural change so the painter can compare versions
  // instead.
  int _strokesVersion = 0;
  int get strokesVersion => _strokesVersion;

  // Unified command history for both draw and erase operations.
  final List<_DrawCommand> _undoStack = [];
  final List<_DrawCommand> _redoStack = [];

  // Accumulates strokes erased during a single erase gesture (pointer-down → up).
  final List<_Stroke> _pendingErased = [];

  _Stroke? _current;
  Timer? _saveDebounce;
  bool _loaded = false;

  // Fires on every single point added while drawing/erasing — much higher
  // frequency than everything else this controller tracks (tool changes,
  // toolbar open/close, etc). Kept separate from notifyListeners() so only
  // the canvas (which actually needs per-point updates) rebuilds on every
  // pointer move, instead of every AnimatedBuilder listening to this
  // controller (top bar, drawing toolbar, the PDF viewer wrapper) repainting
  // 60x/sec while a stroke is in progress.
  final ValueNotifier<int> strokeTick = ValueNotifier<int>(0);

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    _loaded = true;
    final loaded = await _DrawingStore.load(docKey);
    _strokes.addAll(loaded);
    _strokesVersion++;
    notifyListeners();
  }

  void toggleToolbar() {
    toolbarOpen = !toolbarOpen;
    drawingEnabled = toolbarOpen;
    notifyListeners();
  }

  void closeToolbar() {
    toolbarOpen = false;
    drawingEnabled = false;
    notifyListeners();
  }

  void setTool(_DrawTool t) {
    tool = t;
    notifyListeners();
  }

  void setColor(Color c) {
    color = c;
    notifyListeners();
  }

  void setWidth(double w) {
    strokeWidth = w;
    notifyListeners();
  }

  void startStroke(int page, double x, double y) {
    if (tool == _DrawTool.eraser) {
      _eraseAt(page, x, y);
      return;
    }
    _current = _Stroke(
      page: page,
      tool: tool,
      color: tool == _DrawTool.highlighter ? color.withValues(alpha: 0.35) : color,
      width: tool == _DrawTool.highlighter ? strokeWidth * 4 : strokeWidth,
      points: [_DrawPoint(x, y)],
    );
    strokeTick.value++;
  }

  void extendStroke(int page, double x, double y) {
    if (tool == _DrawTool.eraser) {
      _eraseAt(page, x, y);
      return;
    }
    _current?.points.add(_DrawPoint(x, y));
    strokeTick.value++;
  }

  void endStroke() {
    final s = _current;
    _current = null;
    if (s != null && s.points.length > 1) {
      _strokes.add(s);
      _strokesVersion++;
      _pushUndo(_AddStrokeCmd(s));
      _scheduleSave();
    }
    // Commit any erased strokes from this gesture as one erase command.
    if (_pendingErased.isNotEmpty) {
      _pushUndo(_EraseCmd(List.of(_pendingErased)));
      _pendingErased.clear();
      _scheduleSave();
    }
    notifyListeners();
  }

  void _eraseAt(int page, double x, double y) {
    const hitRadius = 18.0;
    final removed = <_Stroke>[];
    _strokes.removeWhere((s) {
      if (s.page != page) return false;
      // Cheap reject: skip the per-point scan entirely if the eraser isn't
      // even near this stroke's bounding box. Matters once a page has built
      // up a lot of annotations.
      final b = s.bounds;
      if (x < b.left - hitRadius ||
          x > b.right + hitRadius ||
          y < b.top - hitRadius ||
          y > b.bottom + hitRadius) {
        return false;
      }
      for (final p in s.points) {
        if ((p.x - x).abs() < hitRadius && (p.y - y).abs() < hitRadius) {
          removed.add(s);
          return true;
        }
      }
      return false;
    });
    if (removed.isNotEmpty) {
      _pendingErased.addAll(removed);
      _strokesVersion++;
      strokeTick.value++;
    }
  }

  void _pushUndo(_DrawCommand cmd) {
    _redoStack.clear(); // new action always clears redo
    _undoStack.add(cmd);
    if (_undoStack.length > _maxHistory) _undoStack.removeAt(0);
  }

  _Stroke? get currentStroke => _current;

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void undo() {
    if (_undoStack.isEmpty) return;
    final cmd = _undoStack.removeLast();
    if (cmd is _AddStrokeCmd) {
      _strokes.remove(cmd.stroke);
      _redoStack.add(cmd);
    } else if (cmd is _EraseCmd) {
      // Restore erased strokes in original order.
      _strokes.addAll(cmd.removed);
      _redoStack.add(cmd);
    }
    _strokesVersion++;
    _scheduleSave();
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    final cmd = _redoStack.removeLast();
    if (cmd is _AddStrokeCmd) {
      _strokes.add(cmd.stroke);
      _undoStack.add(cmd);
    } else if (cmd is _EraseCmd) {
      for (final s in cmd.removed) _strokes.remove(s);
      _undoStack.add(cmd);
    }
    _strokesVersion++;
    _scheduleSave();
    notifyListeners();
  }

  void _scheduleSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 500), () {
      _DrawingStore.save(docKey, _strokes);
    });
  }

  void flushSave() {
    _saveDebounce?.cancel();
    _DrawingStore.save(docKey, _strokes);
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    strokeTick.dispose();
    super.dispose();
  }
}

/// Full-screen paint layer. Sits above the PdfViewer; only intercepts touches
/// when [_DrawingController.drawingEnabled] is true. Coordinates are
/// converted screen <-> document space using the same matrix math the viewer
/// already uses for double-tap zoom.
class _DrawingCanvas extends StatefulWidget {
  final _DrawingController controller;
  final PdfViewerController viewerController;
  final int Function() currentPage;

  const _DrawingCanvas({
    required this.controller,
    required this.viewerController,
    required this.currentPage,
  });

  @override
  State<_DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<_DrawingCanvas> {
  int? _activePage;
  int? _drawingPointerId; // the single pointer currently drawing, if any
  final Set<int> _activePointers = {};

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
    widget.controller.strokeTick.addListener(_onChange);
    widget.viewerController.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    widget.controller.strokeTick.removeListener(_onChange);
    widget.viewerController.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  Offset? _toDocSpace(Offset globalPos) {
    final local = widget.viewerController.globalToLocal(globalPos);
    if (local == null) return null;
    final m = vm.Matrix4.copy(widget.viewerController.value)..invert();
    final v = vm.Vector3(local.dx, local.dy, 0);
    final r = m.transform3(v);
    return Offset(r.x, r.y);
  }

  void _cancelDrawing() {
    if (_drawingPointerId != null) {
      widget.controller.endStroke();
      _drawingPointerId = null;
      _activePage = null;
    }
  }

  void _onPointerDown(PointerDownEvent e) {
    _activePointers.add(e.pointer);

    // A second finger landed — this is a pan/zoom gesture, not drawing.
    // Bail out of any in-progress stroke and let the viewer underneath
    // (which also receives this same pointer, since we're translucent)
    // handle pan/zoom on its own.
    if (_activePointers.length > 1) {
      _cancelDrawing();
      return;
    }

    // First (and only) finger down — start drawing.
    final doc = _toDocSpace(e.position);
    if (doc == null) return;
    final page = widget.currentPage();
    _drawingPointerId = e.pointer;
    _activePage = page;
    widget.controller.startStroke(page, doc.dx, doc.dy);
  }

  void _onPointerMove(PointerMoveEvent e) {
    // Ignore movement from any pointer that isn't the one actively drawing
    // (e.g. a second finger that just landed for a pinch gesture).
    if (_activePointers.length > 1 || e.pointer != _drawingPointerId) return;
    final doc = _toDocSpace(e.position);
    final page = _activePage;
    if (doc == null || page == null) return;
    widget.controller.extendStroke(page, doc.dx, doc.dy);
  }

  void _onPointerUp(PointerUpEvent e) {
    _activePointers.remove(e.pointer);
    if (e.pointer == _drawingPointerId) {
      widget.controller.endStroke();
      _drawingPointerId = null;
      _activePage = null;
    }
  }

  void _onPointerCancel(PointerCancelEvent e) {
    _activePointers.remove(e.pointer);
    if (e.pointer == _drawingPointerId) {
      widget.controller.endStroke();
      _drawingPointerId = null;
      _activePage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.controller.drawingEnabled;

    return IgnorePointer(
      ignoring: !enabled,
      child: Listener(
        // translucent: pointers are also delivered to the PdfViewer's own
        // InteractiveViewer below, so two-finger pan/zoom keeps working
        // exactly as it does outside drawing mode. We never enter Flutter's
        // gesture arena (no GestureDetector/PanGestureRecognizer here), so
        // we can't "win" and steal the second finger from the viewer.
        behavior: HitTestBehavior.translucent,
        onPointerDown: _onPointerDown,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerUp,
        onPointerCancel: _onPointerCancel,
        child: IgnorePointer(
          // The painted strokes themselves shouldn't absorb hits — only the
          // Listener above (already attached to this same subtree) needs
          // raw events; this just guards the CustomPaint child.
          child: CustomPaint(
            painter: _StrokesPainter(
              strokes: widget.controller.strokes,
              strokesVersion: widget.controller.strokesVersion,
              current: widget.controller.currentStroke,
              viewMatrix: widget.viewerController.isReady
                  ? widget.viewerController.value
                  : null,
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _StrokesPainter extends CustomPainter {
  final List<_Stroke> strokes;
  final int strokesVersion;
  final _Stroke? current;
  final vm.Matrix4? viewMatrix;

  _StrokesPainter({
    required this.strokes,
    required this.strokesVersion,
    this.current,
    this.viewMatrix,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final m = viewMatrix;
    if (m == null) return;
    canvas.save();
    canvas.transform(m.storage);
    for (final s in strokes) {
      _paintStroke(canvas, s);
    }
    if (current != null) _paintStroke(canvas, current!);
    canvas.restore();
  }

  void _paintStroke(Canvas canvas, _Stroke s) {
    if (s.points.length < 2) return;
    final paint = Paint()
      ..color = s.color
      ..strokeWidth = s.width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..blendMode = s.tool == _DrawTool.highlighter ? BlendMode.multiply : BlendMode.srcOver;
    final path = Path()..moveTo(s.points.first.x, s.points.first.y);
    for (final p in s.points.skip(1)) {
      path.lineTo(p.x, p.y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _StrokesPainter old) =>
      old.strokesVersion != strokesVersion ||
      old.current != current ||
      // `current` is mutated in place point-by-point as the user drags, so
      // identity alone can't detect a stroke that grew since the last paint.
      old.current?.points.length != current?.points.length ||
      old.viewMatrix != viewMatrix;
}

/// Compact, collapsible drawing toolbar shown below the top bar when the pen
/// icon is toggled. Kept narrow and pill-shaped so it doesn't flood the screen.
class _DrawingToolbar extends StatelessWidget {
  final _DrawingController controller;
  const _DrawingToolbar({required this.controller});

  Widget _toolBtn(_DrawTool t, IconData icon) {
    final selected = controller.tool == t;
    return _ToolbarIconButton(
      icon: icon,
      selected: selected,
      onTap: () {
        _hapticSelect();
        controller.setTool(t);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (!controller.toolbarOpen) return const SizedBox.shrink();
        final showThickness = controller.tool != _DrawTool.eraser;
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _toolBtn(_DrawTool.pen, Icons.edit_rounded),
                        _toolBtn(_DrawTool.highlighter, Icons.border_color_rounded),
                        _toolBtn(_DrawTool.eraser, Icons.auto_fix_normal_rounded),
                        Container(
                          width: 1,
                          height: 22,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                        ..._DrawingController.palette.map((c) {
                          final selected = controller.color.toARGB32() == c.toARGB32();
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: GestureDetector(
                              onTap: () {
                                _hapticSelect();
                                controller.setColor(c);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: selected ? 26 : 20,
                                height: selected ? 26 : 20,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected ? Colors.white : Colors.white24,
                                    width: selected ? 2 : 1,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSize(
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOut,
                            child: !showThickness
                                ? const SizedBox.shrink()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: Icon(Icons.line_weight_rounded,
                                            size: 15, color: Colors.white38),
                                      ),
                                      ..._DrawingController.widthPresets.map((w) {
                                        final selected = controller.strokeWidth == w;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: GestureDetector(
                                            onTap: () {
                                              _hapticSelect();
                                              controller.setWidth(w);
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? _kGreenLight.withValues(alpha: 0.18)
                                                    : Colors.transparent,
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: w + 4,
                                                height: w + 4,
                                                decoration: BoxDecoration(
                                                  color: selected
                                                      ? _kGreenLight
                                                      : Colors.white70,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Container(
                                        width: 1,
                                        height: 22,
                                        margin: const EdgeInsets.symmetric(horizontal: 6),
                                        color: Colors.white.withValues(alpha: 0.12),
                                      ),
                                    ],
                                  ),
                          ),
                          _ToolbarIconButton(
                            icon: Icons.undo_rounded,
                            enabled: controller.canUndo,
                            onTap: () {
                              _hapticLight();
                              controller.undo();
                            },
                          ),
                          _ToolbarIconButton(
                            icon: Icons.redo_rounded,
                            enabled: controller.canRedo,
                            onTap: () {
                              _hapticLight();
                              controller.redo();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ToolbarIconButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _ToolbarIconButton({
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.35,
      child: InkResponse(
        onTap: enabled ? onTap : null,
        radius: 22,
        child: Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: selected ? _kGreenLight.withValues(alpha: 0.18) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 19,
            color: selected ? _kGreenLight : Colors.white70,
          ),
        ),
      ),
    );
  }
}

// ─── PDF Screen ────────────────────────────────────────────────────────────────

class PdfScreen extends StatefulWidget {
  final int initialPage;
  final String surahName;

  const PdfScreen({
    super.key,
    required this.initialPage,
    required this.surahName,
  });

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final PdfViewerController _viewerController = PdfViewerController();
  bool _isBookmarked = false;
  int _currentPage = 1;
  int _totalPages = 0;
  String _currentSurah = '';
  bool _barsVisible = true;
  Timer? _barHideTimer;
  bool _isNavigating = false;
  Offset? _lastDoubleTapGlobal;
  DateTime? _sessionStart;
  bool _isLocked = false; // Lock toggle for camera movement
  double? _lockedXPosition; // Store X position when lock is enabled
  double _currentZoom = 1.0; // Current zoom level for the slider

  // ── Optimized Rendering System ──────────────────────────────────
  int _maxDpi = PrefsService.defaultMaxDpi;
  late _RenderingConfig _renderConfig;
  late _OptimizedRenderingStrategy _renderStrategy;
  bool _configInitialized = false;

  // ── Settle-and-enhance: upgrade current page to high-res after dwell ──
  // Fast low-res appears instantly on page flip; after 3 seconds of staying
  // on the same page, the rendering scale jumps to the user's max DPI for
  // crisp text.  If the user flips away, the timer cancels — casual browsers
  // never pay the high-res cost, while focused readers always get sharp text.
  Timer? _settleTimer;
  bool _enhanceActive = false; // true = quality scale is in effect
  static const _settleDelay = Duration(seconds: 3);

  // ── Drawing overlay ──────────────────────────────────────────────
  late final _DrawingController _drawCtrl = _DrawingController('khalaf');

  static const Duration _barHideDelay = Duration(seconds: 4);
  static const double _dragShowThreshold = 6.0;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable(); // Keep screen on while reading
    _sessionStart = DateTime.now();
    _currentPage = widget.initialPage;
    _currentSurah =
        surahNameForPage(widget.initialPage, AppState.instance.language);
    _checkBookmark(widget.initialPage);
    _viewerController.addListener(_onControllerUpdate);
    _viewerController.addListener(_constrainHorizontalMovement);
    AppState.instance.addListener(_rebuild);
    _drawCtrl.addListener(_rebuild);
    QuranAudioManager.instance.addListener(_onAudioUpdate);
    _loadDpi();
    _drawCtrl.ensureLoaded();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize rendering config synchronously on the first frame so the
    // PDF viewer is created immediately — no spinner, no postFrameCallback delay.
    if (!_configInitialized) _initializeRenderingConfig();
  }

  /// Initialize rendering config with actual device info
  void _initializeRenderingConfig() {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final dpr = mediaQuery.devicePixelRatio;

    _renderConfig = _RenderingConfig(
      deviceDpi: (160 * dpr).toInt(),
      devicePixelRatio: dpr,
      screenSize: screenSize,
    );

    _updateRenderStrategy();
    _configInitialized = true;

    if (mounted) setState(() {});
  }

  /// Update rendering strategy when DPI changes
  void _updateRenderStrategy() {
    if (_configInitialized) {
      _renderStrategy = _OptimizedRenderingStrategy(
        config: _renderConfig,
        maxDpiScale: _maxDpi / 72.0,
      );
    }
  }

  Future<void> _loadDpi() async {
    final dpi = await PrefsService.getMaxDpi();
    if (!mounted) return;
    setState(() {
      _maxDpi = dpi;
      if (_configInitialized) {
        _updateRenderStrategy();
      }
    });
  }

  @override
  void dispose() {
    _viewerController.removeListener(_onControllerUpdate);
    _viewerController.removeListener(_constrainHorizontalMovement);
    _drawCtrl.removeListener(_rebuild);
    AppState.instance.removeListener(_rebuild);
    QuranAudioManager.instance.removeListener(_onAudioUpdate);
    _barHideTimer?.cancel();
    _settleTimer?.cancel();

    // Fire-and-forget — intentional. Save last read position.
    try {
      unawaited(PrefsService.saveLastRead(
        _currentPage,
        surahNameForPage(_currentPage, AppState.instance.language),
      ));
    } catch (e) {
      debugPrint('Error saving last read: $e');
    }

    // Record reading time statistics
    final session = _sessionStart;
    if (session != null) {
      try {
        unawaited(ReadingStatsService.addReadingTime(
          DateTime.now().difference(session),
        ));
      } catch (e) {
        debugPrint('Error adding reading time: $e');
      }
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    // Restore orientations if locked when reader closes
    if (_isLocked) {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }

    WakelockPlus.disable(); // Release screen-on lock when leaving the reader

    _drawCtrl.flushSave();
    _drawCtrl.dispose();

    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _onAudioUpdate() {
    if (mounted) setState(() {});
  }

  void _onControllerUpdate() {
    if (_isNavigating || !_viewerController.isReady) return;

    final pdfPage = _viewerController.pageNumber;
    if (pdfPage == null) return;

    final quranPage = pdfPage.clamp(1, 604);
    final quranTotal = _viewerController.pageCount.clamp(0, 604);

    if (quranPage != _currentPage || quranTotal != _totalPages) {
      final surahName = surahNameForPage(quranPage, AppState.instance.language);
      setState(() {
        _currentPage = quranPage;
        _totalPages = quranTotal;
        _currentSurah = surahName;
      });
      _checkBookmark(quranPage);
      PrefsService.saveLastRead(quranPage, surahName);

      // Cancel any pending enhance on the old page and start fresh.
      _cancelSettle();
      _scheduleSettle();
    } else if (!_enhanceActive) {
      // Same page but enhance not yet triggered — still schedule it.
      _scheduleSettle();
    }
  }

  /// Constrain horizontal movement when lock is enabled
  void _constrainHorizontalMovement() {
    if (!_isLocked || !_viewerController.isReady) return;

    try {
      final matrix = _viewerController.value;

      // Extract current translation
      final translation = matrix.getTranslation();
      final translationX = translation.x;
      final translationY = translation.y;

      // Store the initial X position (when lock was enabled)
      _lockedXPosition ??= translationX;

      // Zero-tolerance: any horizontal drift at all gets snapped back instantly.
      // panEnabled is kept true so vertical scrolling works, but this listener
      // catches any horizontal drift and snaps it back to the locked position.
      if (translationX != _lockedXPosition) {
        final newMatrix = vm.Matrix4.copy(matrix);
        newMatrix
            .setTranslation(vm.Vector3(_lockedXPosition!, translationY, 0));
        _viewerController.value = newMatrix;
      }
    } catch (_) {
      // Silently ignore any errors in constraint
    }
  }

  Future<void> _checkBookmark(int page) async {
    final isBookmarked = await PrefsService.isBookmarked(page);
    if (!mounted) return;
    setState(() => _isBookmarked = isBookmarked);
  }

  Future<void> _toggleBookmark() async {
    final page = _currentPage;
    final wasBookmarked = await PrefsService.isBookmarked(page);
    final l = AppState.instance.l;

    if (!wasBookmarked) {
      // Show optional-label dialog before adding the bookmark
      if (!mounted) return;
      final labelCtrl = TextEditingController();
      String capturedLabel = '';
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF0F1A0F),
          title:
              Text(l.bookmarkLabelTitle, style: const TextStyle(fontSize: 15)),
          content: TextField(
              controller: labelCtrl,
              maxLength: 60,
              autofocus: false,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (value) {
                // Use the callback value directly — avoids accessing the
                // controller while the dialog route is tearing down.
                capturedLabel = value.trim();
                Navigator.pop(ctx);
              },
              decoration: InputDecoration(
                hintText: l.bookmarkLabelHint,
                hintStyle:
                    const TextStyle(color: Colors.white24, fontSize: 13),
                border: const OutlineInputBorder(),
                counterStyle:
                    const TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l.cancel,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: _kGreen, foregroundColor: Colors.white),
              onPressed: () {
                // Controller is still alive here (dialog hasn't started
                // popping yet), so reading .text is safe.
                capturedLabel = labelCtrl.text.trim();
                Navigator.pop(ctx);
              },
              child: Text(l.save,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ),
          ],
        ),
      );
      // Defer disposal to the next frame so the dialog's TextField has
      // fully unmounted and released its listener before we dispose the
      // controller. Without this, ChangeNotifier.dispose() hits the
      // _dependents.isEmpty assertion because the route teardown is still
      // in progress when we try to dispose.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        labelCtrl.dispose();
      });
      await PrefsService.toggleBookmark(page);
      if (capturedLabel.isNotEmpty) {
        await PrefsService.setBookmarkLabel(page, capturedLabel);
      }
    } else {
      // Removing bookmark — also wipe its label
      await PrefsService.toggleBookmark(page);
      await PrefsService.removeBookmarkLabel(page);
    }

    await _checkBookmark(page);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? l.bookmarkAdded : l.bookmarkRemoved,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C2A1C),
      ),
    );
    _hapticMedium();
  }

  void _toggleLock() {
    final newLocked = !_isLocked;

    if (newLocked) {
      final isLandscape =
          MediaQuery.of(context).orientation == Orientation.landscape;
      SystemChrome.setPreferredOrientations(
        isLandscape
            ? [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight
              ]
            : [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );
    } else {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }

    setState(() {
      _isLocked = newLocked;
      _lockedXPosition = null;
    });

    final l = AppState.instance.l;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newLocked ? l.cameraLocked : l.cameraUnlocked,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C2A1C),
      ),
    );
    _hapticLight();
  }

  void _showContextMenu(Offset globalPos) async {
    final l = AppState.instance.l;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset localPos = overlay.globalToLocal(globalPos);

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        localPos.dx,
        localPos.dy,
        overlay.size.width - localPos.dx,
        overlay.size.height - localPos.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'bookmark',
          child: Row(
            children: [
              Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                size: 18,
                color: _isBookmarked ? _kGreenLight : Colors.white70,
              ),
              const SizedBox(width: 12),
              Text(
                _isBookmarked ? l.bookmarkRemoved : l.bookmarkAdded,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'jump',
          child: Row(
            children: [
              const Icon(Icons.swap_vert, size: 18, color: Colors.white70),
              const SizedBox(width: 12),
              Text(l.goToPage, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'bookmark') _toggleBookmark();
      if (value == 'jump') _showJumpToPage();
    });
  }

  void _prevPage() async {
    if (_currentPage > 1) {
      await _jumpToPage(_currentPage - 1);
    }
  }

  void _nextPage() async {
    final maxPage = _totalPages > 0 ? _totalPages : 604;
    if (_currentPage < maxPage) {
      await _jumpToPage(_currentPage + 1);
    }
  }

  Future<void> _jumpToPage(int quranPage) async {
    if (_isNavigating) return;
    _isNavigating = true;
    setState(() {});

    try {
      // Wait for the PDF controller to become ready using a Completer instead
      // of a busy-loop, so we don't spin 100 × 50 ms if loading is slow.
      if (!_viewerController.isReady) {
        final readyCompleter = Completer<void>();
        void onReady() {
          if (_viewerController.isReady) {
            _viewerController.removeListener(onReady);
            if (!readyCompleter.isCompleted) readyCompleter.complete();
          }
        }
        _viewerController.addListener(onReady);
        // Safety timeout: give up after 5 s rather than looping forever.
        await readyCompleter.future.timeout(
          const Duration(seconds: 5),
          onTimeout: () {},
        );
        _viewerController.removeListener(onReady);
      }

      if (!mounted || !_viewerController.isReady) return;

      final maxPages =
          _viewerController.pageCount > 0 ? _viewerController.pageCount : 604;
      final target = quranPage.clamp(1, maxPages);

      await _viewerController.goToPage(pageNumber: target);

      // Wait for the page number to settle (completer-based, max 1.5 s).
      if ((_viewerController.pageNumber ?? 0) != target) {
        final pageCompleter = Completer<void>();
        void onPage() {
          if ((_viewerController.pageNumber ?? 0) == target) {
            _viewerController.removeListener(onPage);
            if (!pageCompleter.isCompleted) pageCompleter.complete();
          }
        }
        _viewerController.addListener(onPage);
        await pageCompleter.future.timeout(
          const Duration(milliseconds: 1500),
          onTimeout: () {},
        );
        _viewerController.removeListener(onPage);
      }

      if (!mounted) return;
      final surahName = surahNameForPage(quranPage, AppState.instance.language);
      setState(() {
        _currentPage = quranPage;
        _currentSurah = surahName;
      });
      _checkBookmark(quranPage);
      PrefsService.saveLastRead(quranPage, surahName);
      _setBarsVisible(true);
      _scheduleAutoHide();
    } finally {
      if (mounted) {
        _isNavigating = false;
        setState(() {});
      }
    }
  }

  void _showJumpToPage() {
    _hapticLight();
    final l = AppState.instance.l;
    final ctrl = TextEditingController();
    final maxPage = _totalPages > 0 ? _totalPages : 604;

    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F1A0F),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        title: Text(l.goToPage),
        content: SingleChildScrollView(
          child: TextField(
            controller: ctrl,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            cursorColor: Colors.white,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: '${l.toLocalNum(1)} – ${l.toLocalNum(maxPage)}',
              hintStyle: const TextStyle(color: Colors.white38),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
              ),
            ),
            onSubmitted: (value) async {
              final p = int.tryParse(value);
              if (p == null || p < 1 || p > maxPage) return;
              _hapticLight();
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pop(ctx);
              await Future.delayed(const Duration(milliseconds: 280));
              await _jumpToPage(p);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _hapticLight();
              Navigator.pop(ctx);
            },
            child: Text(l.cancel,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: _kGreen, foregroundColor: Colors.white),
            onPressed: () async {
              final p = int.tryParse(ctrl.text);
              if (p == null || p < 1 || p > maxPage) return;
              _hapticLight();
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pop(ctx);
              await Future.delayed(const Duration(milliseconds: 280));
              await _jumpToPage(p);
            },
            child: Text(l.go,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
        ],
      ),
    );
  }

  void _showAudio() {
    _hapticLight();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _AudioSheet(
        currentPage: _currentPage,
        onPageJump: (page) async {
          await Future.delayed(const Duration(milliseconds: 150));
          _jumpToPage(page);
        },
      ),
    );
  }

  void _setBarsVisible(bool visible) {
    if (_barsVisible == visible) return;
    setState(() => _barsVisible = visible);
  }

  void _cancelAutoHide() {
    _barHideTimer?.cancel();
    _barHideTimer = null;
  }

  void _scheduleAutoHide() {
    _cancelAutoHide();
    if (!_barsVisible) return;
    if (_drawCtrl.toolbarOpen) return; // keep bars up while drawing
    _barHideTimer = Timer(_barHideDelay, () {
      if (mounted) {
        setState(() => _barsVisible = false);
        _hapticSelect();
      }
    });
  }

  // ── Settle-and-enhance logic ─────────────────────────────────────
  /// Schedule a quality-render upgrade after the user stays on the same
  /// page for [_settleDelay].  If they flip before it fires, we cancel.
  void _scheduleSettle() {
    _cancelSettle();
    _settleTimer = Timer(_settleDelay, () {
      if (!mounted) return;
      setState(() => _enhanceActive = true);
    });
  }

  void _cancelSettle() {
    _settleTimer?.cancel();
    _settleTimer = null;
    if (_enhanceActive) {
      _enhanceActive = false;
      // Don't setState here — the page-change handler already calls setState.
    }
  }

  Widget _buildAppBarTitle() {
    final l = AppState.instance.l;
    final total = _totalPages > 0 ? _totalPages : 604;
    return GestureDetector(
      onTap: () {
        _hapticLight();
        _showJumpToPage();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _currentSurah.isNotEmpty ? _currentSurah : widget.surahName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            l.pageOf(_currentPage, total),
            style: const TextStyle(fontSize: 10, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  /// Build the optimized PDF viewer.
  ///
  /// Settle-and-enhance: page flips render at 150 DPI (instant).  After 3 s
  /// dwell on the same page, the scale jumps to the user's max DPI for crisp
  /// text.  Flip away → timer cancels, back to fast low-res.  Casual
  /// browsers never pay the high-res cost.
  Widget _buildPdfViewer() {
    final drawing = _drawCtrl.drawingEnabled;
    final dark = AppState.instance.darkMode;
    final enhance = _enhanceActive;
    return RepaintBoundary(
      child: ColorFiltered(
        colorFilter: dark
            ? const ColorFilter.matrix(<double>[
                // ── Luminance-inversion with hue preservation ──
                // Inverts Y (brightness) in YUV space, leaves U/V (hue) untouched.
                // White → Black, Black → White, Red stays red, Blue stays blue.
                //
                // R' =  0.402·R − 1.175·G − 0.228·B + 255
                // G' = −0.598·R − 0.174·G − 0.228·B + 255
                // B' = −0.598·R − 1.174·G + 0.772·B + 255
                // A' = A  (unchanged)
                 0.402, -1.175, -0.228, 0, 255,
                -0.598, -0.174, -0.228, 0, 255,
                -0.598, -1.174,  0.772, 0, 255,
                 0,      0,      0,     1, 0,
              ])
            : const ColorFilter.matrix(<double>[
                1, 0, 0, 0, 0,
                0, 1, 0, 0, 0,
                0, 0, 1, 0, 0,
                0, 0, 0, 1, 0,
              ]),
        child: PdfViewer.asset(
          'assets/pdf/khalaf.pdf',
          useProgressiveLoading: true,
          controller: _viewerController,
          initialPageNumber: widget.initialPage,
          params: PdfViewerParams(
            horizontalCacheExtent: _renderConfig.cacheExtent,
            verticalCacheExtent: _renderConfig.cacheExtent,
            limitRenderingCache: true,
            minScale: 0.5,
            maxScale: 20.0,
            useAlternativeFitScaleAsMinScale: false,
            // When locked: vertical scroll allowed, horizontal blocked by
            // _constrainHorizontalMovement listener. Zoom always blocked.
            // When drawing: no pan (strokes go to drawing layer), zoom OK.
            panEnabled: !drawing,
            scaleEnabled: !_isLocked,
            backgroundColor: dark
                ? const Color(0xFFF0F0F0)
                : const Color(0xFF0D0D0D),

            onInteractionStart: (_) {
              if (_drawCtrl.toolbarOpen) return;
              _cancelAutoHide();
            },
            onInteractionUpdate: (details) {
              if (_drawCtrl.toolbarOpen) return;
              final dy = details.focalPointDelta.dy;
              final dx = details.focalPointDelta.dx;
              if (_isLocked) {
                final isHorizontal = dx.abs() > dy.abs();
                if (isHorizontal) return;
              }
              if (dy.abs() > _dragShowThreshold && dy.abs() > dx.abs()) {
                _setBarsVisible(dy > _dragShowThreshold);
                _scheduleAutoHide();
              }
            },
            onInteractionEnd: (_) {
              if (_drawCtrl.toolbarOpen) return;
              if (_barsVisible) _scheduleAutoHide();
            },

            // ── Settle-and-enhance ──────────────────────────────────────
            // When enhanced (user dwelled 3s+), raise the single-pass
            // threshold so quality scale is always used at reading zoom.
            onePassRenderingScaleThreshold: enhance
                ? _renderConfig.fastRenderScale * 50.0 // always quality
                : _renderConfig.fastRenderScale * 1.4,

            getPageRenderingScale: (context, page, controller, estimatedScale) {
              if (enhance) {
                // User settled — render at their max DPI.
                return _renderStrategy.getOptimalScale(
                  estimatedScale: estimatedScale,
                  pageWidth: page.width,
                  pageHeight: page.height,
                  isFastPass: false,
                );
              }
              // Initial fast render — snappy low-DPI.
              return _renderStrategy.getOptimalScale(
                estimatedScale: estimatedScale,
                pageWidth: page.width,
                pageHeight: page.height,
                isFastPass: estimatedScale <= _renderConfig.fastRenderScale * 1.4,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const PrevPageIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const NextPageIntent(),
        LogicalKeySet(LogicalKeyboardKey.escape): const EscapeIntent(),
      },
      child: Actions(
        actions: {
          PrevPageIntent: CallbackAction<PrevPageIntent>(
            onInvoke: (intent) => _prevPage(),
          ),
          NextPageIntent: CallbackAction<NextPageIntent>(
            onInvoke: (intent) => _nextPage(),
          ),
          EscapeIntent: CallbackAction<EscapeIntent>(onInvoke: (intent) {
            if (!_barsVisible) {
              _setBarsVisible(true);
            } else {
              Navigator.pop(context);
            }
          }),
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
          // PDF viewer (full-screen) — GestureDetector absorbs both gesture
          // taps (secondary, double-tap) and raw pointer signals (Ctrl+scroll
          // zoom) in a single widget instead of two nested ones, saving one
          // layout pass per frame on low-end devices.
          Positioned.fill(
            child: GestureDetector(
              onSecondaryTapDown: (details) => _showContextMenu(details.globalPosition),
              // Listener merged into GestureDetector's onPointerSignal via
              // a thin wrapper below — avoids an extra widget in the tree.
              child: Listener(
                onPointerSignal: (event) {
                  if (event is PointerScrollEvent) {
                    if (HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlLeft) ||
                        HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlRight)) {
                      if (event.scrollDelta.dy < 0) {
                        _viewerController.zoomUp();
                      } else if (event.scrollDelta.dy > 0) {
                        _viewerController.zoomDown();
                      }
                    }
                  }
                },
                child: _buildPdfViewer(),
              ),
            ),
          ),

          // Tap / double-tap interaction layer
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _drawCtrl.toolbarOpen
                  ? null
                  : () {
                      _setBarsVisible(!_barsVisible);
                      if (_barsVisible) {
                        _hapticLight();
                        _scheduleAutoHide();
                      } else {
                        _cancelAutoHide();
                      }
                    },
              onDoubleTapDown: _drawCtrl.toolbarOpen
                  ? null
                  : (d) => _lastDoubleTapGlobal = d.globalPosition,
              onDoubleTap: _drawCtrl.toolbarOpen
                  ? null
                  : () async {
                      final gp = _lastDoubleTapGlobal;
                      try {
                        if (gp == null) {
                          await _viewerController.zoomUp();
                          return;
                        }
                        final local = _viewerController.globalToLocal(gp);
                        if (local == null) {
                          await _viewerController.zoomUp();
                          return;
                        }
                        final m = vm.Matrix4.copy(_viewerController.value)..invert();
                        final v = vm.Vector3(local.dx, local.dy, 0);
                        final r = m.transform3(v);
                        final docPos = Offset(r.x, r.y);
                        final nextZoom = _viewerController.getNextZoom();
                        await _viewerController.setZoom(docPos, nextZoom);
                        _hapticSelect();
                      } catch (_) {
                        await _viewerController.zoomUp();
                      }
                    },
            ),
          ),

          // Drawing overlay — only created when the toolbar is open,
          // eliminating a full-screen Listener + CustomPaint from the
          // widget tree during normal reading.
          if (_drawCtrl.toolbarOpen)
            Positioned.fill(
              child: _DrawingCanvas(
                controller: _drawCtrl,
                viewerController: _viewerController,
                currentPage: () => _currentPage,
              ),
            ),

          // ── Top bar ──────────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                offset: _barsVisible ? Offset.zero : const Offset(0, -1),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _barsVisible ? 1.0 : 0.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(height: topPadding, color: Colors.black),
                      ClipRect(
                        child: BackdropFilter(
                          filter:
                              ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                          child: Container(
                            height: kToolbarHeight,
                            color: Colors.black.withValues(alpha: 0.72),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 20),
                                  onPressed: () {
                                    _hapticLight();
                                    Navigator.maybePop(context);

                                  },
                                ),
                                const SizedBox(width: 4),
                                Expanded(child: _buildAppBarTitle()),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AnimatedBuilder(
                                      animation: _drawCtrl,
                                      builder: (context, _) => IconButton(
                                        icon: Icon(
                                          Icons.edit_rounded,
                                          size: 22,
                                          color: _drawCtrl.toolbarOpen
                                              ? _kGreenLight
                                              : Colors.white70,
                                        ),
                                        tooltip: 'Draw',
                                        onPressed: () {
                                          _hapticSelect();
                                          _drawCtrl.toggleToolbar();
                                          if (_drawCtrl.toolbarOpen) {
                                            _cancelAutoHide();
                                            _setBarsVisible(true);
                                          } else {
                                            setState(() {});
                                            _scheduleAutoHide();
                                          }
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.headphones_rounded,
                                          size: 22,
                                          color: QuranAudioManager.instance.hasActiveAudio
                                              ? _kGreenLight
                                              : Colors.white70),
                                      onPressed: _showAudio,
                                    ),
                                    IconButton(
                                      icon: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        transitionBuilder: (child, anim) =>
                                            ScaleTransition(
                                          scale: anim,
                                          child: child,
                                        ),
                                        child: Icon(
                                          _isLocked
                                              ? Icons.lock_rounded
                                              : Icons.lock_open_rounded,
                                          key: ValueKey(_isLocked),
                                          color: _isLocked
                                              ? _kGreenLight
                                              : Colors.white70,
                                          size: 22,
                                        ),
                                      ),
                                      onPressed: _toggleLock,
                                      tooltip: AppState.instance.l.lockCamera,
                                    ),
                                    if (MediaQuery.of(context).size.shortestSide >= 600)
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        width: 200,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.zoom_out, size: 18, color: Colors.white60),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Slider(
                                                value: _currentZoom,
                                                min: 0.5,
                                                max: 5.0,
                                                divisions: 45,
                                                activeColor: _kGreenLight,
                                                inactiveColor: Colors.white12,
                                                onChanged: (val) {
                                                  setState(() => _currentZoom = val);
                                                  _viewerController.setZoom(Offset.zero, val);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(Icons.zoom_in, size: 18, color: Colors.white60),
                                          ],
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: GestureDetector(
                                        onTap: _toggleBookmark,
                                        child: AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          transitionBuilder: (child, anim) =>
                                              ScaleTransition(
                                            scale: anim,
                                            child: child,
                                          ),
                                          child: Icon(
                                            _isBookmarked
                                                ? Icons.bookmark
                                                : Icons.bookmark_outline,
                                            key: ValueKey(_isBookmarked),
                                            color: _isBookmarked
                                                ? _kGreenLight
                                                : Colors.white70,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.swap_vert, size: 22),
                                      onPressed: _showJumpToPage,
                                    ),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _DrawingToolbar(controller: _drawCtrl),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    ),
  ),
);
  }
}

// ─── Bottom Audio Bar (list screen) ───────────────────────────────────────────

class _BottomAudioBar extends StatefulWidget {
  final VoidCallback onOpenAudio;
  const _BottomAudioBar({required this.onOpenAudio});

  @override
  State<_BottomAudioBar> createState() => _BottomAudioBarState();
}

class _BottomAudioBarState extends State<_BottomAudioBar> {
  final _svc = QuranAudioManager.instance;
  bool _lastHasActiveAudio = false;

  @override
  void initState() {
    super.initState();
    _lastHasActiveAudio = _svc.hasActiveAudio;
    _svc.addListener(_onServiceUpdate);
    AppState.instance.addListener(_rebuild);
  }

  @override
  void dispose() {
    _svc.removeListener(_onServiceUpdate);
    AppState.instance.removeListener(_rebuild);
    super.dispose();
  }

  void _onServiceUpdate() {
    if (!mounted) return;
    final active = _svc.hasActiveAudio;
    if (active == _lastHasActiveAudio) return;
    _lastHasActiveAudio = active;
    setState(() {});
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_svc.hasActiveAudio) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: RepaintBoundary(
        child: _AudioMiniBar(onOpenAudio: widget.onOpenAudio),
      ),
    );
  }
}

// ─── Audio Mini Bar ────────────────────────────────────────────────────────────

final _audioMiniBarCollapsed = ValueNotifier<bool>(false);

class _AudioMiniBar extends StatefulWidget {
  final VoidCallback onOpenAudio;
  const _AudioMiniBar({required this.onOpenAudio});

  @override
  State<_AudioMiniBar> createState() => _AudioMiniBarState();
}

class _AudioMiniBarState extends State<_AudioMiniBar> {
  final _svc = QuranAudioManager.instance;

  // Cached values — only call setState when something visible actually changes.
  int? _lastSurahNum;
  bool _lastPlaying = false;
  bool _lastCollapsed = false;

  @override
  void initState() {
    super.initState();
    _svc.addListener(_onServiceUpdate);
    _audioMiniBarCollapsed.addListener(_onCollapsedUpdate);
  }

  @override
  void dispose() {
    _svc.removeListener(_onServiceUpdate);
    _audioMiniBarCollapsed.removeListener(_onCollapsedUpdate);
    super.dispose();
  }

  void _onCollapsedUpdate() {
    if (!mounted) return;
    final collapsed = _audioMiniBarCollapsed.value;
    if (collapsed == _lastCollapsed) return;
    _lastCollapsed = collapsed;
    setState(() {});
  }

  void _onServiceUpdate() {
    if (!mounted) return;
    final pendingDownload = _svc.downloadProgress.keys.isNotEmpty
        ? _svc.downloadProgress.keys.first
        : null;
    final surahNum = _svc.currentSurah ?? pendingDownload;
    final playing = _svc.player.playing;

    if (surahNum == _lastSurahNum && playing == _lastPlaying) return;
    _lastSurahNum = surahNum;
    _lastPlaying = playing;
    setState(() {});
  }

  bool get _collapsed => _lastCollapsed;

  @override
  Widget build(BuildContext context) {
    final pendingDownload = _svc.downloadProgress.keys.isNotEmpty
        ? _svc.downloadProgress.keys.first
        : null;
    final surahNum = _svc.currentSurah ?? pendingDownload;

    if (surahNum == null) {
      return const AnimatedSize(
        duration: Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        alignment: Alignment.bottomCenter,
        child: SizedBox.shrink(),
      );
    }

    final surah = kSurahs[surahNum - 1];
    final lang = AppState.instance.language;
    final title = lang == AppLanguage.english
        ? surah['english'] as String
        : surah['arabic'] as String;
    final arabic = surah['arabic'] as String;
    final playing = _svc.player.playing;

    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: iosStandard,
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.onOpenAudio,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0E1F0E).withValues(alpha: 0.97),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: _collapsed ? 36 : 52,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, anim) => ScaleTransition(
                      scale: CurvedAnimation(parent: anim, curve: iosSpring),
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: KeyedSubtree(
                      key: ValueKey(_collapsed),
                      child: _collapsed
                          ? _buildCollapsed(title, playing)
                          : _buildExpanded(title, arabic, playing),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _ProgressBar(player: _svc.player),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsed(String title, bool playing) {
    return Row(
      children: [
        const _HeadphoneIcon(size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ),
        _PlayPauseButton(
            playing: playing,
            size: 32,
            onTap: () {
              _hapticLight();
              _svc.toggle();
            }),
      ],
    );
  }

  Widget _buildExpanded(String title, String arabic, bool playing) {
    return Row(
      children: [
        const _HeadphoneIcon(size: 40),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(arabic,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _PlayPauseButton(
            playing: playing,
            size: 36,
            onTap: () {
              _hapticLight();
              _svc.toggle();
            }),
      ],
    );
  }
}

// ─── Shared audio widgets ──────────────────────────────────────────────────────

class _HeadphoneIcon extends StatelessWidget {
  final double size;
  const _HeadphoneIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: _kGreen,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.headphones_rounded,
          color: Colors.white, size: size * 0.48),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  final bool playing;
  final double size;
  final VoidCallback onTap;

  const _PlayPauseButton({
    required this.playing,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: Icon(
          playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
          key: ValueKey(playing),
          color: Colors.white,
          size: size * 0.72,
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final AudioPlayer player;
  const _ProgressBar({required this.player});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (_, posSnap) {
        final pos = posSnap.data ?? Duration.zero;
        final dur = player.duration;
        final progress = (dur == null || dur.inMilliseconds <= 0)
            ? 0.0
            : (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0);
        return ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 2,
            backgroundColor: Colors.white.withValues(alpha: 0.06),
            valueColor: const AlwaysStoppedAnimation(_kGreenMid),
          ),
        );
      },
    );
  }
}

// ─── Audio Sheet ───────────────────────────────────────────────────────────────

class _AudioSheet extends StatefulWidget {
  final int currentPage;
  final void Function(int page)? onPageJump;

  const _AudioSheet({required this.currentPage, this.onPageJump});

  @override
  State<_AudioSheet> createState() => _AudioSheetState();
}

class _AudioSheetState extends State<_AudioSheet> {
  late FixedExtentScrollController _wheel;
  late int _selectedIndex;
  late Future<bool> _downloadedFuture;
  final _svc = QuranAudioManager.instance;
  bool _showSleepPicker = false;
  Timer? _uiTimer;
  Duration? _savedPosition; // persisted position for selected surah

  @override
  void initState() {
    super.initState();
    _selectedIndex = _indexForPage(widget.currentPage);
    _wheel = FixedExtentScrollController(initialItem: _selectedIndex);
    _downloadedFuture = _svc.isDownloaded(_selectedIndex + 1);
    _svc.addListener(_onAudioUpdate);
    AppState.instance.addListener(_rebuild);
    _loadSavedPosition();
    // Refresh every second so sleep-timer countdown stays accurate
    _uiTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _svc.sleepTimerMinutes > 0) setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant _AudioSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      final nextIndex = _indexForPage(widget.currentPage);
      if (nextIndex != _selectedIndex) {
        _selectedIndex = nextIndex;
        if (_wheel.hasClients) _wheel.jumpToItem(nextIndex);
        _downloadedFuture = _svc.isDownloaded(nextIndex + 1);
        if (mounted) setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    _wheel.dispose();
    _svc.removeListener(_onAudioUpdate);
    AppState.instance.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _onAudioUpdate() {
    if (!mounted) return;
    // Sync wheel to currently playing surah (handles auto-advance)
    final playing = _svc.currentSurah;
    if (playing != null && playing - 1 != _selectedIndex) {
      final idx = playing - 1;
      _selectedIndex = idx;
      if (_wheel.hasClients) {
        _wheel.animateToItem(idx,
            duration: const Duration(milliseconds: 280), curve: iosStandard);
      }
    }
    _downloadedFuture = _svc.isDownloaded(_surahNum);
    setState(() {});
  }

  int _indexForPage(int page) {
    // Reuse the pre-built lookup table — O(1) instead of O(114).
    final table = _surahIndexForPageTable ??= _buildSurahTable();
    return table[page.clamp(1, 604)];
  }

  void _onWheelChanged(int i) {
    setState(() {
      _selectedIndex = i;
      _savedPosition = null;
      _downloadedFuture = _svc.isDownloaded(i + 1);
    });
    _loadSavedPosition();
  }

  Future<void> _loadSavedPosition() async {
    final saved = await PrefsService.getSavedAudioPosition();
    if (!mounted) return;
    setState(() {
      _savedPosition =
          (saved != null && saved.surah == _surahNum) ? saved.position : null;
    });
  }

  int get _surahNum => _selectedIndex + 1;

  static String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final isDownloading = _svc.downloadProgress.containsKey(_surahNum);
    final dlProgress = _svc.downloadProgress[_surahNum] ?? 0.0;
    final isActive = _svc.currentSurah == _surahNum;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return RepaintBoundary(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 400),
        curve: iosSpring,
        tween: Tween<double>(begin: 0.92, end: 1.0),
        onEnd: () => _hapticMedium(),
        builder: (_, scale, __) => Transform.scale(
          scale: scale,
          child: Container(
            decoration: const BoxDecoration(
              color: _kBgSheet,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  width: 32,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l.reciterLabel,
                        style: const TextStyle(
                          color: _kGreenMid,
                          fontSize: 11,
                          letterSpacing: 0.3,
                        ),
                      ),
                      if (_svc.currentSurah != null &&
                          _svc.currentSurah != _selectedIndex + 1)
                        GestureDetector(
                          onTap: () {
                            _hapticSelect();
                            final idx = _svc.currentSurah! - 1;
                            if (_wheel.hasClients) {
                              _wheel.animateToItem(idx,
                                  duration: const Duration(milliseconds: 280),
                                  curve: iosStandard);
                            }
                            setState(() {
                              _selectedIndex = idx;
                              _savedPosition = null;
                              _downloadedFuture = _svc.isDownloaded(idx + 1);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.my_location_rounded,
                              size: 14,
                              color: _kGreenLight.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Surah wheel picker
                SizedBox(
                  height: isLandscape ? 140 : 176,
                  child: Stack(
                    children: [
                      ListWheelScrollView.useDelegate(
                        controller: _wheel,
                        itemExtent: 44,
                        perspective: 0.0015,
                        diameterRatio: 1.5,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: _onWheelChanged,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 114,
                          builder: (_, i) {
                            final s = kSurahs[i];
                            final sel = i == _selectedIndex;
                            final downloaded = _svc.isKnownDownloaded(i + 1);
                            final isEnglish = l.lang == AppLanguage.english;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 36,
                                    child: Text(
                                      l.toLocalNum(i + 1),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color:
                                            sel ? Colors.white70 : Colors.white24,
                                        fontSize: sel ? 15 : 13,
                                        fontWeight: sel
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (isEnglish)
                                    Expanded(
                                      child: Text(
                                        s['english'] as String,
                                        style: TextStyle(
                                          color:
                                              sel ? Colors.white : Colors.white30,
                                          fontSize: sel ? 15 : 13,
                                          fontWeight: sel
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  else
                                    const Spacer(),
                                  Text(
                                    s['arabic'] as String,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: sel
                                          ? _kGreenLight
                                          : Colors.white.withValues(alpha: 0.18),
                                      fontSize: sel ? 16 : 13,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: downloaded
                                          ? _kGreenMid
                                          : Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Top fade
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 56,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [_kBgSheet, _kBgSheet.withValues(alpha: 0)],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Bottom fade
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 56,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [_kBgSheet, _kBgSheet.withValues(alpha: 0)],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Selection rule lines
                      Center(
                        child: IgnorePointer(
                          child: Container(
                            height: 44,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.07)),
                                bottom: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.07)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Controls
                Padding(
                  padding: EdgeInsets.fromLTRB(20, isLandscape ? 4 : 8, 20, bottomPad + (isLandscape ? 10 : 16)),
                  child: isDownloading
                      ? _buildDownloadProgress(dlProgress, l)
                      : FutureBuilder<bool>(
                          future: _downloadedFuture,
                          builder: (_, snap) {
                            final downloaded = snap.data ?? false;
                            return (downloaded && isActive)
                                ? _buildPlaybackControls()
                                : _buildActionButton(downloaded, l, _savedPosition);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadProgress(double progress, L10n l) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 2,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(_kGreenMid),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${l.download}  ${(progress * 100).toInt()}%',
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildActionButton(bool downloaded, L10n l, Duration? savedPos) {
    final hasResume = downloaded && savedPos != null && savedPos.inSeconds > 0;
    final label = hasResume
        ? l.resumeFrom(_fmt(savedPos))
        : downloaded
            ? l.play
            : l.downloadAndPlay;
    final icon = hasResume
        ? Icons.history_rounded
        : downloaded
            ? Icons.play_arrow_rounded
            : Icons.download_rounded;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: _kGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(icon, size: 20, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          _svc.downloadAndPlay(_surahNum, seekTo: hasResume ? savedPos : null);
        },
      ),
    );
  }

  Widget _buildPlaybackControls() {
    return Column(
      children: [
        StreamBuilder<Duration>(
          stream: _svc.player.positionStream,
          builder: (_, posSnap) {
            final pos = posSnap.data ?? Duration.zero;
            final dur = _svc.player.duration ?? Duration.zero;
            final frac = dur.inMilliseconds > 0
                ? (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0)
                : 0.0;
            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 5),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 10),
                    activeTrackColor: _kGreenLight,
                    inactiveTrackColor: Colors.white12,
                    thumbColor: Colors.white,
                    overlayColor: Colors.white10,
                  ),
                  child: Slider(
                    value: frac,
                    onChanged: (v) => _svc.seek(
                      Duration(milliseconds: (v * dur.inMilliseconds).toInt()),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_fmt(pos),
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 10)),
                    Text(_fmt(dur),
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 10)),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 4),

        // ── Sleep timer pill picker (animated) ──────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child:
              _showSleepPicker ? _buildSleepPicker() : const SizedBox.shrink(),
        ),

        // ── Controls row ────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Playback mode toggle (off → autoPlay → repeatOne)
            _ModeButton(
              mode: _svc.playbackMode,
              onTap: () {
                _hapticSelect();
                _svc.cyclePlaybackMode();
                setState(() {});
              },
            ),

            const SizedBox(width: 4),

            // Seek back 10s
            IconButton(
              icon: const Icon(Icons.replay_10_rounded),
              color: Colors.white54,
              iconSize: 28,
              onPressed: () {
                _hapticLight();
                _svc.seekBackward(const Duration(seconds: 10));
              },
            ),

            const SizedBox(width: 12),

            // Play / Pause
            StreamBuilder<PlayerState>(
              stream: _svc.player.playerStateStream,
              builder: (_, snap) {
                final playing = snap.data?.playing ?? false;
                return GestureDetector(
                  onTap: () {
                    _hapticLight();
                    _svc.toggle();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: _kGreen,
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: Icon(
                        playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        key: ValueKey(playing),
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(width: 12),

            // Seek forward 10s
            IconButton(
              icon: const Icon(Icons.forward_10_rounded),
              color: Colors.white54,
              iconSize: 28,
              onPressed: () {
                _hapticLight();
                _svc.seekForward(const Duration(seconds: 10));
              },
            ),

            const SizedBox(width: 4),

            // Sleep timer moon icon
            _SleepButton(
              active: _svc.sleepTimerMinutes > 0,
              remaining: _svc.sleepTimerRemaining,
              onTap: () {
                _hapticSelect();
                setState(() => _showSleepPicker = !_showSleepPicker);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSleepPicker() {
    const options = [0, 15, 30, 60];
    final l = AppState.instance.l;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: options.map((min) {
          final selected = _svc.sleepTimerMinutes == min;
          return GestureDetector(
            onTap: () {
              _hapticSelect();
              _svc.setSleepTimer(min);
              setState(() {
                if (min == 0) _showSleepPicker = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color:
                    selected ? _kGreen : Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? _kGreenLight.withValues(alpha: 0.6)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                min == 0 ? l.sleepOff : l.sleepMin(min),
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white54,
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Playback mode icon button ─────────────────────────────────────────────────

class _ModeButton extends StatelessWidget {
  final PlaybackMode mode;
  final VoidCallback onTap;
  const _ModeButton({required this.mode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    switch (mode) {
      case PlaybackMode.off:
        icon = Icons.repeat_rounded;
        color = Colors.white24;
      case PlaybackMode.autoPlay:
        icon = Icons.playlist_play_rounded;
        color = _kGreenLight;
      case PlaybackMode.repeatOne:
        icon = Icons.repeat_one_rounded;
        color = _kGreenLight;
    }
    return IconButton(
      icon: Icon(icon, size: 22),
      color: color,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      onPressed: onTap,
    );
  }
}

// ─── Sleep timer icon button ───────────────────────────────────────────────────

class _SleepButton extends StatelessWidget {
  final bool active;
  final Duration? remaining;
  final VoidCallback onTap;
  const _SleepButton(
      {required this.active, required this.remaining, required this.onTap});

  String _label() {
    final r = remaining;
    if (r == null || !active) return '';
    final m = r.inMinutes.remainder(60);
    final s = r.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.bedtime_rounded,
              size: 22,
              color: active ? _kGreenLight : Colors.white24,
            ),
            if (active && remaining != null)
              Positioned(
                bottom: 0,
                child: Text(
                  _label(),
                  style: const TextStyle(
                    color: _kGreenMid,
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Surah Gallery Modal ────────────────────────────────────────────────────────

class _SurahGalleryModal extends StatefulWidget {
  const _SurahGalleryModal();

  @override
  State<_SurahGalleryModal> createState() => _SurahGalleryModalState();
}

class _SurahGalleryModalState extends State<_SurahGalleryModal> {
  // Flat list: index 0 = surah 1 … index 113 = surah 114
  final List<bool> _downloaded = List.filled(114, false);
  // Per-tile notifiers — only created when a tile becomes active
  final Map<int, ValueNotifier<_TileState>> _notifiers = {};

  @override
  void initState() {
    super.initState();
    _loadDownloadStatuses();
    QuranAudioManager.instance.addListener(_onAudioStateChanged);
  }

  @override
  void dispose() {
    QuranAudioManager.instance.removeListener(_onAudioStateChanged);
    for (final n in _notifiers.values) {
      n.dispose();
    }
    super.dispose();
  }

  // Parallel filesystem check — one setState when all 114 are done
  Future<void> _loadDownloadStatuses() async {
    final results = await Future.wait(
      List.generate(114, (i) => QuranAudioManager.instance.isDownloaded(i + 1)),
    );
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < 114; i++) {
        _downloaded[i] = results[i];
      }
    });
  }

  // Fires on every AudioService notify — only touches the one active notifier
  void _onAudioStateChanged() {
    final svc = QuranAudioManager.instance;
    for (final entry in svc.downloadProgress.entries) {
      _notifierFor(entry.key).value = _TileState(
        isDownloading: true,
        isDownloaded: false,
        progress: entry.value,
      );
    }
    for (final surahNum in _notifiers.keys.toList()) {
      if (!svc.downloadProgress.containsKey(surahNum)) {
        final done = svc.isKnownDownloaded(surahNum);
        _notifierFor(surahNum).value = _TileState(
          isDownloading: false,
          isDownloaded: done,
          progress: null,
        );
        if (done && mounted) setState(() => _downloaded[surahNum - 1] = true);
      }
    }
  }

  ValueNotifier<_TileState> _notifierFor(int surahNum) =>
      _notifiers.putIfAbsent(
        surahNum,
        () => ValueNotifier(_TileState(
          isDownloading: false,
          isDownloaded: _downloaded[surahNum - 1],
          progress: null,
        )),
      );

  Future<void> _downloadSurah(int surahNum) async {
    _notifierFor(surahNum).value = const _TileState(
      isDownloading: true,
      isDownloaded: false,
      progress: 0.0,
    );
    try {
      await QuranAudioManager.instance.downloadOnly(surahNum);
      final ok = QuranAudioManager.instance.isKnownDownloaded(surahNum);
      if (mounted) setState(() => _downloaded[surahNum - 1] = ok);
      _notifierFor(surahNum).value = _TileState(
        isDownloading: false,
        isDownloaded: ok,
        progress: null,
      );
    } catch (_) {
      _notifierFor(surahNum).value = const _TileState(
        isDownloading: false,
        isDownloaded: false,
        progress: null,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppState.instance.l.downloadError(surahNum))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppState.instance.l;

    return Container(
      color: Colors.transparent,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: _kBgDeep,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l.manageSurahs,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              Expanded(
                child: GridView.builder(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: 114,
                  itemBuilder: (context, index) {
                    final surahNum = index + 1;
                    final surah = kSurahs[index];
                    final surahName = l.lang == AppLanguage.arabic ||
                            l.lang == AppLanguage.urdu
                        ? surah['arabic'] as String
                        : surah['english'] as String;

                    return RepaintBoundary(
                      child: ValueListenableBuilder<_TileState>(
                        valueListenable: _notifierFor(surahNum),
                        builder: (_, state, __) => _SurahTile(
                          surahNum: surahNum,
                          surahName: surahName,
                          isDownloaded:
                              state.isDownloading ? false : _downloaded[index],
                          isDownloading: state.isDownloading,
                          dlProgress: state.progress,
                          onDownload: () => _downloadSurah(surahNum),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Update Checker ────────────────────────────────────────────────────────────

enum _CheckState { idle, checking, upToDate, updateAvailable, downloading, readyToInstall, done, error }

class _UpdateChecker extends StatefulWidget {
  const _UpdateChecker();

  @override
  State<_UpdateChecker> createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends State<_UpdateChecker> {
  static const _currentVersion = kAppVersion;
  static const _apiUrl =
      'https://api.github.com/repos/deccandewan/khalafquran/releases/latest';
  static final _dio = Dio();

  // ── Persisted across navigation (static so dispose/rebuild doesn't wipe them) ──
  static _CheckState _persistedState = _CheckState.idle;
  static String? _persistedLatestVersion;
  static String? _persistedApkUrl;
  static String? _persistedChangelog;
  static String? _persistedFilePath;
  static double? _persistedDlProgress;
  static String? _persistedErrorMsg;
  // Keep the cancel token alive across navigation so the download survives.
  static CancelToken? _activeCancelToken;

  _CheckState _state = _CheckState.idle;
  String? _latestVersion;
  String? _apkUrl;
  String? _changelog;
  String? _filePath;
  double? _dlProgress;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    // Restore whatever state we had before navigating away.
    _state         = _persistedState;
    _latestVersion = _persistedLatestVersion;
    _apkUrl        = _persistedApkUrl;
    _changelog     = _persistedChangelog;
    _filePath      = _persistedFilePath;
    _dlProgress    = _persistedDlProgress;
    _errorMsg      = _persistedErrorMsg;

    // If a download was running when we left, re-attach live progress updates
    // so the progress bar animates correctly after coming back.
    if (_state == _CheckState.downloading && _activeCancelToken != null && !_activeCancelToken!.isCancelled) {
      _reattachDownloadProgress();
    } else if (_state == _CheckState.downloading) {
      // Token is gone / cancelled but state says downloading — fall back to
      // the updateAvailable card so the user can retry.
      _state = _CheckState.updateAvailable;
      _persistedState = _state;
    }
  }

  @override
  void dispose() {
    // Do NOT cancel the token here — the download should keep running in the
    // background while the user navigates away from Settings.
    super.dispose();
  }

  /// Re-attaches a progress-polling loop for an already-running download so
  /// the progress bar stays live after the widget is rebuilt.
  void _reattachDownloadProgress() {
    // Poll the static progress value (updated by the still-running download
    // future) every ~200 ms and push it into our local state.
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) return false;
      if (_persistedState != _CheckState.downloading) {
        // Download finished or errored while we were away — sync final state.
        if (mounted) {
          setState(() {
            _state      = _persistedState;
            _dlProgress = _persistedDlProgress;
            _filePath   = _persistedFilePath;
            _errorMsg   = _persistedErrorMsg;
          });
        }
        return false;
      }
      if (mounted) setState(() => _dlProgress = _persistedDlProgress);
      return true;
    });
  }

  /// setState + mirror to statics so state survives navigation.
  void _set(VoidCallback fn) {
    setState(fn);
    _persistedState         = _state;
    _persistedLatestVersion = _latestVersion;
    _persistedApkUrl        = _apkUrl;
    _persistedChangelog     = _changelog;
    _persistedFilePath      = _filePath;
    _persistedDlProgress    = _dlProgress;
    _persistedErrorMsg      = _errorMsg;
  }

  bool _isNewer(String latest) {
    final a = latest.replaceFirst('v', '').split('.').map(int.tryParse).toList();
    final b = _currentVersion.split('.').map(int.tryParse).toList();
    for (int i = 0; i < 3; i++) {
      final av = (i < a.length ? a[i] : 0) ?? 0;
      final bv = (i < b.length ? b[i] : 0) ?? 0;
      if (av > bv) return true;
      if (av < bv) return false;
    }
    return false;
  }

  Future<void> _checkForUpdate() async {
    _hapticLight();
    _set(() { _state = _CheckState.checking; _errorMsg = null; });
    try {
      final resp = await _dio.get<Map<String, dynamic>>(
        _apiUrl,
        options: Options(headers: {'Accept': 'application/vnd.github+json'}),
      );
      final data = resp.data!;
      final tag = (data['tag_name'] as String? ?? '').replaceFirst('v', '');
      final body = data['body'] as String? ?? '';
      final assets = (data['assets'] as List?) ?? [];
      final apkAsset = assets.firstWhere(
        (a) => (a['name'] as String).endsWith('.apk'),
        orElse: () => null,
      );
      if (!mounted) return;
      if (!_isNewer(tag)) {
        _set(() { _state = _CheckState.upToDate; _latestVersion = tag; });
        return;
      }
      _set(() {
        _state = _CheckState.updateAvailable;
        _latestVersion = tag;
        _changelog = body.trim().isEmpty ? null : body.trim();
        _apkUrl = apkAsset != null ? apkAsset['browser_download_url'] as String : null;
      });
    } catch (e) {
      if (!mounted) return;
      _set(() { _state = _CheckState.error; _errorMsg = AppState.instance.l.updateNetworkError; });
    }
  }

  Future<void> _downloadAndInstall() async {
    if (_apkUrl == null) return;
    _hapticMedium();
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/khalafquran_update.apk';
    _activeCancelToken = CancelToken();
    _set(() { _state = _CheckState.downloading; _dlProgress = 0; });
    try {
      await _dio.download(
        _apkUrl!, path,
        cancelToken: _activeCancelToken,
        onReceiveProgress: (recv, total) {
          if (total > 0) {
            // Always update the static so re-attached widgets can read it.
            _persistedDlProgress = recv / total;
            if (mounted) _set(() => _dlProgress = recv / total);
          }
        },
      );
      // Download complete — store path and show Install Now button.
      _activeCancelToken = null;
      if (mounted) {
        _set(() { _state = _CheckState.readyToInstall; _filePath = path; });
      } else {
        // Widget was away; update statics directly so next restore is correct.
        _persistedState    = _CheckState.readyToInstall;
        _persistedFilePath = path;
      }
    } on DioException catch (e) {
      _activeCancelToken = null;
      if (CancelToken.isCancel(e)) {
        if (mounted) {
          _set(() => _state = _CheckState.updateAvailable);
        } else {
          _persistedState = _CheckState.updateAvailable;
        }
      } else {
        if (mounted) {
          _set(() { _state = _CheckState.error; _errorMsg = AppState.instance.l.downloadFailed; });
        } else {
          _persistedState    = _CheckState.error;
          _persistedErrorMsg = AppState.instance.l.downloadFailed;
        }
      }
    }
  }

  Future<void> _triggerInstall() async {
    if (_filePath == null) return;
    _hapticMedium();

    // Stage 1: try the dedicated native install channel.
    try {
      const platform = MethodChannel('com.abuhashim.khalafquran/install');
      await platform.invokeMethod('installApk', {'path': _filePath});
      _set(() => _state = _CheckState.done);
      return;
    } catch (_) {
      // Channel not available or threw — fall through to Stage 2.
    }

    // Stage 2: open the APK file via the OS "open with" mechanism.
    // This triggers the standard Android package-installer UI without any
    // extra package, because we already have dart:io and a real file path.
    // Requires REQUEST_INSTALL_PACKAGES in AndroidManifest + a FileProvider
    // <provider> entry pointing to getExternalCacheDir (same dir used for
    // the download).  If those are present the installer sheet will appear.
    try {
      // Use the intent channel that Flutter exposes for ACTION_VIEW.
      // We encode the file:// URI and let the OS pick the right handler.
      const intentChannel = MethodChannel('com.abuhashim.khalafquran/intent');
      await intentChannel.invokeMethod('openFile', {
        'path': _filePath,
        'mimeType': 'application/vnd.android.package-archive',
      });
      _set(() => _state = _CheckState.done);
    } catch (_) {
      if (!mounted) return;
      _set(() {
        _state = _CheckState.error;
        _errorMsg = AppState.instance.l.autoInstallUnavailable(_filePath ?? '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      _CheckState.idle             => _buildIdle(),
      _CheckState.checking         => _buildChecking(),
      _CheckState.upToDate         => _buildUpToDate(),
      _CheckState.updateAvailable  => _buildUpdateAvailable(),
      _CheckState.downloading      => _buildDownloading(),
      _CheckState.readyToInstall   => _buildReadyToInstall(),
      _CheckState.done             => _buildDone(),
      _CheckState.error            => _buildError(),
    };
  }

  Widget _buildIdle() {
    final l = AppState.instance.l;
    return Center(
      child: TextButton.icon(
        onPressed: _checkForUpdate,
        icon: Icon(Icons.system_update_alt_rounded, size: 15, color: _kGreenMid.withValues(alpha: 0.7)),
        label: Text(l.checkForUpdates, style: TextStyle(fontSize: 12, color: _kGreenMid.withValues(alpha: 0.7), fontWeight: FontWeight.w500)),
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    );
  }

  Widget _buildChecking() {
    final l = AppState.instance.l;
    return Center(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 1.5, valueColor: AlwaysStoppedAnimation(_kGreenMid.withValues(alpha: 0.6)))),
        const SizedBox(width: 8),
        Text(l.checking, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.35))),
      ]),
    );
  }

  Widget _buildUpToDate() {
    final l = AppState.instance.l;
    return Center(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.check_circle_outline_rounded, size: 14, color: _kGreenMid.withValues(alpha: 0.6)),
        const SizedBox(width: 6),
        Text(l.upToDate('v${_latestVersion ?? _currentVersion}'), style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.35))),
      ]),
    );
  }

  Widget _buildUpdateAvailable() {
    final l = AppState.instance.l;
    return Container(
    decoration: BoxDecoration(
      color: _kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kGreenMid.withValues(alpha: 0.22)),
    ),
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: _kGreen.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.system_update_rounded, size: 16, color: _kGreenLight),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.updateAvailableTitle('v${_latestVersion ?? ''}'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
          Text(l.currentlyOn('v$_currentVersion'), style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.35))),
        ])),
      ]),
      if (_changelog != null) ...[
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: _kBgDeep, borderRadius: BorderRadius.circular(8)),
          child: Text(
            _changelog!.length > 300 ? '${_changelog!.substring(0, 300)}…' : _changelog!,
            style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5), height: 1.5),
          ),
        ),
      ],
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: FilledButton.icon(
          onPressed: _apkUrl != null ? _downloadAndInstall : null,
          icon: const Icon(Icons.download_rounded, size: 15),
          label: Text(l.downloadAndInstall, style: const TextStyle(fontSize: 12)),
          style: FilledButton.styleFrom(
            backgroundColor: _kGreen, foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        )),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => setState(() => _state = _CheckState.idle),
          child: Text(l.later, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.35))),
        ),
      ]),
    ]),
  );
  }

  Widget _buildDownloading() {
    final l = AppState.instance.l;
    return Container(
    decoration: BoxDecoration(color: _kBgCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: _kGreenMid.withValues(alpha: 0.22))),
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        SizedBox(width: 16, height: 16, child: CircularProgressIndicator(
          value: _dlProgress, strokeWidth: 2,
          valueColor: const AlwaysStoppedAnimation(_kGreenMid),
          backgroundColor: _kGreenMid.withValues(alpha: 0.15),
        )),
        const SizedBox(width: 10),
        Text(
          _dlProgress != null
              ? l.downloadingPercent((_dlProgress! * 100).toInt())
              : l.downloadingLabel,
          style: const TextStyle(fontSize: 13, color: Colors.white),
        ),
        const Spacer(),
        TextButton(
          onPressed: () { _activeCancelToken?.cancel(); _set(() => _state = _CheckState.updateAvailable); },
          child: Text(l.cancel, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.35))),
        ),
      ]),
      const SizedBox(height: 10),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: _dlProgress, minHeight: 4, backgroundColor: _kGreenMid.withValues(alpha: 0.12), valueColor: const AlwaysStoppedAnimation(_kGreenMid)),
      ),
    ]),
  );
  }

  Widget _buildReadyToInstall() {
    final l = AppState.instance.l;
    return Container(
    decoration: BoxDecoration(color: _kBgCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: _kGreenMid.withValues(alpha: 0.22))),
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: _kGreen.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.download_done_rounded, size: 16, color: _kGreenLight),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l.readyToInstall('v${_latestVersion ?? ''}'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
          Text(l.downloadComplete, style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.35))),
        ])),
      ]),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: FilledButton.icon(
        onPressed: _triggerInstall,
        icon: const Icon(Icons.install_mobile_rounded, size: 15),
        label: Text(l.installNow, style: const TextStyle(fontSize: 12)),
        style: FilledButton.styleFrom(
          backgroundColor: _kGreen, foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      )),
    ]),
  );
  }

  Widget _buildDone() {
    final l = AppState.instance.l;
    return Center(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.check_circle_rounded, size: 14, color: _kGreenLight.withValues(alpha: 0.8)),
        const SizedBox(width: 6),
        Text(l.installStarted, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.35))),
      ]),
    );
  }

  Widget _buildError() {
    final l = AppState.instance.l;
    return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.error_outline_rounded, size: 14, color: Colors.redAccent.withValues(alpha: 0.7)),
        const SizedBox(width: 6),
        Flexible(child: Text(
          _errorMsg?.split('\n').first ?? l.somethingWentWrong,
          style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.35)),
        )),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: _checkForUpdate,
          child: Text(l.retry, style: TextStyle(fontSize: 12, color: _kGreenMid.withValues(alpha: 0.7), fontWeight: FontWeight.w500)),
        ),
      ]),
      // If the error message has a path (line 2), show it as selectable text.
      if (_errorMsg != null && _errorMsg!.contains('\n')) ...[
        const SizedBox(height: 6),
        SelectableText(
          _errorMsg!.split('\n').skip(1).join('\n'),
          style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.25), fontFamily: 'monospace'),
        ),
      ],
    ],
  );
  }
}

// ─── Download Tile ─────────────────────────────────────────────────────────────

class _TileState {
  final bool isDownloading;
  final bool isDownloaded;
  final double? progress;
  const _TileState({
    required this.isDownloading,
    required this.isDownloaded,
    required this.progress,
  });
}

class _SurahTile extends StatelessWidget {
  final int surahNum;
  final String surahName;
  final bool isDownloaded;
  final bool isDownloading;
  final double? dlProgress;
  final VoidCallback onDownload;

  const _SurahTile({
    required this.surahNum,
    required this.surahName,
    required this.isDownloaded,
    required this.isDownloading,
    required this.onDownload,
    this.dlProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kBgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDownloaded
              ? _kGreenLight.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.08),
        ),
        gradient: isDownloaded
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _kGreen.withValues(alpha: 0.12),
                  _kGreenLight.withValues(alpha: 0.04),
                ],
              )
            : null,
      ),
      child: Stack(
        children: [
          // ── Name + cloud icon ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isDownloading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(_kGreenLight),
                      strokeWidth: 2,
                    ),
                  )
                else
                  Icon(
                    isDownloaded
                        ? Icons.cloud_done_rounded
                        : Icons.cloud_off_rounded,
                    color: isDownloaded ? _kGreenLight : Colors.white24,
                    size: 20,
                  ),
                const SizedBox(height: 6),
                Text(
                  surahName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDownloaded ? Colors.white : Colors.white70,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // ── Progress bar (visible while downloading) ─────────────────
          if (isDownloading)
            Positioned(
              left: 8,
              right: 36,
              bottom: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: dlProgress,
                  minHeight: 3,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: const AlwaysStoppedAnimation(_kGreenMid),
                ),
              ),
            ),

          // ── Download / Cancel button — bottom-right ──────────────────
          Positioned(
            right: 4,
            bottom: 4,
            child: SizedBox(
              width: 28,
              height: 28,
              child: Material(
                color: isDownloading
                    ? Colors.redAccent.withValues(alpha: 0.15)
                    : isDownloaded
                        ? _kGreen.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: isDownloading
                      ? () {
                          _hapticLight();
                          QuranAudioManager.instance.cancelSingleDownload();
                        }
                      : isDownloaded
                          ? null
                          : () {
                              _hapticLight();
                              onDownload();
                            },
                  child: Icon(
                    isDownloading
                        ? Icons.close_rounded
                        : isDownloaded
                            ? Icons.check_rounded
                            : Icons.download_rounded,
                    size: 16,
                    color: isDownloading
                        ? Colors.redAccent
                        : isDownloaded
                            ? _kGreenLight
                            : Colors.white38,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
