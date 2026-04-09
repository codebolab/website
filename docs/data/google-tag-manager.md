# Google Tag Manager

## Estado actual

El sitio principal carga Google Tag Manager globalmente desde el layout base:

- container ID: `GTM-5W5XPQHK`
- implementación: [BaseLayout.astro](/Users/josezambrana/projects/codebolab/src/layouts/BaseLayout.astro)

## Implementación

La integración incluye:

- script de GTM en el `<head>`
- bloque `noscript` recomendado al inicio del `<body>`
- listener global para clicks sobre elementos etiquetados con `data-track-click`

## Alcance

Al estar integrado en el layout base, GTM se carga en todas las páginas del sitio Astro que usan ese layout.

## Tracking de clicks

El sitio ahora empuja eventos al `dataLayer` cuando se hace click en elementos etiquetados con atributos de tracking.

Evento enviado:

- `event`: `ui_click`

Campos enviados:

- `click_label`
- `click_section`
- `click_text`
- `click_href`
- `page_path`

Elementos etiquetados actualmente:

- navegación principal
- CTAs del hero
- CTAs de la sección final
- teléfono y email del footer
- navegación del footer

## Cómo extenderlo

Para trackear nuevos elementos, agregar atributos como:

```html
<a
  href="/example"
  data-track-click="example_link"
  data-track-section="hero"
>
  Example
</a>
```

Luego esos eventos pueden usarse dentro de Google Tag Manager para crear tags, triggers y métricas en Google Analytics u otras herramientas.
