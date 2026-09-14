Google Play Store listing content for `fastlane supply`.

`th-TH/short_description.txt`, `full_description.txt`, and
`changelogs/default.txt` are filled in and uploaded automatically by the
`release` lane. Screenshots/images are still skipped
(`skip_upload_images`/`skip_upload_screenshots: true` in `../Fastfile`) —
add real screenshots under `th-TH/images/` and remove those two lines once
you have them.

`changelogs/default.txt` is supply's fallback changelog used for any
version code that doesn't have its own `changelogs/<version_code>.txt` —
convenient here since the release lane computes the version code at
build time.
