# Architecture: DojoCodingLabs Startups Android Marketplace

## Vision

An F-Droid-compatible repository where startups incubated or accelerated through DojoCodingLabs hackathons and the DojoOS Launchpad can distribute their Android apps independently of Google Play.

## Why This Exists

### Immediate Value
- Zero-cost distribution for startup apps
- No Google Play Console account needed ($25 + identity verification)
- No review queue — maintainer-approved, published in minutes
- Community-driven quality through transparent scanning

### Strategic Value (September 2026)
Google's Android Developer Verification Program will require all developers to register centrally with Google, submit government ID, and upload signing keys. Apps from unregistered developers will be blocked. This marketplace provides an alternative distribution channel that:
- Works today on any Android device via F-Droid clients
- Continues working on custom ROMs (GrapheneOS, CalyxOS, LineageOS) regardless of Google's restrictions
- Positions DojoCodingLabs as infrastructure provider, not just education

## How F-Droid Repositories Work

An F-Droid repo is a **signed static directory** served over HTTPS. It contains:

```
repo/
├── index-v2.json          # Signed index with all app metadata
├── index-v2.json.asc      # GPG signature of the index
├── com.app.one_1.apk      # App APKs
├── com.app.two_3.apk
└── icons-640/             # App icons at various densities
    ├── com.app.one.1.png
    └── com.app.two.3.png
```

Any F-Droid client (Droid-ify, Neo Store, F-Droid Basic) can add a repo URL and browse/install apps from it. The client verifies the index signature against the repo's public key.

**`fdroidserver`** is the official Python tool that generates and maintains this structure. It:
- Reads APKs and extracts metadata (package name, version, permissions, icons)
- Generates the signed index
- Manages app versions and updates

## Architecture

```
Developer submits APK via Pull Request
         │
         ▼
┌─────────────────────────┐
│  validate-submission.yml │  ← GitHub Actions
│  - apksigner verify      │
│  - aapt2 dump metadata   │
│  - exodus-standalone scan │
│  - YAML metadata lint     │
└──────────┬──────────────┘
           │ PR passes checks
           ▼
   Maintainer reviews + merges
           │
           ▼
┌─────────────────────────┐
│    deploy-repo.yml       │  ← GitHub Actions
│  - fdroidserver update   │
│  - Generate signed index │
│  - Deploy to Vercel      │
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│       Vercel CDN         │
│  marketplace.dojocoding.io │
│  Static files served     │
│  with security headers   │
└──────────┬──────────────┘
           │
           ▼
   User adds repo URL in
   Droid-ify / Neo Store
```

## Hosting: Vercel

Following the same deployment pattern as DojoOS:

- **Vercel** serves the static `repo/` directory globally via CDN
- **Security headers** (HSTS, X-Content-Type-Options, X-Frame-Options)
- **APK caching** — immutable cache for versioned APK files
- **Custom domain** — `marketplace.dojocoding.io` or `apps.dojocoding.io`
- **Multi-environment** — staging branch for validation, main for production

## Submission Pipeline

### For Developers

1. Fork this repo
2. Add your signed APK to `apks/<package-name>/`
3. Create metadata YAML in `metadata/<package-name>.yml`
4. Open a Pull Request using the submission template
5. CI validates automatically (signature, metadata, tracker scan)
6. A DojoCodingLabs maintainer reviews and merges
7. Your app appears in the marketplace within minutes

### Validation Checks (CI)

| Check | Tool | Blocks merge? |
|-------|------|--------------|
| APK signature valid | `apksigner verify` | Yes |
| Package name matches metadata | `aapt2 dump badging` | Yes |
| Required metadata fields present | Custom YAML validator | Yes |
| Tracker scan | `exodus-standalone` | Warning only (informational) |
| Permissions audit | `aapt2 dump permissions` | Warning only |

### Metadata Format

Each app needs a YAML file in `metadata/`:

```yaml
# metadata/com.startup.appname.yml
Categories:
  - Utilities
License: MIT
AuthorName: Startup Name
AuthorEmail: dev@startup.com
SourceCode: https://github.com/startup/app
IssueTracker: https://github.com/startup/app/issues

AutoName: App Name
Description: |
  A brief description of what the app does.

# DojoCodingLabs fields
X-DojoLaunchpad: true
X-DojoHackathon: "Hackathon 2026-Q1"
X-DojoToolkit: flutter-go-to-market-toolkit  # Recommended, not required

CurrentVersion: 1.0.0
CurrentVersionCode: 1
```

## Security Model

### Repository Signing
- The repo index is signed with a GPG key owned by DojoCodingLabs
- The keystore is stored as a GitHub Actions secret
- Clients verify the signature before trusting the index
- Key rotation documented in `docs/KEY_ROTATION.md`

### APK Verification
- Each APK must be signed by the developer's own key
- We verify the signature but do NOT re-sign APKs
- The developer retains full control of their signing key
- Updates must be signed with the same key as the original submission

### Tracker Scanning
- Exodus Privacy's `exodus-standalone` scans for known tracking SDKs
- Results are **informational** (displayed in the repo browser), not blocking
- Startups are encouraged to minimize tracking, but it's their decision

## Keep Android Open: Resilience Plan

### Phase 1: Now through September 2026
- Marketplace works normally on any Android device
- Users add repo URL in their F-Droid client
- No Google dependencies in the distribution chain

### Phase 2: September 2026+ (post-verification mandate)
- Stock Android may block APKs from non-registered developers
- Document Google's "Advanced Flow" (10-step workaround) for users
- Create help page with step-by-step guide
- Consider registering DojoCodingLabs as an umbrella publisher if required
- Support the Keep Android Open campaign (https://keepandroidopen.org/)

### Phase 3: Contingency (if Google removes Advanced Flow)
- Custom ROMs (GrapheneOS, CalyxOS, LineageOS, /e/OS) are unaffected
- Position marketplace as the default repo for these ROMs
- Publish installation guides for alternative ROMs
- Explore partnerships with ROM maintainers

### What Does NOT Change
- The repo format (F-Droid-compatible) works regardless of Google's decisions
- APK signing by developers remains the same
- The CI/CD pipeline is unaffected
- Custom ROM users are never impacted

## Technology Stack

| Component | Technology | Why |
|-----------|-----------|-----|
| Repo generation | fdroidserver (Python) | Official F-Droid tooling, well-maintained |
| Hosting | Vercel | CDN, security headers, same as DojoOS |
| CI/CD | GitHub Actions | Native to the repo, free for public repos |
| APK validation | apksigner, aapt2 | Android SDK tools, standard |
| Tracker scanning | exodus-standalone | Exodus Privacy, FOSS |
| Client apps | Droid-ify, Neo Store | Modern F-Droid clients |

## Future Enhancements

### Phase 2: Reproducible Builds
- Verify that APKs match source code using `rbtlog` (IzzyOnDroid's tool)
- Display verification badges in the repo index
- Integrate with Codeberg/GitHub for source verification

### Phase 3: Web Portal
- Landing page with app catalog (Material for MkDocs or similar)
- Search and filtering by category, hackathon, toolkit usage
- Download statistics
- Developer profiles linked to DojoOS Launchpad

### Phase 4: Automated Updates
- Watch developer repos for new releases
- Auto-submit PRs when new APKs are detected
- Notification system for maintainers
