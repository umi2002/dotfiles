// ==UserScript==
// @name         Apple Music Metadata and Album Art Extractor
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Extract currently playing song's metadata and album art from Apple Music
// @author       You
// @match        https://music.apple.com/*
// @grant        GM_setValue
// ==/UserScript==

(function () {
  "use strict";

  function extractMetadataAndArt() {
    let titleElement = document.querySelector(
      ".lcd-meta__primary .lcd-meta-line__text-content .lcd-meta-line__fragment"
    );
    let artistElement = document.querySelector(
      ".lcd-meta__secondary .lcd-meta-line__text-content button.lcd-meta-line__fragment:nth-of-type(1)"
    );

    let title = titleElement
      ? titleElement.textContent.trim()
      : "Title not found";
    let artist = artistElement
      ? artistElement.textContent.trim()
      : "Artist not found";

    console.log(`Title: ${title}`);
    console.log(`Artist: ${artist}`);

    // if (title && artist && albumArt) {
    //   GM_setValue("currentSong", {
    //     title: title,
    //     artist: artist,
    //     albumArt: albumArt,
    //   });
  }
  // Run the extraction function every 5 seconds (adjust as needed)
  setInterval(extractMetadataAndArt, 5000);
})();
