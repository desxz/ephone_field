# ephone_field example

Demo app for [`ephone_field`](https://pub.dev/packages/ephone_field).

## Run

```bash
cd example
flutter pub get
flutter run
```

Use an Android emulator/device or an iOS simulator. The first native build needs
CMake (and network once for FetchContent). See the package
[ARCHITECTURE](../doc/ARCHITECTURE.md) doc for prebuilds.

## What it shows

- `EPhoneField` inside a `Form` (email/phone auto-detect)
- Country picker via `CountryPickerConfig`
- Validate / save using package default validators and E.164 mapping for phone
