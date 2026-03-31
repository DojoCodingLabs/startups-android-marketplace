# startups-android-marketplace

F-Droid-compatible repository for Android apps built by startups incubated or accelerated through [DojoCodingLabs](https://github.com/DojoCodingLabs) hackathons and the [DojoOS Launchpad](https://dojocoding.io).

## For Users

Add this repository to your F-Droid client (Droid-ify, Neo Store, or F-Droid):

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

## How It Works

```
Startup publishes APK on their own GitHub Releases
  → Startup opens issue requesting inclusion
  → Maintainer adds metadata pointing to startup's repo
  → Pipeline fetches APK from startup's release page
  → APK scanned (signature, trackers)
  → fdroidserver generates signed index
  → Vercel deploys to CDN
  → Users see the app in their F-Droid client
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the complete technical design.

## Keep Android Open

Starting September 2026, Google's Android Developer Verification Program may restrict app installation from alternative sources on stock Android. See [docs/KEEP_ANDROID_OPEN.md](docs/KEEP_ANDROID_OPEN.md) for our impact assessment and resilience strategy.

## Technology

| Component | Tool |
|-----------|------|
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
