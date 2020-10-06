import 'dart:io';

import 'package:img_downloader/cli.dart';

Future<void> main(List<String> args) async {
  var runner = getCmdRunner();

  await runner.run(args).catchError((error) {
    print('\nError: Please provide a valid URL');
    print(error);
    exit(64);
  });

  exit(0);
}
