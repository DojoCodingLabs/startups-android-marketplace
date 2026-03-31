# Submission Guide

Step-by-step guide for submitting your app to the DojoCodingLabs Startups Android Marketplace.

## Prerequisites

- A signed release APK of your Android app
- Your app's source code (recommended to be open source)
- Connection to DojoCodingLabs (hackathon, Launchpad, or accelerator)
- A GitHub account

## Step 1: Build Your Signed APK

If using Flutter:
```bash
flutter build apk --release
```

The signed APK will be at:
```
build/app/outputs/flutter-apk/app-release.apk
```

If you don't have a release keystore yet:
```bash
keytool -genkey -v \
  -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias upload
```

**Keep your keystore safe.** You'll need the same key for all future updates.

## Step 2: Fork and Clone

```bash
gh repo fork DojoCodingLabs/startups-android-marketplace --clone
cd startups-android-marketplace
```

## Step 3: Add Your APK

Create a directory for your package and copy the APK:

```bash
mkdir -p apks/com.yourstartup.appname
cp /path/to/app-release.apk apks/com.yourstartup.appname/com.yourstartup.appname_1.apk
```

**Naming convention:** `<package-name>_<versionCode>.apk`

## Step 4: Create Metadata

Create `metadata/com.yourstartup.appname.yml`:

```yaml
Categories:
  - Utilities          # See categories below
License: MIT           # SPDX identifier
AuthorName: Your Startup Name
AuthorEmail: dev@yourstartup.com
SourceCode: https://github.com/yourstartup/app
IssueTracker: https://github.com/yourstartup/app/issues

AutoName: Your App Display Name
Description: |
  A brief description of what your app does.
  
  Key features:
  * Feature one
  * Feature two

# DojoCodingLabs fields
X-DojoLaunchpad: true                    # or false
X-DojoHackathon: "Hackathon 2026-Q1"    # if applicable
X-DojoToolkit: flutter-go-to-market-toolkit  # if used

CurrentVersion: 1.0.0
CurrentVersionCode: 1
```

### Available Categories

Use one or more of these F-Droid categories:
- Connectivity
- Development
- Games
- Graphics
- Internet
- Money
- Multimedia
- Navigation
- Phone & SMS
- Reading
- Science & Education
- Security
- Sports & Health
- System
- Theming
- Time
- Utilities
- Writing

### Required Fields

| Field | Required | Description |
|-------|----------|-------------|
| Categories | Yes | At least one category |
| License | Yes | SPDX identifier |
| AuthorName | Yes | Developer or startup name |
| AutoName | Yes | Display name in the marketplace |
| Description | Yes | App description (supports basic markdown) |
| CurrentVersion | Yes | Must match APK |
| CurrentVersionCode | Yes | Must match APK |
| SourceCode | Recommended | Link to source repo |
| AuthorEmail | Recommended | Contact for issues |

## Step 5: Add Store Assets (Optional but Recommended)

Create a Fastlane-style metadata directory for screenshots and icons:

```
metadata/com.yourstartup.appname/
└── en-US/
    ├── full_description.txt
    ├── short_description.txt
    ├── title.txt
    ├── changelogs/
    │   └── 1.txt                    # Changelog for versionCode 1
    └── images/
        ├── icon.png                  # 512x512
        ├── featureGraphic.png        # 1024x500
        └── phoneScreenshots/
            ├── 01.png
            └── 02.png
```

## Step 6: Open a Pull Request

```bash
git checkout -b submit/com.yourstartup.appname
git add apks/ metadata/
git commit -m "feat: submit com.yourstartup.appname v1.0.0"
git push origin submit/com.yourstartup.appname
gh pr create --title "[Submission] Your App Name v1.0.0" --body-file .github/PULL_REQUEST_TEMPLATE.md
```

## Step 7: CI Validation

After opening the PR, GitHub Actions will automatically:

1. **Verify APK signature** — ensures the APK is properly signed
2. **Extract metadata** — confirms package name and version match
3. **Scan for trackers** — informational only, does not block
4. **Validate YAML** — checks all required fields are present

Fix any failures and push updates to the PR.

## Step 8: Maintainer Review

A DojoCodingLabs maintainer will:
- Verify your connection to a DojoCodingLabs program
- Review the app description and metadata
- Check the tracker scan results
- Merge the PR

Once merged, the deploy pipeline runs automatically and your app appears in the marketplace.

## Updating Your App

1. Build a new signed APK (same keystore)
2. Add the new APK to `apks/<package-name>/`
3. Update `CurrentVersion` and `CurrentVersionCode` in metadata
4. Add a changelog file at `metadata/<package-name>/en-US/changelogs/<versionCode>.txt`
5. Open a PR

## Removing Your App

Open an issue requesting removal, or submit a PR that deletes your APK and metadata files.

## Troubleshooting

### "APK signature verification failed"
- Ensure you signed the APK with a release keystore, not a debug key
- Run `apksigner verify --print-certs your-app.apk` to check

### "Package name mismatch"
- The filename, directory name, and metadata YAML filename must all use the same package name
- The package name inside the APK must match

### "Missing required metadata field"
- Check the required fields table above
- YAML is whitespace-sensitive — use spaces, not tabs

### "Update rejected: different signing key"
- All updates must be signed with the **same key** as the original submission
- If you lost your keystore, you'll need to submit as a new package name
