# JoySmith Studio 🧸

Cute 3D-printed toys, forged with joy in Malaysia.

Live site: https://joysmithstudio.github.io/joysmith-studio/

## Run locally
Just open `index.html` in a browser — no install, no build.
Or serve it (nicer for testing):
```
python3 -m http.server 8000
```
then open http://localhost:8000

## Edit products & shop settings
Everything you change day-to-day lives at the TOP of `index.html`:
- `SHOP` — WhatsApp number, Instagram, Shopee link, shipping rates, TNG QR
- `PRODUCTS` — copy a { ... } block, edit, save

## Deploy (GitHub Pages)
1. Push this folder to a GitHub repo named `joysmith-studio`
2. Repo Settings → Pages → Branch: main, folder: / (root)
3. Site updates automatically ~1 min after every push

## Work on it with Claude Code
Open a terminal in this folder and run `claude`.
Claude Code reads CLAUDE.md automatically and will understand the project.
Try: "add a new product called Sleepy Panda at RM30" or
"make the hero headline bigger on desktop".
