This folder is where App Store Connect listing content (description,
keywords, release notes) goes for `fastlane deliver` to upload automatically.

It is currently empty — the `release` lane in `../Fastfile` skips metadata/
screenshot upload (`skip_metadata`/`skip_screenshots: true`) until real
content is added here and in `../screenshots/`, so an empty folder can never
accidentally wipe the live store listing.

Expected structure once populated (locale `th` to match the app's primary
listing language):

```
th/description.txt
th/keywords.txt
th/release_notes.txt
th/name.txt
th/subtitle.txt
```

Screenshots go in `../screenshots/th/` (sized per Apple's device-class
requirements — see `fastlane deliver` docs).

Once filled in, remove the two `skip_*` lines from the `release` lane to
turn the upload back on.
