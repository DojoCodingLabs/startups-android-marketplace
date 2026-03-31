# Ship Plan: Startups Android Marketplace
Generated: 2026-03-31
Project: startups-android-marketplace (DOJ-2956)
Platforms: Android (mobile Flutter) + Web (React)
CI/CD: GitHub Actions + Blacksmith custom runners (Codemagic optional for future iOS)
Monetization: None (free marketplace)
Distribution: DojoCodingLabs Marketplace + Google Play + GitHub Releases
Starting space: 1

## Architecture Decision

**Two codebases, one backend:**
- **Flutter mobile** (Android) — maintained by the founder. Marketplace client app with APK install, auto-update, push notifications
- **React web** — maintained by the DojoOS team. Public catalog at `startups-app-store.dojocoding.io`, reuses Dojo Design System
- **Supabase backend** — shared with DojoOS (same project, `marketplace_*` tables, shared auth)
- **Design tokens** — Style Dictionary `tokens.json` generates Dart theme (Flutter) + CSS variables (React) from single source

## Estimate (minutes)

- Gate 0 (Assessment): PASSED (~30 min)
- Space 1 (Code Readiness): ~120 min
- Space 2 (Pipeline & Signing): ~90 min
- Space 3 (Store Preparation): ~180 min
- Space 4 (Launch): ~60 min
- **Total: ~480 min (~8 hours active work)**

## Gate 0 Answers

1. **Project:** `DojoCodingLabs/startups-android-marketplace` (monorepo: apps/mobile + apps/web)
2. **Platforms:** Android (Flutter) + Web (React). iOS future.
3. **Distribution:** DojoCodingLabs Marketplace (self), Google Play, GitHub Releases
4. **First time:** Yes, first release
5. **Store accounts:** Google Play Console (DojoCodingLabs org exists). Apple Developer: not needed yet.
6. **CI/CD:** GitHub Actions + Blacksmith `blacksmith-4vcpu-ubuntu-2404` (same as DojoOS). Codemagic optional for future iOS.
7. **Design tokens:** Style Dictionary `tokens.json` following AltruPets format. Generates Dart theme + CSS vars.
8. **Monetization:** None (free marketplace)
9. **Privacy policy:** Needed (will share DojoOS privacy policy domain)
10. **Bundle ID:** `io.dojocoding.marketplace` (TBD — confirm before first upload)

## Blockers Detected

- [ ] Bundle ID not finalized — needs confirmation
- [ ] Privacy policy URL — needs to be published
- [ ] Supabase schema — `marketplace_*` tables need migration

## Spaces to Execute

- [x] Space 1: pre-launch-checklist, app-security (no monetization needed)
- [x] Space 2: cicd-setup (Blacksmith), code-push (Shorebird)
- [x] Space 3: store-setup (Google Play), store-listing, testing-tracks
- [x] Space 4: launch-plan (production submission)

## Skipped (not applicable)

- [ ] iOS (not targeting iOS yet)
- [ ] Monetization (free marketplace)
- [ ] Codemagic (using Blacksmith instead)
- [ ] App Store Connect (no iOS)

## Stack

### Flutter Mobile (apps/mobile/)
- Flutter 3.x + Dart
- State: Riverpod
- Backend: Supabase client
- Theme: Generated from Style Dictionary tokens
- CI/CD: GitHub Actions + Blacksmith

### React Web (apps/web/)
- React 19 + TypeScript + Vite
- UI: Dojo Design System (from DojoOS)
- State: TanStack Query
- Backend: Supabase client (shared)
- Deploy: Vercel (`startups-app-store.dojocoding.io`)

### Shared
- Supabase (DojoOS project, `marketplace_*` tables)
- Style Dictionary tokens (`packages/tokens/`)
- Supabase Edge Functions (APK validation, notifications)

## Supabase Tables

```sql
marketplace_apps (id, package_name, display_name, description, author_id → profiles, source_repo_url, license, category, icon_url, current_version, current_version_code, hackathon_id → hackathons, is_published, created_at, updated_at)

marketplace_releases (id, app_id → marketplace_apps, version_name, version_code, apk_url, apk_size_bytes, changelog, is_latest, created_at)

marketplace_installs (id, app_id → marketplace_apps, user_id → profiles, release_id → marketplace_releases, installed_at)
```

## Pages (Web)

| Route | Auth | Description |
|-------|------|-------------|
| `/` | No | Landing + app catalog |
| `/app/:packageName` | No | App detail (screenshots, download) |
| `/category/:slug` | No | Filter by category |
| `/submit` | Yes (DojoOS) | Submission dashboard |
| `/admin` | Yes (admin) | Moderation panel |

## Implementation Phases

### Phase 1: Scaffold monorepo
- Convert existing repo to monorepo (`apps/web`, `apps/mobile`, `packages/tokens`, `infra/`)
- Move existing docs/infra to `infra/`
- Setup Style Dictionary pipeline (tokens.json → CSS vars + Dart theme)

### Phase 2: Supabase schema + API
- Create `marketplace_*` tables as Supabase migration
- Edge Function for APK validation
- RLS policies (public read, authenticated write for submissions)

### Phase 3: React web catalog
- Scaffold Vite + React 19 + Dojo DS
- Pages: landing, catalog, app detail, download
- Deploy to Vercel

### Phase 4: Flutter mobile app
- Scaffold Flutter project with flavors (dev/prod)
- Integrate Supabase client
- Apply Style Dictionary theme
- Core screens: catalog, app detail, download/install APK
- CI/CD with Blacksmith

### Phase 5: Testing + Launch
- Internal testing (Google Play internal track)
- Collect feedback
- Production release via flutter-go-to-market-toolkit
