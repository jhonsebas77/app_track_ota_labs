# App Track — OTA Labs

A Flutter application to track and manage your own developed apps across platforms. It provides a centralized dashboard to monitor application status, versions, and metadata, with a custom dark **Blueprint** design system.

**Live demo:** https://jhonsebas77.github.io/app_track_ota_labs/

---

## Features

- **Authentication** — Secure login/logout via Supabase Auth
- **Dashboard** — Overview of total registered applications with live stats
- **Applications list** — Full list view with detailed cards per app
- **Register new app** — Form to add applications with name, bundle ID, description, icon upload, and target platform selector (iOS / Android / Web)
- **Settings** — System config, session management, build info, and version display
- **Theme** — Dark/light mode toggle backed by Riverpod state
- **Animated UI** — Entrance animations on every screen using `flutter_animate`
- **Custom navigation** — Slide-bottom and fade page transitions
- **Native splash screen** — Branded splash on launch for iOS and Android
- **Portrait lock** — Enforced portrait orientation on mobile

---

## Tech Stack

| Layer | Library |
|---|---|
| Framework | Flutter |
| Backend / Auth | [Supabase](https://supabase.com) |
| State — app data | [Provider](https://pub.dev/packages/provider) |
| State — theme | [Riverpod](https://riverpod.dev) |
| Animations | [flutter_animate](https://pub.dev/packages/flutter_animate) |
| Font | JetBrains Mono via [google_fonts](https://pub.dev/packages/google_fonts) |
| Splash screen | [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) |
| App info | [package_info_plus](https://pub.dev/packages/package_info_plus) |

---

## Project Structure

```
lib/
├── main.dart                   # Entry point, Supabase init, theme wiring
├── core/
│   ├── models/
│   │   └── app_model.dart      # AppModel data class with fromMap factory
│   ├── providers/
│   │   ├── app_provider.dart   # ChangeNotifier: auth, app CRUD, Supabase calls
│   │   ├── theme.dart          # Riverpod Notifier for ThemeMode
│   │   └── database.dart       # Supabase query helpers (fetchAllApps)
│   └── enums/
│       └── enums.dart          # Shared enums
└── ui/
    ├── theme/
    │   ├── blueprint_theme.dart # Light & dark MaterialTheme definitions
    │   └── blueprint_colors.dart # BpColors palette constants
    ├── views/
    │   ├── login_screen.dart   # Login form with animated layout
    │   ├── home.dart           # DashboardScreen: tab scaffold (Dashboard + Settings)
    │   ├── dashboard_view.dart # Stats card + app list from Supabase
    │   ├── my_applications_screen.dart # Full app list from local provider
    │   ├── add_application_screen.dart # New app registration form
    │   └── settings_view.dart  # Config, session, build info
    └── widgets/
        ├── dashboard_card.dart  # Compact card for dashboard list
        ├── detailed_card.dart   # Expanded card for full list
        ├── stats_card.dart      # KPI counter widget
        ├── snackbar.dart        # showSuccessSnackBar / showErrorSnackBar helpers
        ├── version.dart         # VersionWidget using package_info_plus
        └── new_login/
            ├── corner_brackets.dart    # Decorative corner bracket overlay
            ├── diagnostic_strip.dart   # Animated status bar strip
            ├── grid_background.dart    # Dot-grid background painter
            ├── scanline_overlay.dart   # CRT scanline effect
            └── schematic_ring.dart     # Technical ring decorator for logo
```

---

## Design System — Blueprint Dark

The entire UI is built on the `Blueprint` theme — a monochromatic dark aesthetic inspired by technical schematics.

- **Font:** JetBrains Mono (monospace) across all labels, inputs, and buttons
- **Colors:** `BpColors` — a static palette with `background`, `primaryContainer`, `surfaceContainerLow`, `outlineVariant`, `textPrimary`, `textDim`, `success`, `error`
- **Motifs:** dot-grid backgrounds, CRT scanline overlays, corner bracket decorations, schematic ring frames
- **Typography:** All UI strings use `SCREAMING_SNAKE_CASE` labels for a terminal/system aesthetic

---

## Data Model

```dart
AppModel {
  String id
  String name
  String description
  String bundleId
  String? icon         // URL or empty string
  Color color
  List<String> platform  // ['iOS', 'Android', 'Web']
  String status        // 'Live' | 'In Review' | 'Draft'
  String developPlatform
  String version
}
```

Apps are fetched from Supabase (`fetchAllApps`) and also managed locally via `AppProvider`.

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.0`
- A Supabase project (URL + anon key configured in `main.dart`)

### Install & run

```bash
flutter pub get
flutter run
```

### Regenerate splash screen

```bash
dart run flutter_native_splash:create
```

---

## Platforms

| Platform | Status |
|---|---|
| Android | Supported |
| iOS | Supported |
| Web | Supported + deployed |
| macOS | Available |
| Linux | Available |
| Windows | Available |

---

## Deploy

### Automatic (GitHub Actions)

Every push to `main` triggers a GitHub Actions workflow that:

1. Sets up Flutter on Ubuntu
2. Builds the web app with `--base-href="/app_track_ota_labs/"`
3. Deploys `build/web` to the `gh-pages` branch via `peaceiris/actions-gh-pages`

You can also trigger it manually from the **Actions** tab → **Run workflow**.

### Manual fallback

```bash
flutter build web --base-href="/app_track_ota_labs/"
npx gh-pages -d build/web
```

**URL:** https://jhonsebas77.github.io/app_track_ota_labs/

---

## Code Quality

The project uses a strict `analysis_options.yaml` with:

- `flutter_lints` rule set
- Strict type inference, casts, and raw-type checks
- 80-character line limit
- `dart_code_metrics` for anti-patterns (long parameter lists, redundant async, etc.)
- Custom severity overrides (e.g. `use_build_context_synchronously` → info)

Run the analyzer:

```bash
flutter analyze
```
