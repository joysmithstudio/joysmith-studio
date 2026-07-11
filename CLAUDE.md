# JoySmith Studio — Online Shop

## What this is
A mobile-first e-commerce site for JoySmith Studio, a Malaysian indie brand selling
cute 3D-printed collectible toys (Sleepy Series figurines + Flexi Series fidgets).
The whole site is ONE file: `index.html` — no build step, no framework, no dependencies.
It deploys to GitHub Pages; every commit to main auto-updates the live site.

## Architecture (single file, three zones)
1. **Config block** (top of file, inside first <script>): `SHOP` object (WhatsApp
   number, Instagram, Shopee, shipping rates, TNG QR filename) and `PRODUCTS` array.
   This is the ONLY section the owner edits day-to-day. Keep it simple and commented.
2. **CSS** (single <style> block): design tokens as CSS variables.
3. **App JS** (bottom <script>): rendering, search/filter, cart, checkout, payment,
   WhatsApp order handoff. Cart is in-memory (no localStorage by design).

## How ordering works (do not "fix" this into a fake gateway)
Cart → 3-step checkout (delivery form → TNG DuitNow QR payment → place order).
"Place order" opens WhatsApp (wa.me) with a formatted order message; the customer
sends it with their TNG receipt. Payment verification is MANUAL by the owner.
There is intentionally NO backend and NO automated payment gateway yet.
A future upgrade path is Billplz/senangPay once the business has SSM registration.

## Brand system (keep consistent)
- Fonts: Fredoka (headings), Nunito (body) — Google Fonts
- Palette: cream #FFF8EE bg, charcoal #2E2E2E text, accents:
  orange #F9A826, turquoise #27C4B2, lime #9CD93C, coral #FF6B6B, lavender #8E6BE8
- Vibe: playful collectible shop, light Pop Mart inspiration (white tiles on soft
  pastel tints, series labels, rounded cards, bouncy hover). Mobile-first always —
  traffic comes from an Instagram bio link.
- Logo: smiling gear mark (inline SVG in header/footer).

## Conventions
- Keep everything in index.html unless the project genuinely outgrows it.
- Product images: files placed next to index.html, referenced by filename in
  each product's `image:` field ("" falls back to emoji placeholder tile).
- Currency is RM. Shipping: West MY vs East MY (Sabah/Sarawak/Labuan) auto-detected
  from the state dropdown. Free shipping threshold via SHOP.freeShipAbove.
- Respect prefers-reduced-motion. Keep focus-visible styles.
- Owner is a mechatronics student and beginner web developer: explain changes
  clearly, prefer small readable code over clever abstractions.

## Common tasks
- Add/edit products → PRODUCTS array only.
- Change shipping/payment details → SHOP object only.
- New sections/pages → match existing design tokens; mobile-first.
- Before any visual change, check it at 375px width first.
