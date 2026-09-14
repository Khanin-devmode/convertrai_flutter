Google Play Store listing content for `fastlane supply`.

`en-US/title.txt`, `short_description.txt`, `full_description.txt`, and
`changelogs/default.txt` are filled in and uploaded automatically by the
`release` lane. The locale is `en-US` (not `th-TH`) because that's the
locale the app's Play Store listing is actually registered under — the
existing title is Thai text typed into the English-language listing
fields, there's no separate `th-TH` locale on this app. Screenshots/images
are still skipped (`skip_upload_images`/`skip_upload_screenshots: true` in
`../Fastfile`) — add real screenshots under `en-US/images/` and remove
those two lines once you have them.

`changelogs/default.txt` is supply's fallback changelog used for any
version code that doesn't have its own `changelogs/<version_code>.txt` —
convenient here since the release lane computes the version code at
build time.
