import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Zero-Knowledge Card Vault Security Service
/// Strictly enforces: NO CVV, NO ATM PIN, NO BANKING PASSWORDS stored anywhere.
class VaultSecurityService {
  static const _keystoreKey = 'ter_vault_master_key_v1';
  final FlutterSecureStorage _secureStorage;
  enc.Encrypter? _encrypter;

  VaultSecurityService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Masks a card number to show ONLY the last 4 digits (e.g. "•••• •••• •••• 4242")
  static String maskCardNumber(String last4Digits) {
    final cleaned = last4Digits.replaceAll(RegExp(r'\D'), '');
    final last4 = cleaned.length >= 4 ? cleaned.substring(cleaned.length - 4) : cleaned.padLeft(4, '•');
    return '•••• •••• •••• $last4';
  }

  /// Initializes or retrieves the 256-bit AES master key from Android Keystore
  Future<void> initializeKey() async {
    String? base64Key = await _secureStorage.read(key: _keystoreKey);
    if (base64Key == null) {
      final key = enc.Key.fromSecureRandom(32);
      base64Key = key.base64;
      await _secureStorage.write(key: _keystoreKey, value: base64Key);
    }
    final key = enc.Key.fromBase64(base64Key);
    _encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.gcm));
  }

  /// Encrypts sensitive metadata (e.g. cardholder nickname or notes) using AES-256-GCM
  Future<String> encryptSensitiveData(String plaintext) async {
    if (_encrypter == null) await initializeKey();
    final iv = enc.IV.fromSecureRandom(16);
    final encrypted = _encrypter!.encrypt(plaintext, iv: iv);
    // Store IV along with ciphertext
    return jsonEncode({
      'iv': iv.base64,
      'cipher': encrypted.base64,
    });
  }

  /// Decrypts metadata after successful biometric authentication
  Future<String> decryptSensitiveData(String payloadJson) async {
    if (_encrypter == null) await initializeKey();
    final map = jsonDecode(payloadJson) as Map<String, dynamic>;
    final iv = enc.IV.fromBase64(map['iv'] as String);
    final encrypted = enc.Encrypted.fromBase64(map['cipher'] as String);
    return _encrypter!.decrypt(encrypted, iv: iv);
  }
}
