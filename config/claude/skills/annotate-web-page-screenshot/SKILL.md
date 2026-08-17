---
name: annotate-web-page-screenshot
description: Capture an annotated screenshot of a web page (boxes, labels, arrows pointing at specific elements) using the Playwright MCP browser tools — no image library or OS-level screenshot tool needed. Use when the user asks for "proof of work" on a UI change, a visual bug report, a design/QA callout, a before/after comparison, or wants specific elements on a page marked up and explained. Requires the Playwright MCP server (mcp__playwright__* tools) to be connected.
---

# Annotate Web Page Screenshot with Playwright MCP

Skill to capture a screenshot of a web page and annotate it with boxes, labels, and arrows.

## When to Use This

Reach for this whenever the ask is visual and needs a marked-up image, not just a
plain screenshot:

- "Show me proof this works" / "screenshot the fix" — after making a UI change.
- "Take a screenshot and point out X" / "annotate this" / "mark up the issue."
- Reporting a visual bug: layout break, wrong copy, missing empty state, misaligned
  element — anything better shown than described.
- Before/after comparisons for a UI change.
- Design or accessibility review notes tied to specific page regions.

Use a plain `browser_take_screenshot` instead when an unannotated screenshot
already answers the ask, or when the user wants to draw the annotations themselves
interactively.

## Why This Approach

The `mcp__playwright__*` tool surface has no dedicated "highlight" or "annotate"
tool. It has:

- `browser_navigate`, `browser_snapshot`, `browser_take_screenshot` — navigation and
  capture.
- `browser_evaluate` — run JS in the page and return a value.
- `browser_run_code_unsafe` — run a Playwright script against `page` directly.

So annotation means injecting real DOM elements into the live page (styled
`div`s for boxes/labels, or an SVG overlay for arrows) via `browser_evaluate`, then
capturing the result with `browser_take_screenshot`. This needs no image-editing
library (Pillow, sharp, etc.) or install step — it works anywhere the MCP server is
already connected, and it's more accurate than annotating a static PNG after the
fact because you have live element geometry to anchor on.

## Workflow

1. Navigate to the page with `browser_navigate` (or drive the page into the
   target state first via clicks/fills).
2. Get exact element geometry from the accessibility tree or the DOM. Call
   `browser_snapshot({boxes: true})` to get each element's bounding box directly,
   or resolve a specific box with `browser_evaluate` against a CSS
   selector/`querySelector`. This is faster and more accurate than guessing
   coordinates from a screenshot image.
3. Inject the overlay with one `browser_evaluate` call: append absolutely
   positioned `div`s (outline boxes, filled label chips) or an `<svg>` layer
   (arrows/lines) directly to `document.body`. Use a helper function per shape so
   one call can drop multiple annotations. See snippet below.
4. Screenshot with `browser_take_screenshot({fullPage: true, filename:
   "<descriptive-name>.png"})`. Use `fullPage: true` unless the target region is
   guaranteed to be in the initial viewport.
5. Read the result back (`Read` tool on the saved PNG) to verify placement
   before handing it to the user — labels can overlap or run off-screen; check and
   re-run step 3 with adjusted positions if so.
6. Overlays vanish on next navigation/reload automatically since they're
   injected, not persisted, so no explicit cleanup is needed. When taking multiple
   screenshots of the *same* loaded page state without navigating between them,
   remove old overlays first (see snippet).

## Reusable Injection Snippet

Pass this as the `function` argument to `browser_evaluate`. It defines `box()` for
outline rectangles and `label()` for filled text chips, keyed off a consistent
color convention: red = bug/error, orange = warning/needs-attention, green =
confirms something works, blue = neutral/informational note.

```js
() => {
  // Remove any previous annotation layer before adding a new one.
  document.getElementById("__annotations")?.remove();

  const layer = document.createElement("div");
  layer.id = "__annotations";
  layer.style.position = "absolute";
  layer.style.top = "0";
  layer.style.left = "0";
  layer.style.zIndex = "999999";
  layer.style.pointerEvents = "none";
  document.body.appendChild(layer);

  // rect: DOMRect from element.getBoundingClientRect().
  // Absolute-positioned elements are document-relative, but
  // getBoundingClientRect() is viewport-relative — add scroll offsets
  // so placement is correct even if the page is scrolled.
  const docX = (rect) => rect.left + window.scrollX;
  const docY = (rect) => rect.top + window.scrollY;

  function box(rect, color = "#dc2626", padding = 4) {
    const el = document.createElement("div");
    el.style.position = "absolute";
    el.style.left = docX(rect) - padding + "px";
    el.style.top = docY(rect) - padding + "px";
    el.style.width = rect.width + padding * 2 + "px";
    el.style.height = rect.height + padding * 2 + "px";
    el.style.border = `3px solid ${color}`;
    el.style.boxSizing = "border-box";
    layer.appendChild(el);
  }

  function label(x, y, text, color = "#dc2626") {
    const el = document.createElement("div");
    el.textContent = text;
    el.style.position = "absolute";
    el.style.left = x + "px";
    el.style.top = y + "px";
    el.style.background = color;
    el.style.color = "white";
    el.style.font = "bold 14px Arial, sans-serif";
    el.style.padding = "4px 8px";
    el.style.borderRadius = "3px";
    el.style.maxWidth = "360px";
    layer.appendChild(el);
  }

  // Example: annotate a specific element found by selector.
  const el = document.querySelector("h1, h2");
  if (el) {
    const r = el.getBoundingClientRect();
    box(r, "#dc2626");
    label(docX(r), docY(r) + r.height + 8, "Describe the issue here", "#dc2626");
  }
}
```

For an arrow pointing at a small/off-heading element (e.g. an icon button), append
an `<svg>` with a `<line>` or `<path>` plus a `marker-end` arrowhead to `layer`
instead of a box — boxes work best for regions, arrows for pinpoint targets.

## Gotchas

- Scroll offset. `getBoundingClientRect()` is viewport-relative;
  `position: absolute` overlays are document-relative. Always add `window.scrollX`
  / `window.scrollY` (as in the snippet) or your boxes will drift once the page is
  scrolled or the screenshot is full-page.
- Label collisions. Labels placed directly below a tight bounding box can
  overlap a neighboring box. Read the screenshot back and nudge coordinates to
  keep the result legible.
- z-index. Set it high (`999999`) so overlays sit above page content, including
  sticky headers/modals.
- `pointerEvents: none` on the overlay layer keeps injected elements click-through,
  preserving future interactions if you keep driving the page afterward.
- File hygiene. Screenshots typically land in the repo root or a
  `.playwright-mcp/` output directory — use descriptive filenames, and check
  whether the project's `.gitignore` already excludes them before leaving them
  around; clean up ad-hoc screenshots once the user has what they need.
