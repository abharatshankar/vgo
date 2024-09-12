import 'package:logger/logger.dart';

var loggerNoStack = Logger(
  filter: DevelopmentFilter(),
  printer: PrettyPrinter(methodCount: 0, printTime: true),
);