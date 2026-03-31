# Submission Guide

## For Startup Developers

You don't need to fork this repo or learn F-Droid internals.

### Step 1: Publish a Release on Your Own Repo

Build a signed release APK and publish it as a GitHub/GitLab/Codeberg release:

```bash
# Build signed APK
flutter build apk --release

# Tag and release
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0

# Create GitHub Release with APK attached
gh release create v1.0.0 \
  build/app/outputs/flutter-apk/app-release.apk \
  --title "v1.0.0" \
  --notes "First release"
```

### Step 2: Open an Issue

Go to [New Issue > App Submission](https://github.com/DojoCodingLabs/startups-android-marketplace/issues/new?template=app-submission.yml) and fill out:
- Your repo URL (where the release APK lives)
- Package name
- Which DojoCodingLabs program you participated in
- Brief app description

### Step 3: Wait for Approval

A DojoCodingLabs maintainer will:
1. Verify your connection to a DojoCodingLabs program
2. Add your app's metadata to the marketplace
3. Reply to your issue confirming the app is live

### Updating Your App

Just publish a new release on your own repo with a new git tag. Our pipeline checks for new versions automatically and updates the marketplace.

### That's It

You never need to touch this repo. We fetch your APK from your releases.

---

## For Maintainers

This section is for DojoCodingLabs team members who manage the marketplace.

### Adding a New App

When a startup opens a submission issue:

1. **Verify** they participated in a DojoCodingLabs program (hackathon, Launchpad, accelerator)

2. **Check** their repo has a valid signed APK in releases:
   ```bash
   # Download and verify
   gh release download v1.0.0 -R startup/app -p "*.apk"
   apksigner verify --print-certs app-release.apk
   aapt2 dump badging app-release.apk | head -3
   ```

3. **Create metadata** file:
   ```bash
   cat > metadata/com.startup.appname.yml << 'EOF'
   Categories:
     - Utilities
   License: MIT
   AuthorName: Startup Name
   AuthorEmail: dev@startup.com
   SourceCode: https://github.com/startup/app
   IssueTracker: https://github.com/startup/app/issues

   AutoName: App Display Name
   Description: |
     Description from the submission issue.

   RepoType: git
   Repo: https://github.com/startup/app.git

   UpdateCheckMode: Tags
   AutoUpdateMode: Version

   X-DojoLaunchpad: true
   X-DojoHackathon: "Hackathon 2026-Q1"

   CurrentVersion: 1.0.0
   CurrentVersionCode: 1
   EOF
   ```

4. **Commit and push** to main:
   ```bash
   git add metadata/com.startup.appname.yml
   git commit -m "feat: add com.startup.appname to marketplace"
   git push
   ```

5. **Pipeline runs automatically** — fetches APK, scans, rebuilds index, deploys

6. **Reply to the issue** confirming the app is live, with the repo URL for users

### Removing an App

Delete the metadata file and push. The pipeline will regenerate the index without it.

```bash
git rm metadata/com.startup.appname.yml
git commit -m "remove: com.startup.appname"
git push
```

### Handling Updates

If `UpdateCheckMode: Tags` is set, fdroidserver detects new tags automatically during the scheduled pipeline run. No manual action needed.

If auto-update fails (e.g., developer changed signing key, tag format changed), manually update `CurrentVersion` and `CurrentVersionCode` in the metadata file.

### Metadata Reference

See [F-Droid Build Metadata Reference](https://f-droid.org/docs/Build_Metadata_Reference/) for all available fields.

Key fields for our use case:

| Field | Purpose | Required |
|-------|---------|----------|
| `Categories` | F-Droid category | Yes |
| `License` | SPDX identifier | Yes |
| `AuthorName` | Developer/startup name | Yes |
| `AutoName` | Display name | Yes |
| `Description` | App description | Yes |
| `SourceCode` | Repo URL | Yes |
| `RepoType` + `Repo` | Where to fetch releases | Yes |
| `UpdateCheckMode` | How to detect new versions | Yes |
| `CurrentVersion` + `CurrentVersionCode` | Latest known version | Yes |
| `X-DojoLaunchpad` | DojoCodingLabs flag | Custom |
| `X-DojoHackathon` | Which program | Custom |
