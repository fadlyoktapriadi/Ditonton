import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await _createClient();
  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _createClient();
  }

  static Future<http.Client> _createClient() async {
    final context = SecurityContext(withTrustedRoots: false);
    final certificate = await rootBundle.load('certificates/certificates.pem');
    context.setTrustedCertificatesBytes(certificate.buffer.asUint8List());

    final httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return IOClient(httpClient);
  }
}
