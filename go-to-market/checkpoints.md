# Ship Checkpoints
Last updated: 2026-03-31

## Status
- Gate 0 (Assessment): PASSED
- Space 1: PENDING
- Space 2: PENDING
- Space 3: PENDING
- Space 4: PENDING

## Gate Results

### Gate 0: Assessment
- [x] Project location confirmed
- [x] Target platforms defined (Android + Web)
- [x] Distribution channels selected (DojoCodingLabs Marketplace + Google Play + GitHub Releases)
- [x] Store accounts status known (Google Play Console exists, Apple not needed)
- [x] CI/CD assessed (Blacksmith custom runners, Codemagic optional for iOS)
- [x] Design tokens assessed (Style Dictionary tokens.json, AltruPets format)
- [x] Monetization decided (none, free marketplace)
- [ ] Bundle ID confirmed final (TBD: io.dojocoding.marketplace)
- [ ] Privacy policy URL published
- [x] Blockers identified (bundle ID, privacy policy, Supabase schema)
Status: PASSED (with 2 open blockers to resolve in Space 1)

### Gate 1: Code Readiness
- [ ] Monorepo structure created (apps/web, apps/mobile, packages/tokens)
- [ ] Style Dictionary pipeline working (tokens.json → CSS vars + Dart theme)
- [ ] Flavors configured (dev/prod)
- [ ] Error monitoring integrated
- [ ] Force update mechanism
- [ ] App Check activated
- [ ] Bundle ID finalized
- [ ] Privacy policy published
Status: NOT STARTED

### Gate 2: Pipeline & Signing
- [ ] CI/CD configured (Blacksmith runners)
- [ ] PR quality gate working
- [ ] Android keystore generated and uploaded
- [ ] Build pipeline produces signed APK
- [ ] Sentry symbol upload configured
- [ ] Shorebird initialized
Status: NOT STARTED

### Gate 3: Store & Testing
- [ ] Google Play: app created, listing complete
- [ ] Store listings with screenshots
- [ ] Internal testing: build distributed
- [ ] Feedback collected and addressed
Status: NOT STARTED

### Gate 4: Launch
- [ ] Production build uploaded
- [ ] Google Play: production track submitted
- [ ] Post-launch monitoring active
Status: NOT STARTED
