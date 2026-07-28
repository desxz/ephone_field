import 'package:ephone_field/ephone_field.dart';

/// Test double for [PhoneNumberService].
class FakePhoneNumberService implements PhoneNumberService {
  /// Creates a configurable fake.
  FakePhoneNumberService({
    this.validNumbers = const <String>{},
    this.possibleNumbers = const <String>{},
    this.e164ByRaw = const <String, String>{},
    this.nationalByRaw = const <String, String>{},
    this.parseResults = const <String, PhoneParseResult>{},
    this.supportsAsYouTypeFormatting = true,
  });

  /// Raws (normalized key: digits only + region) treated as valid.
  final Set<String> validNumbers;

  /// Raws treated as possible.
  final Set<String> possibleNumbers;

  /// Map of raw+region key to E.164.
  final Map<String, String> e164ByRaw;

  /// Map of raw+region key to national format.
  final Map<String, String> nationalByRaw;

  /// Map of raw+region key to parse results.
  final Map<String, PhoneParseResult> parseResults;

  /// Created as-you-type sessions (for assertions).
  final List<FakeAsYouTypeSession> createdSessions = <FakeAsYouTypeSession>[];

  @override
  final bool supportsAsYouTypeFormatting;

  String _key(String raw, String regionCode) =>
      '${regionCode.toUpperCase()}|${raw.replaceAll(RegExp(r'\D'), '')}';

  @override
  bool isValid(String raw, {required String regionCode}) =>
      validNumbers.contains(_key(raw, regionCode));

  @override
  bool isPossible(String raw, {required String regionCode}) =>
      possibleNumbers.contains(_key(raw, regionCode)) ||
      isValid(raw, regionCode: regionCode);

  @override
  PhoneParseResult? parse(String raw, {required String regionCode}) =>
      parseResults[_key(raw, regionCode)];

  @override
  String? formatE164(String raw, {required String regionCode}) =>
      e164ByRaw[_key(raw, regionCode)] ??
      parse(raw, regionCode: regionCode)?.e164;

  @override
  String? formatNational(String raw, {required String regionCode}) =>
      nationalByRaw[_key(raw, regionCode)];

  @override
  AsYouTypeSession createAsYouType(String regionCode) {
    final session = FakeAsYouTypeSession(regionCode: regionCode);
    createdSessions.add(session);
    return session;
  }
}

/// Fake as-you-type session that concatenates digits with spaces every 3.
class FakeAsYouTypeSession implements AsYouTypeSession {
  /// Creates a session for [regionCode].
  FakeAsYouTypeSession({required this.regionCode});

  /// Region this session was created for.
  final String regionCode;

  final StringBuffer _digits = StringBuffer();

  /// Whether [dispose] was called.
  bool disposed = false;

  @override
  String inputDigit(String digit) {
    if (disposed) {
      throw StateError('AsYouTypeSession already disposed');
    }
    final cleaned = digit.replaceAll(RegExp(r'\D'), '');
    if (cleaned.isEmpty) {
      return _formatted();
    }
    _digits.write(cleaned);
    return _formatted();
  }

  String _formatted() {
    final raw = _digits.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(raw[i]);
    }
    return buffer.toString();
  }

  @override
  void clear() {
    _digits.clear();
  }

  @override
  void dispose() {
    disposed = true;
    _digits.clear();
  }
}
