# startups-android-marketplace

F-Droid-compatible repository for Android apps built by startups incubated or accelerated through [DojoCodingLabs](https://github.com/DojoCodingLabs) hackathons and the [DojoOS Launchpad](https://dojocoding.io).

## For Users

Add this repository to your F-Droid client (Droid-ify, Neo Store, or F-Droid):

```
https://marketplace.dojocoding.io/fdroid/repo
```

Or scan the QR code: *(coming soon)*

## For Startup Developers

### Who Can Publish

Startups that have been incubated or accelerated through:
- DojoCodingLabs hackathons
- The DojoOS Launchpad program

Using the [flutter-go-to-market-toolkit](https://github.com/lapc506/flutter-go-to-market-toolkit) is recommended but not required.

### How to Submit Your App

1. **Build a signed APK** of your release
   ```bash
   flutter build apk --release
   ```

2. **Fork this repository**

3. **Add your APK** to `apks/<your.package.name>/`
   ```
   apks/com.yourstartup.app/com.yourstartup.app_1.apk
   ```

4. **Create metadata** at `metadata/<your.package.name>.yml`
   ```yaml
   Categories:
     - Utilities
   License: MIT
   AuthorName: Your Startup
   AuthorEmail: dev@yourstartup.com
   SourceCode: https://github.com/yourstartup/app
   IssueTracker: https://github.com/yourstartup/app/issues

   AutoName: Your App Name
   Description: |
     Brief description of what your app does.

   X-DojoLaunchpad: true
   X-DojoHackathon: "Hackathon 2026-Q1"

   CurrentVersion: 1.0.0
   CurrentVersionCode: 1
   ```

5. **Open a Pull Request** using the submission template

6. **CI validates automatically** — signature, metadata, tracker scan

7. **A maintainer reviews and merges** — your app is live within minutes

### Updating Your App

Same process: add the new APK, update the version in metadata YAML, open a PR.

### Submission Requirements

| Requirement | Details |
|-------------|---------|
| APK signed | Must be signed with your release keystore |
| Metadata YAML | Required fields: Categories, License, AuthorName, AutoName, Description |
| Source code | Recommended to be open source (link in SourceCode field) |
| Same signing key | Updates must use the same key as the original submission |

## Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the complete technical design: hosting, CI/CD pipeline, security model, and future roadmap.

## Keep Android Open

Starting September 2026, Google's Android Developer Verification Program may restrict app installation from alternative sources on stock Android. See [docs/KEEP_ANDROID_OPEN.md](docs/KEEP_ANDROID_OPEN.md) for our impact assessment and resilience strategy.

**TL;DR:** This marketplace works today on any Android device. After September 2026, it will continue working on custom ROMs (GrapheneOS, CalyxOS, LineageOS) without any restrictions.

## How It Works

```
Developer submits APK + metadata via PR
  → CI validates (signature, metadata, trackers)
  → Maintainer merges
  → fdroidserver regenerates signed index
  → Vercel deploys to CDN
  → Users see the new app in their F-Droid client
```

## Technology

| Component | Tool |
|-----------|------|
| Repo generation | fdroidserver |
| Hosting | Vercel (CDN + security headers) |
| CI/CD | GitHub Actions |
| APK validation | apksigner, aapt2 |
| Tracker scanning | exodus-standalone |
| Client apps | Droid-ify, Neo Store |

## License

[Business Source License 1.1](./LICENSE)

---

Built by [DojoCodingLabs](https://github.com/DojoCodingLabs)
