# CodeboLab — Website

Marketing site for [CodeboLab](https://codebolab.com), a technical partner for SaaS products built on software, data, analytics, and AI.

Built with [Astro](https://astro.build).

## Getting started

Requires Node >= 22.

```bash
yarn install
yarn dev
```

Other commands:

| Command        | Action                        |
|----------------|-------------------------------|
| `yarn dev`     | Start local dev server        |
| `yarn build`   | Build for production          |
| `yarn preview` | Preview the production build  |
| `yarn check`   | Run Astro type checks         |

## Structure

```
src/
  components/   Reusable Astro components
  layouts/      Page layouts
  pages/        Routes (index.astro → /)
  styles/       Global CSS

docs/           Strategy and product documentation
  business/     Positioning, offer, ICP
  product/      Landing page spec, product narrative
  engineering/  Architecture and technical standards
  data/         Analytics, events, data models
  ai/           AI strategy and integration
  operations/   Internal processes

stitch/         Original design prototype (reference only)
```

## Working in this repo

The `docs/` directory is the source of truth for positioning and content. Any change to landing page copy should stay aligned with the documents there.

See [AGENTS.md](AGENTS.md) for full guidelines on how to work in this repository.
