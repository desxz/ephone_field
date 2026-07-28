import '../../domain/phone/phone.dart';

/// Owns the as-you-type session for the currently selected region.
class PhoneInputSession {
  /// Creates a session manager bound to [service].
  PhoneInputSession(this.service);

  /// Underlying phone capability.
  final PhoneNumberService service;

  AsYouTypeSession? _session;
  String? _regionCode;

  /// Active region code, if a session exists.
  String? get regionCode => _regionCode;

  /// Ensures a session exists for [regionCode], disposing any previous one.
  AsYouTypeSession forRegion(String regionCode) {
    final normalized = regionCode.toUpperCase();
    if (_session != null && _regionCode == normalized) {
      return _session!;
    }
    _session?.dispose();
    _regionCode = normalized;
    _session = service.createAsYouType(normalized);
    return _session!;
  }

  /// Clears accrued digits without changing region.
  void clear() {
    _session?.clear();
  }

  /// Disposes the active session.
  void dispose() {
    _session?.dispose();
    _session = null;
    _regionCode = null;
  }
}
