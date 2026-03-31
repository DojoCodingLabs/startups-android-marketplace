# @dojocoding/tokens

Design tokens for the Dojo Marketplace, managed with [Style Dictionary](https://amzn.github.io/style-dictionary/).

## Token source

All tokens live in `tokens.json` following the CTI (Category / Type / Item) structure:

- `color.brand.*` -- brand colors (primary lilac, secondary peach, accent, semantic)
- `color.palette.*` -- tonal palettes with shades 0-100
- `typography.family.*` -- font families (Space Grotesk, Outfit, Inter)
- `motion.duration.*` -- animation durations (short, medium, long)

## Build outputs

| Platform | Output | Consumer |
|----------|--------|----------|
| CSS | `build/css/variables.css` | `apps/web/` (React + Tailwind) |
| Dart | `build/dart/tokens.dart` | `apps/mobile/` (Flutter) |

## Usage

```bash
npm install
npm run build
```

The build produces platform-specific token files that are imported by the consuming apps.

### Web (React / Tailwind)

Import the generated CSS in your entry stylesheet:

```css
@import '../../packages/tokens/build/css/variables.css';
```

Then reference tokens via CSS custom properties, e.g. `var(--color-brand-primary)`.

### Mobile (Flutter)

Copy or symlink the generated `tokens.dart` into `apps/mobile/lib/core/theme/` and import `DojoTokens` in your theme configuration.
