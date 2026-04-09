import type { APIRoute } from "astro";

export const GET: APIRoute = ({ site }) => {
  const body = [
    "User-agent: *",
    "Allow: /",
    site ? `Sitemap: ${new URL("/sitemap.xml", site).toString()}` : "Sitemap: /sitemap.xml"
  ].join("\n");

  return new Response(body, {
    headers: {
      "Content-Type": "text/plain; charset=utf-8"
    }
  });
};
