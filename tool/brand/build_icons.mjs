// Builds the CricScore app icon from the "wallslab" design in
// Design/CricScore_logo.html (Glyph.dc.html, kind="wallslab").
//
//   node tool/brand/build_icons.mjs
//
// Writes the SVG sources to tool/brand/ and renders PNGs into assets/brand/
// with headless Microsoft Edge (or Chrome via CHROME=path). Then run
// `dart run flutter_launcher_icons` to regenerate the Android mipmaps.
import { execFileSync } from 'node:child_process';
import { existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const root = resolve(here, '../..');
const out = join(root, 'assets/brand');
mkdirSync(out, { recursive: true });

const font = readFileSync(join(here, 'RobotoCondensed-ExtraBold-latin.woff2')).toString('base64');
const fontFace = `<style>@font-face{font-family:'Roboto Condensed';font-weight:800;src:url(data:font/woff2;base64,${font}) format('woff2')}</style>`;

// --- Artwork (100x100 units), verbatim from the design ----------------------
const WALL = `
  <rect width="100" height="100" fill="#3C4B37"/>
  <path d="M0 13H100M0 26H100M0 39H100M0 52H100M0 65H100M22 0V13M52 0V13M82 0V13M7 13V26M37 13V26M67 13V26M97 13V26M22 26V39M52 26V39M82 26V39M7 39V52M37 39V52M67 39V52M97 39V52M22 52V65M52 52V65M82 52V65M7 65V78M37 65V78M67 65V78M97 65V78" stroke="#263422" stroke-width="1.6" fill="none"/>
  <rect y="78" width="100" height="22" fill="#1A1C18"/>`;

const TEXT = (fill) =>
  `<text transform="translate(49.3 59) rotate(-90)" text-anchor="middle" font-size="10" textLength="33" lengthAdjust="spacingAndGlyphs" font-family="Roboto Condensed, sans-serif" font-weight="800" fill="${fill}">CricScore</text>`;

const FIGURES = `
  <g stroke="#F1F1E9" stroke-width="3.6" stroke-linecap="round" fill="none"><path d="M31 41.5V77M61 41.5V77M29 35.5H63"/></g>
  <rect x="39" y="40" width="14" height="38" rx="2.5" fill="#F1F1E9"/>
  ${TEXT('#3C4B37')}
  <g transform="translate(80 59) rotate(-12)">
    <rect x="-2.5" y="-36" width="5" height="16" rx="2" fill="#12140F"/>
    <rect x="-6.5" y="-21" width="13" height="42" rx="3.5" fill="#E8C98A"/>
    <rect x="-1" y="-18" width="2" height="34" rx="1" fill="#C9A464"/>
  </g>
  <circle cx="17" cy="72" r="6.5" fill="#BA1A1A"/>
  <path d="M13.5 67.5c2.5 3 2.5 6 0 9" stroke="#FFDAD6" stroke-width="1.3" fill="none"/>`;

// Single-colour silhouette for Android 13 themed icons: the system tints it,
// so detail is carried by shape alone (wordmark and bat grain knocked out).
const MONO = `
  <defs><mask id="knock">
    <rect width="100" height="100" fill="#fff"/>
    ${TEXT('#000')}
    <g transform="translate(80 59) rotate(-12)"><rect x="-1" y="-18" width="2" height="34" rx="1" fill="#000"/></g>
    <path d="M13.5 67.5c2.5 3 2.5 6 0 9" stroke="#000" stroke-width="1.3" fill="none"/>
  </mask></defs>
  <g mask="url(#knock)" fill="#fff">
    <g stroke="#fff" stroke-width="3.6" stroke-linecap="round" fill="none"><path d="M31 41.5V77M61 41.5V77M29 35.5H63M10 80H90"/></g>
    <rect x="39" y="40" width="14" height="38" rx="2.5"/>
    <g transform="translate(80 59) rotate(-12)">
      <rect x="-2.5" y="-36" width="5" height="16" rx="2"/>
      <rect x="-6.5" y="-21" width="13" height="42" rx="3.5"/>
    </g>
    <circle cx="17" cy="72" r="6.5"/>
  </g>`;

const svg = (body, { viewBox = '0 0 100 100', clipRadius } = {}) => {
  const clip = clipRadius
    ? `<clipPath id="r"><rect width="100" height="100" rx="${clipRadius}"/></clipPath>`
    : '';
  const open = clipRadius ? '<g clip-path="url(#r)">' : '<g>';
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="${viewBox}">${fontFace}<defs>${clip}</defs>${open}${body}</g></svg>`;
};

// Adaptive icons: a 108dp layer of which the inner 72dp is shown through the
// launcher's mask. Fitting the 100-unit artwork to that 72dp keeps the ball
// and bat inside even a circular mask (both sit < 45 units from centre).
const ADAPTIVE_VIEWBOX = '-25 -25 150 150'; // 100 / 150 == 72 / 108

const files = {
  'cricscore_icon.svg': svg(WALL + FIGURES),
  // 112/512 corner radius, as on the design's rounded preview.
  'cricscore_icon_rounded.svg': svg(WALL + FIGURES, { clipRadius: 21.875 }),
  'cricscore_icon_foreground.svg': svg(WALL + FIGURES, { viewBox: ADAPTIVE_VIEWBOX }),
  'cricscore_icon_monochrome.svg': svg(MONO, { viewBox: ADAPTIVE_VIEWBOX }),
};
for (const [name, text] of Object.entries(files)) writeFileSync(join(here, name), text);

// --- Render -----------------------------------------------------------------
const browser =
  process.env.CHROME ??
  ['C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe',
   'C:/Program Files/Google/Chrome/Application/chrome.exe'].find(existsSync);
if (!browser) throw new Error('No Edge/Chrome found; set CHROME=path/to/browser');

const renders = [
  ['cricscore_icon.svg', 'app_icon.png', 1024], // full-bleed square
  ['cricscore_icon_rounded.svg', 'app_icon_legacy.png', 1024], // pre-Android 8
  ['cricscore_icon_foreground.svg', 'app_icon_foreground.png', 1024],
  ['cricscore_icon_monochrome.svg', 'app_icon_monochrome.png', 1024],
  ['cricscore_icon_rounded.svg', 'logo.png', 512], // in-app logo
];
const tmp = join(here, '.render');
mkdirSync(tmp, { recursive: true });
try {
  for (const [src, dest, size] of renders) {
    const page = join(tmp, `${dest}.html`);
    writeFileSync(
      page,
      `<!doctype html><html><head><style>html,body{margin:0;background:transparent}img{display:block;width:${size}px;height:${size}px}</style></head>` +
        `<body><img src="${pathToFileURL(join(here, src))}"></body></html>`,
    );
    execFileSync(browser, [
      '--headless=new',
      '--disable-gpu',
      '--hide-scrollbars',
      '--force-device-scale-factor=1',
      '--default-background-color=00000000',
      `--window-size=${size},${size}`,
      `--screenshot=${join(out, dest)}`,
      pathToFileURL(page).href,
    ], { stdio: 'ignore' });
    console.log('rendered', dest);
  }
} finally {
  rmSync(tmp, { recursive: true, force: true });
}
