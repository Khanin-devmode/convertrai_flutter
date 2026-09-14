This folder is where Google Play Store listing content (title, descriptions,
changelog, screenshots) goes for `fastlane supply` to upload automatically.

It is currently empty — the `release` lane in `../Fastfile` skips metadata/
screenshot upload (`skip_upload_metadata`/`skip_upload_images`/
`skip_upload_screenshots: true`) until real content is added here, so an
empty folder can never accidentally wipe the live store listing.

Expected structure once populated (locale `th-TH` to match the app's
primary listing language):

```
android/th-TH/title.txt
android/th-TH/short_description.txt
android/th-TH/full_description.txt
android/th-TH/changelogs/default.txt
android/th-TH/images/featureGraphic.png
android/th-TH/images/icon.png
android/th-TH/images/phoneScreenshots/1.png (etc.)
```

Once filled in, remove the three `skip_upload_*` lines from the `release`
lane to turn the upload back on.
