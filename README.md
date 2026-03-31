# startups-android-marketplace

F-Droid-compatible repository **and** cross-platform marketplace for Android apps built by startups incubated or accelerated through [DojoCodingLabs](https://github.com/DojoCodingLabs) hackathons and the [DojoOS Launchpad](https://dojocoding.io).

## Monorepo Structure

```
apps/
  web/          React 19 + Vite + Tailwind (marketplace web UI)
  mobile/       Flutter (Android marketplace app, dev/prod flavors)
packages/
  tokens/       Style Dictionary pipeline (tokens.json -> CSS + Dart)
infra/
  config.yml    fdroidserver configuration
  metadata/     F-Droid app metadata YAMLs
docs/           Architecture docs, submission guide, advocacy
go-to-market/   Ship plan and checkpoints
```

## For Users

Add the F-Droid repository to your client (Droid-ify, Neo Store, or F-Droid):

```
https://marketplace.dojocoding.io/fdroid/repo
```

## For Startup Developers

### Who Can Publish

Startups that have been incubated or accelerated through:
- DojoCodingLabs hackathons
- The DojoOS Launchpad program

Using the [flutter-go-to-market-toolkit](https://github.com/lapc506/flutter-go-to-market-toolkit) is recommended but not required.

### How to Get Your App Listed

You publish your APK on **your own repository**. We fetch it from there.

1. **Publish a signed release APK** on your GitHub/GitLab/Codeberg repo (use GitHub Releases, GitLab Releases, etc.)

2. **Open an issue** in this repo using the [App Submission template](https://github.com/DojoCodingLabs/startups-android-marketplace/issues/new?template=app-submission.yml) with:
   - Your repo URL
   - Package name
   - Which DojoCodingLabs program you participated in
   - A brief app description

3. **A maintainer reviews** your request, verifies your DojoCodingLabs connection, and adds your app's metadata to our index

4. **Our pipeline fetches your APK** from your release page, scans it, and adds it to the marketplace

5. **Users see your app** in Droid-ify / Neo Store when they add our repo

### Updating Your App

Just publish a new release on your own repo. Our pipeline periodically checks for new versions and updates the marketplace automatically.

### What You DON'T Need To Do

- Fork this repo
- Upload APKs here
- Learn fdroidserver
- Configure metadata YAML

We handle all of that. You just publish releases on your own repo.

## Development

### Web app

```bash
cd packages/tokens && npm install && npm run build
cd apps/web && npm install && npm run dev
```

### Mobile app

```bash
cd apps/mobile && flutter pub get
flutter run --target lib/main_dev.dart    # dev flavor
flutter run --target lib/main_prod.dart   # prod flavor
```

### Design tokens

```bash
cd packages/tokens && npm run build
```

Outputs CSS variables (for web) and a Dart class (for mobile). See [packages/tokens/README.md](packages/tokens/README.md) for details.

## How It Works

```
Startup publishes APK on their own GitHub Releases
  -> Startup opens issue requesting inclusion
  -> Maintainer adds metadata pointing to startup's repo
  -> Pipeline fetches APK from startup's release page
  -> APK scanned (signature, trackers)
  -> fdroidserver generates signed index
  -> Vercel deploys to CDN
  -> Users see the app in their F-Droid client
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the complete technical design.

## Keep Android Open

Starting September 2026, Google's Android Developer Verification Program may restrict app installation from alternative sources on stock Android. See [docs/KEEP_ANDROID_OPEN.md](docs/KEEP_ANDROID_OPEN.md) for our impact assessment and resilience strategy.

## Technology

| Component | Tool |
|-----------|------|
| Web frontend | React 19 + Vite + Tailwind CSS |
| Mobile app | Flutter (Android) |
| Design tokens | Style Dictionary |
| Repo generation | fdroidserver |
| APK sourcing | Fetched from developer's own releases |
| Hosting | Vercel (CDN + security headers) |
| CI/CD | GitHub Actions |
| APK validation | apksigner, aapt2 |
| Tracker scanning | exodus-standalone |
| Client apps | Droid-ify, Neo Store |

## License

[Business Source License 1.1](./LICENSE)

---

Built by [DojoCodingLabs](https://github.com/DojoCodingLabs)
