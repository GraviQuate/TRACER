import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:tracer/models/transaction.dart';
import 'package:tracer/utils/env.dart';

Future<Transaction> scanForm(Uint8List imageBytes, {http.Client ? client}) async {
  final httpClient = client ?? http.Client();
  final String base64Image = base64Encode(imageBytes);
  Transaction transaction = Transaction();

  final response = await httpClient.post(
    Uri.parse('https://doc-ai-processor-724917125047.asia-southeast3.run.app'),
    headers: {
      "Content-Type": "application/json",
      "X-Tracer-Key": Env.docAiKey,
    },
    body: jsonEncode({"imageBase64": base64Image}),
  );

  try {
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      transaction.stuFirstName = result['data']['First name'];
      transaction.stuMiddleInitial = result['data']['Middle initial'];
      transaction.stuLastName = result['data']['Last name'];
      transaction.stuNum = result['data']['Student No'];
      transaction.receiptNum = result['data']['Receipt No'];
      transaction.transactMonth = result['data']['Month'];
      transaction.transactDay = result['data']['Day'];
      transaction.transactYear = result['data']['Year'];
      transaction.transactAmount = result['data']['Amount (Php)'];
      transaction.transactPurpose = result['data']['Purpose of the transaction'];
      transaction.foFirstName = result['data']['FO First name'];
      transaction.foMiddleInitial = result['data']['FO Middle initial'];
      transaction.foLastName = result['data']['FO Last name'];
    }
    else {
      throw Exception('Server returned ${response.statusCode}: ${response.body}');
    }
  }
  finally {
    if (client == null) httpClient.close();
  }

  return transaction;
}
