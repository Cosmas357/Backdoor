const CACHE_NAME = "backdoor-cache-v1";
const urlsToCache = [
  "/",  // App shell

  // CSS & JS
  "/static/css/bootstrap.min.css",
  "/static/css/autoComplete.css",
  "/static/js/bootstrap.bundle.min.js",
  "/static/js/autoComplete.min.js",

  // Icons & manifest
  "/static/icons/icon-192x192.png",
  "/static/icons/icon-512x512.png",
  "/static/manifest.json",

  // Offline fallback page
  "/static/offline.html",

  // Pre-cached fallback UIs for offline views
  "/static/fallback/register.html",
  "/static/fallback/attendance.html",
  "/static/fallback/followup.html",
  "/static/fallback/database.html",
  "/static/fallback/mark_attendance.html",
  "/static/fallback/sms.html",
  "/static/fallback/view_souls.html",
];

// ✅ Install: Cache all specified resources
self.addEventListener("install", (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(CACHE_NAME).then(async (cache) => {
      for (const url of urlsToCache) {
        try {
          const response = await fetch(url);
          if (response.ok) {
            await cache.put(url, response.clone());
            console.log(`[SW] Cached: ${url}`);
          } else {
            console.warn(`[SW] Skipped (bad response): ${url}`);
          }
        } catch (err) {
          console.warn(`[SW] Skipped (fetch failed): ${url}`);
        }
      }
    })
  );
});

// ✅ Activate: Remove old caches
self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((key) => key !== CACHE_NAME)
          .map((key) => caches.delete(key))
      )
    )
  );
  clients.claim();
  console.log("[SW] Activated. Old caches cleared.");
});

// ✅ Fetch: Try cache first, then network, then fallback
self.addEventListener("fetch", (event) => {
  console.log("[SW] Fetching:", event.request.url, "Mode:", event.request.mode);

  event.respondWith(
    caches.match(event.request).then((cached) => {
      if (cached) {
        console.log("[SW] Serving from cache:", event.request.url);
        return cached;
      }
      return fetch(event.request).catch((err) => {
        console.warn("[SW] Network error:", err.message);

        // Only fallback for navigations (HTML pages)
        if (event.request.mode === "navigate") {
          console.log("[SW] Serving fallback offline page.");
          return caches.match("/static/offline.html");
        }
      });
    })
  );
});
