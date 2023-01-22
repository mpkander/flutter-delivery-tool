import 'package:cli_util/cli_logging.dart';

class LogWriter {
  late final Logger _logger;

  /// Creates instance.
  LogWriter(bool isVerbose) {
    // Need to use Logger.progress method correctly.
    final ansi = Ansi(Ansi.terminalSupportsAnsi);

    _logger =
        isVerbose ? Logger.verbose(ansi: ansi) : Logger.standard(ansi: ansi);
  }

  /// Prints verbose.
  void v(String message) => _logger.trace(message);

  /// Prints simple message.
  void i(String message) => _logger.stdout(message);

  /// Prints error.
  void e(String message) => _logger.stderr('❌ $message');

  /// Prints warning.
  void w(String message) => _logger.stderr('⚠️ $message');

  /// Prints progress.
  Progress p(String message) => _logger.progress(message);
}
