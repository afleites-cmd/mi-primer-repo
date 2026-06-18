// Service worker mínimo: solo habilita la instalación como app ("Agregar a pantalla
// de inicio"). No cachea de forma agresiva para evitar servir versiones viejas:
// siempre intenta la red primero.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (e) => e.waitUntil(self.clients.claim()));
self.addEventListener("fetch", (event) => {
  event.respondWith(fetch(event.request).catch(() => caches.match(event.request)));
});
