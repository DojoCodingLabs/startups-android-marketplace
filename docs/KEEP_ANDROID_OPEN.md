# Keep Android Open: Impact Assessment

## What is Happening

In August 2025, Google announced the **Android Developer Verification Program**. Starting **September 2026**, all Android app developers must:

1. Register centrally with Google
2. Pay registration fees
3. Submit government identification
4. Upload evidence of their private signing key
5. List all current and future app identifiers

**Apps from non-registered developers will be blocked** on stock Android devices.

## Source

- https://keepandroidopen.org/
- The movement is grassroots, noncommercial, supported by developers, consumers, and regulators worldwide.

## Impact on This Marketplace

### Before September 2026

No impact. Users can add the repo URL in any F-Droid client and install apps normally.

### After September 2026

Google will push updates via Google Play Services (not Android OS updates) that block unverified apps. Users on **stock Android** (Samsung, Pixel, etc.) will face:

**The "Advanced Flow" Workaround (10 steps):**
1. Enable Developer Mode (tap build number 7 times)
2. Open Developer Options
3. Toggle "Allow Unverified Packages"
4. Enter device unlock credentials
5. Restart device
6. **Wait 24 hours**
7. Return to unverified packages menu
8. Choose "Allow temporarily" (7 days) or "Allow indefinitely"
9. Confirm understanding of risks
10. Tap "Install anyway" on each app

**Critical concerns:**
- This flow runs through **Google Play Services**, not Android OS
- Google can modify, restrict, or remove it at any time without user consent
- As of March 2026, it exists only as blog posts and UI mockups — no shipping implementation verified
- The 24-hour waiting period and warning screens are designed to discourage sideloading

### On Custom ROMs

**No impact.** Custom ROMs without Google Play Services are not affected:

| ROM | Google Play Services | Affected? |
|-----|---------------------|-----------|
| GrapheneOS | No | Not affected |
| CalyxOS | Optional (microG) | Not affected |
| LineageOS | No | Not affected |
| /e/OS | No (microG) | Not affected |
| Stock Android (Samsung, Pixel) | Yes | Affected |

## Our Strategy

### Phase 1: Build Now (2025-2026)
Launch the marketplace while distribution is unrestricted. Build a catalog of startup apps and establish user trust.

### Phase 2: Educate (September 2026+)
- Document the Advanced Flow for stock Android users
- Create help pages and video tutorials
- Maintain a FAQ for common installation issues

### Phase 3: Adapt (if Advanced Flow is restricted)
- Position as the default repo for custom ROM users
- Partner with ROM communities
- Consider DojoCodingLabs registering as an umbrella publisher (one registered entity publishing on behalf of multiple startups)
- Support regulatory campaigns (EU DMA, US DOJ antitrust)

## What Developers Should Know

If you're publishing through this marketplace:
- Your app will always be installable on custom ROMs
- On stock Android post-September 2026, users may need extra steps
- You do NOT need to register with Google to publish here
- You retain full control of your signing key
- We will keep this documentation updated as the situation evolves

## Resources

- [Keep Android Open](https://keepandroidopen.org/) — main campaign site
- [FreeDroidWarn](https://keepandroidopen.org/) — library to warn users about the verification mandate
- [F-Droid](https://f-droid.org/) — the original FOSS app catalogue
- [GrapheneOS](https://grapheneos.org/) — privacy-focused custom ROM
- [CalyxOS](https://calyxos.org/) — usability-focused custom ROM
