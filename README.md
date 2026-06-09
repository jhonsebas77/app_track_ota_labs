# app_track_ota_labs

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

To Update splash image

`dart run flutter_native_splash:create`

## Deploy

El despliegue a GitHub Pages es **automático** via GitHub Actions en cada push a `main`.

También se puede disparar manualmente desde la pestaña **Actions** del repositorio usando "Run workflow".

### Deploy manual (fallback)

```bash
flutter build web --base-href="/app_track_ota_labs/"
npx gh-pages -d build/web
```

URL: https://jhonsebas77.github.io/app_track_ota_labs/