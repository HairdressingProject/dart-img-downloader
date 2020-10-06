import 'package:args/command_runner.dart';
import 'package:img_downloader/download_cmd.dart';

/// Returns a CommandRunner instance with all commands loaded, ready to start the application
CommandRunner getCmdRunner() {
  return CommandRunner(
      'dart bin/main.dart', 'CLI app to download images from the web')
    ..addCommand(DownloadCommand());
}
