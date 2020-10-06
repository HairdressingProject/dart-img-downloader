import 'package:args/command_runner.dart';
import 'dart:io';

/// `down` command of the CLI application
class DownloadCommand extends Command {
  @override
  final name = 'down';

  @override
  final description = 'Download an image based on the provided URL';

  Directory _downloadDir = Directory(Directory.current.path +
      (Platform.isWindows ? '\\downloads' : '/downloads'));

  String _filenameWithoutExtension = 'img';

  DownloadCommand() {
    argParser.addFlag('verbose',
        abbr: 'v', defaultsTo: false, help: 'Display progress status');

    argParser.addOption('directory',
        abbr: 'd',
        defaultsTo: _downloadDir.absolute.path,
        help: 'Absolute directory path to save the image');

    argParser.addOption('filename',
        abbr: 'f',
        defaultsTo: _filenameWithoutExtension,
        help: 'Filename of the image to be saved, without extension');
  }

  @override
  Future<void> run() async {
    var url = argResults.arguments[0];
    String directory = argResults['directory'];
    String filename = argResults['filename'];

    // check URL provided
    var exp = RegExp(r'http(s?)\:\/\/(.*)\/(.*)\.(jpg|jpeg|png|gif|bmp|svg)',
        caseSensitive: false, multiLine: true, dotAll: true);

    if (exp.hasMatch(url)) {
      final match = exp.firstMatch(url);

      final matchStart = match.start;
      final matchEnd = match.end;

      final matchedUrl = url.substring(matchStart, matchEnd);
      // final urlFilename = match.group(match.groupCount - 1);
      final ext = match.group(match.groupCount);

      print('\nAttempting to download: ' + matchedUrl);

      if (directory.toString() != _downloadDir.absolute.path) {
        _downloadDir = Directory(directory);
      }

      if (!await _downloadDir.exists()) {
        await _downloadDir.create();
      }

      _filenameWithoutExtension = filename;

      final downloadPath = _downloadDir.absolute.path +
          (Platform.isWindows ? '\\' : '/') +
          filename +
          '.' +
          ext;

      // download image and write to downloadPath
      // improvements: handle network errors, 404, 403, etc.
      var client = HttpClient();
      await client
          .getUrl(Uri.parse(matchedUrl))
          .then((req) => req.close())
          .then((res) => res.pipe(File(downloadPath).openWrite()));

      print('\nDone!');
      print('Image saved to: ' + downloadPath);

      return;
    } else {
      print('\nInvalid URL. Please provide a URL as exemplified below:');
      print('http://some_domain/img.png');
      print('https://some_domain/etc/another_img.jpg');
    }
  }
}
