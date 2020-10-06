import 'package:args/command_runner.dart';
import 'dart:io';

/// `down` command of the CLI application
class DownloadCommand extends Command {
  @override
  final name = 'down';

  @override
  final description = 'Download an image based on the provided URL';

  DownloadCommand() {
    argParser.addFlag('verbose',
        abbr: 'v', defaultsTo: false, help: 'Display progress status');
  }

  @override
  Future<void> run() async {
    var url = argResults.arguments[0];

    // check URL provided
    var exp = RegExp(r'http(s?)\:\/\/(.*)\/(.*)\.(jpg|jpeg|png|gif|bmp)',
        caseSensitive: false, multiLine: true, dotAll: true);

    if (exp.hasMatch(url)) {
      final match = exp.firstMatch(url);

      final matchStart = match.start;
      final matchEnd = match.end;

      final matchedUrl = url.substring(matchStart, matchEnd);
      final filename = match.group(match.groupCount - 1);
      final ext = match.group(match.groupCount);
      print('\nAttempting to download: ' + matchedUrl);

      var client = HttpClient();

      // check platform and download directory, create one if needed
      // improvements: allow user to specify a directory
      final isWindows = Platform.isWindows;

      final downloadDir = Directory(
          Directory.current.path + (isWindows ? '\\downloads' : '/downloads'));

      if (!await downloadDir.exists()) {
        await downloadDir.create();
      }

      final downloadPath = downloadDir.absolute.path +
          (isWindows ? '\\' : '/') +
          filename +
          '.' +
          ext;

      // download image and write to downloadPath
      // improvements: handle network errors, 404, 403, etc.
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
