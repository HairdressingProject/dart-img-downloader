# img-downloader
A sample Dart CLI application that downloads images from the web.

## Usage
### Display usage instructions:

```bash
dart bin/main.dart
```

### Download an image:
```bash
dart bin/main.dart down https://upload.wikimedia.org/wikipedia/commons/d/d1/Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg
```

## Known limitations and issues
- User is not able to specify a download directory path
- Network errors such as 404 and 403 are not properly handled
- `-v` (verbose) flag has not yet been implemented
- No unit tests