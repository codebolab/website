# High-End Technical Editorial: Design System Documentation

## 1. Overview & Creative North Star
### Creative North Star: "The Architectural Core"
This design system moves away from the "disposable" aesthetic of modern SaaS and toward a permanent, architectural feeling. We treat the interface not as a collection of buttons, but as a high-fidelity technical dashboard—think aerospace telemetry meets luxury editorial. 

The system is defined by **Intentional Asymmetry** and **Tonal Depth**. We bypass the standard "grid of cards" in favor of oversized typographic anchors, technical motifs (the parenthesis), and a layering logic that feels like stacked sheets of polarized glass.

---

## 2. Colors & Surface Logic
The palette is rooted in a deep, oceanic navy (`surface: #001233`), punctuated by high-energy technical accents.

### The "No-Line" Rule
**Strict Mandate:** Designers are prohibited from using 1px solid borders to define sections or containers. Separation must be achieved through:
1.  **Background Shifts:** Transitioning from `surface` to `surface-container-low`.
2.  **Negative Space:** Using the Spacing Scale (e.g., `12` or `16`) to create a cognitive break.
3.  **Tonal Transitions:** Subtle linear gradients between `surface-container` tiers.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers. Each deeper "level" of information should sit on a higher tier of the surface container scale:
*   **Global Background:** `surface` (#001233)
*   **Major Content Sections:** `surface-container-low` (#001a43)
*   **Interactive Modules/Cards:** `surface-container-high` (#00275f)
*   **Floating Elements/Modals:** `surface-bright` (#133773) with 80% opacity and `backdrop-blur`.

### The "Glass & Gradient" Rule
To avoid a "flat" feel, primary CTAs and hero highlights should use a subtle 45-degree gradient:
*   **Primary Action:** `primary` (#45f4bb) to `primary-container` (#00d7a0).
*   **Secondary Signal:** `secondary` (#5fd5fb) to `secondary-container` (#00a0c4).

---

## 3. Typography: Technical Authority
Our typography pairs the brutalist geometry of engineering with the clean legibility of modern tech.

*   **Display & Headlines (Plus Jakarta Sans):** These are your "Anchors." Use `display-lg` for hero statements. The bold, geometric nature of the font should feel heavy and permanent. Use `tight` letter-spacing (-0.02em) for headlines to create a "block" of text.
*   **Body (Manrope):** Optimized for long-form technical strategy. Manrope’s modern proportions ensure readability against dark backgrounds.
*   **Labels (Space Grotesk):** Reserved for technical metadata, small captions, and "system" info. The monospaced feel of Space Grotesk reinforces the studio's technical expertise.

---

## 4. Elevation & Depth
We eschew traditional drop shadows for **Tonal Layering**.

*   **The Layering Principle:** Depth is "built," not "cast." Place a `surface-container-lowest` card on a `surface-container-low` section to create a recessed effect. 
*   **Ambient Shadows:** If an element must float (e.g., a dropdown), use a shadow color tinted with the background: `rgba(0, 18, 51, 0.4)` with a `40px` blur and `0px` offset.
*   **Ghost Borders:** If accessibility requires a stroke, use `outline-variant` at **15% opacity**. Never use a 100% opaque stroke.
*   **Parentheses as Framing:** Use the "()" motif to frame content. Instead of a box, place a large `tertiary` (#e3d2ff) parenthesis at 10% opacity on either side of a content block to "bracket" the information.

---

## 5. Components

### Buttons
*   **Primary:** Gradient (`primary` to `primary-container`), black text (`on-primary`), `md` (0.375rem) corner radius. No border.
*   **Secondary:** Ghost style. Transparent background, `primary` text, and a `Ghost Border` (15% opacity primary stroke).
*   **Tertiary:** `label-md` text in `secondary-fixed`, no background, with a "()" symbol suffix that shifts 4px on hover.

### Cards & Lists
*   **The Divider Ban:** Never use horizontal lines. Use a `1.5` (0.5rem) vertical gap and a background shift to `surface-container-low`.
*   **Interactive Cards:** On hover, do not lift the card; instead, shift the background color to `surface-container-highest` and change the text from `on-surface-variant` to `on-surface`.

### Inputs
*   **Fields:** Background `surface-container-lowest`, bottom-only `Ghost Border`. 
*   **Focus State:** The bottom border transforms into a 2px `primary` solid line.

### Signature Component: The "Code-Bracket Wrapper"
For technical testimonials or code snippets, wrap the entire container in oversized, low-opacity parentheses `()` that extend beyond the container’s vertical bounds. This breaks the grid and adds an editorial, custom-coded feel.

---

## 6. Do’s and Don’ts

### Do
*   **Do** embrace massive white space. If you think there is enough space, add `12` (4rem) more.
*   **Do** use `tertiary` (Purple) as a "highlight" for technical terms within body text.
*   **Do** align text-heavy blocks to a 12-column grid, but allow technical graphics to "bleed" off the edge of the screen.

### Don't
*   **Don't** use standard "Grey" for backgrounds. Every "Dark" should be a shade of the deep navy `surface` token.
*   **Don't** use rounded corners larger than `xl` (0.75rem) unless it's for a `full` pill-shaped tag. We want "sharp and technical," not "bubbly."
*   **Don't** use generic icon sets. Icons should be thin-stroke (1px), sharp-cornered, and technical.

---

## 7. Spacing & Rhythm
We use a **Base-7** inspired scale to avoid "standard" spacing feels.
*   Use `10` (3.5rem) for section padding.
*   Use `20` (7rem) for Hero-to-Body transitions.
*   Use `3` (1rem) for component-internal spacing.