App Store Connect listing content for `fastlane deliver`.

`th/description.txt` and `th/release_notes.txt` are filled in and uploaded
automatically by the `release` lane. Screenshots are still skipped
(`skip_screenshots: true` in `../Fastfile`) — add real screenshots under
`../screenshots/th/` (sized per Apple's device-class requirements) and
remove that line once you have them.
