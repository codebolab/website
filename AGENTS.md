# AGENTS.md

## Purpose

This repository has two main goals:

1. Maintain the business and product documentation for CodeboLab in Markdown.
2. Build and evolve the marketing landing page in Astro based on those documents.

Agents working in this repository should treat the Markdown documents as the strategic source of truth and the Astro site as the implementation layer derived from that strategy.

## Working Principles

- Start by reading the relevant documents in `docs/` before making content or implementation decisions.
- Prefer evolving existing documents over creating duplicate documents with overlapping purpose.
- Keep business, product, and implementation aligned. If a landing page claim is added or changed, the supporting docs should reflect it.
- Do not invent capabilities, credentials, case studies, pricing, guarantees, or client outcomes that are not already present in the repository or explicitly provided by the user.
- Keep the tone professional, credible, modern, and business-oriented.
- Optimize for clarity and conversion, not jargon.

## Repository Structure

### Documentation

- `docs/business/`: positioning, offers, ICP, service definition, sales-oriented messaging
- `docs/product/`: product narrative, landing page structure, UX/content specs
- `docs/engineering/`: technical architecture, standards, implementation decisions
- `docs/data/`: analytics, tracking, data models, reporting, pipelines
- `docs/ai/`: AI strategy, prompts, model usage, evaluation
- `docs/operations/`: internal process and delivery documentation

### Application

- The landing page should live in the Astro app once it is added to the repository.
- When implementation begins, agents should preserve a clear mapping between landing page sections and the relevant product/business docs.

## Source of Truth

Use the following priority when making decisions:

1. Direct user instructions
2. Existing repository documents in `docs/`
3. Consistency with the rest of the repo
4. Reasonable assumptions that are explicitly stated in the final message

If there is a conflict between a landing page implementation and a business/product document, update carefully and keep both aligned.

## Documentation Rules

- Use Markdown for all strategy and planning documents.
- Place each document in the directory that best matches its primary purpose.
- Use descriptive `kebab-case` file names.
- Prefer concise, scannable sections with clear headings.
- Keep documents easy to reuse for copywriting, design, and implementation.
- When a document mixes English and Spanish, preserve the existing language unless the user asks for normalization.
- Do not rewrite unrelated documents unless the task requires cross-document alignment.

## Landing Page Rules

- The landing page is a business asset, not just a technical demo.
- Every section should support a clear conversion goal, usually scheduling a call or submitting a form.
- Copy should reflect the documented positioning of CodeboLab:
  - technical partner
  - SaaS product development
  - strong foundation in data, analytics, and AI
  - product-first and business-aware approach
- Avoid generic agency copy.
- Avoid making the site feel overly corporate or overly experimental.
- Keep the UX intentional, modern, and credible.

## Astro Implementation Guidance

When the Astro app exists:

- Keep content structure close to the landing page spec in `docs/product/`.
- Prefer small, reusable components for landing page sections.
- Keep copy easy to trace back to the supporting Markdown documents.
- If content is likely to change frequently, prefer storing it in structured content files instead of hardcoding large text blocks in components.
- Preserve good defaults for performance, accessibility, and SEO.

## Editing Guidance

- Make focused changes.
- Avoid broad refactors unless they directly support the task.
- If creating a new document, choose the folder intentionally and use a specific descriptive name.
- If introducing a new convention, document it in `docs/README.md` or another clearly relevant file.
- If the repository grows, prefer adding lightweight index documents rather than duplicating summaries across many files.

## Typical Tasks

Examples of good tasks in this repo:

- Create or refine a business or product document
- Align positioning across multiple Markdown documents
- Turn a landing page spec into Astro components
- Update landing page copy to match the documented offer
- Add analytics or SEO implementation that supports the landing page

## Before Finishing

Before completing a task, agents should verify:

- The new or updated content matches the current positioning of CodeboLab
- The document lives in the right folder
- File names follow the repository convention
- Any implementation work stays aligned with the documents in `docs/`
