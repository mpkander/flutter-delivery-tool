import 'package:cli_util/cli_logging.dart';

// Need to use Logger.progress method correctly.
final _ansi = Ansi(Ansi.terminalSupportsAnsi);

final logWriter = LogWriter();

class LogWriter {
  Logger _logger = Logger.standard(ansi: _ansi);

  set isVerbose(bool value) {
    if (value) _logger = Logger.verbose(ansi: _ansi);
  }

  static final LogWriter _instance = LogWriter._internal();

  factory LogWriter() => _instance;

  LogWriter._internal();

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
