'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "8859d602ea54097c2901e921d57669f8",
"assets/assets/fonts/Roboto-Bold.ttf": "e07df86cef2e721115583d61d1fb68a6",
"assets/assets/fonts/Roboto-Medium.ttf": "58aef543c97bbaf6a9896e8484456d98",
"assets/assets/fonts/Roboto-Regular.ttf": "11eabca2251325cfc5589c9c6fb57b46",
"assets/assets/fonts/WorkSans-Bold.ttf": "1fed2d8028f8f5356cbecedb03427405",
"assets/assets/fonts/WorkSans-Medium.ttf": "488b6f72b6183415e7a20aafa803a0c8",
"assets/assets/fonts/WorkSans-Regular.ttf": "30be604d29fd477c201fb1d6e668eaeb",
"assets/assets/fonts/WorkSans-SemiBold.ttf": "6f8da6d25c25d58ef3ec1c8b7c0e69c3",
"assets/assets/management_app/area1.png": "9cbfec64c29ec6821547f1c5093f38b7",
"assets/assets/management_app/area2.png": "2863c486c15808e8f105ccac2febfdbc",
"assets/assets/management_app/area3.png": "e85a8d2207edfb0325369d93982fba03",
"assets/assets/management_app/back.png": "af6b0e6121d6eb48289cce3a3b8d8963",
"assets/assets/management_app/bell.png": "929723572aa737a354244ca14fe5659b",
"assets/assets/management_app/bottle.png": "840d3c89291f9d3b0a859d7479c10d0c",
"assets/assets/management_app/breakfast.png": "1d2b0e6a7e46a44723131c663471f811",
"assets/assets/management_app/burned.png": "2ffad4b8dff525e57473142f0265b6bd",
"assets/assets/management_app/cefs.png": "d7a49e1ffef2925c83cf37ed5912515a",
"assets/assets/management_app/dinner.png": "d61779f47b560d09b0df15b346323ac4",
"assets/assets/management_app/eaten.png": "3f7d6f5aea8996d15d52c4c2268abd45",
"assets/assets/management_app/fitness_app.png": "bd55b7dc68210a0a5e6fa9341a47dbaf",
"assets/assets/management_app/glass.png": "266bca612c726abd6e481a4d890cef8e",
"assets/assets/management_app/lunch.png": "6855159f38835c1f03289b102a2e8b52",
"assets/assets/management_app/runner.png": "efb26bd46e91d305bda3b4b3c5a57c54",
"assets/assets/management_app/snack.png": "14a3e91c7a517b0a2f71dbcd86d2104d",
"assets/assets/management_app/tab_1.png": "629111ba46f6559071bcf25d2859a7ad",
"assets/assets/management_app/tab_1s.png": "fbd3aa5ed884a724f0435521586f6585",
"assets/assets/management_app/tab_2.png": "6506b7480618968b3daee97570927f65",
"assets/assets/management_app/tab_2s.png": "d270e94953ae9b7f377c5b253345374d",
"assets/assets/management_app/tab_3.png": "2a8f733675e2d8a7c6e9ac67a535bbf2",
"assets/assets/management_app/tab_3s.png": "a9093dcadf7724797ee22a5a802da7ad",
"assets/assets/management_app/tab_4.png": "f679006d5a49884f9ae89628d1d62d88",
"assets/assets/management_app/tab_4s.png": "40c45bbb7601c039da61be3e3c0f7520",
"assets/FontManifest.json": "261ea7743b692391b2a730a45379dba8",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "584daee0a723f1ee2f84443b369c52a3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "faa50e8e50177ed2180fbaa57a1c7819",
"/": "faa50e8e50177ed2180fbaa57a1c7819",
"main.dart.js": "ffa4bd91877c2471ba0ba3d58f37f666",
"manifest.json": "f866d4a8f69397ae1092ad856f7e159b",
"version.json": "86eb07450b8aa7ccf1d1e4e374b78f8e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
