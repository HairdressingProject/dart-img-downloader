# img-downloader
A sample Dart CLI application that downloads images from the web.

## Usage
### Display usage instructions:

```bash
dart bin/main.dart
dart bin/main.dart help down
```

### Download an image:
The command below will download [this image](https://upload.wikimedia.org/wikipedia/commons/d/d1/Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg "Sample image") to a directory named `downloads/` in your current working directory, with the filename `img.jpg`.

```bash
dart bin/main.dart down https://upload.wikimedia.org/wikipedia/commons/d/d1/Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg
```

You may also specify a directory (absolute path) or filename (without extension), using the `--directory (-d)` or `--filename (-f)` options, respectively.

Example:

```bash
dart bin/main.dart down https://upload.wikimedia.org/wikipedia/commons/d/d1/Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg -f mount_everest -d "C:/Users/user/Pictures"
```

## Known limitations and issues
- Network errors such as 404 and 403 are not properly handled
- `-v` (verbose) flag has not yet been implemented
- No unit tests