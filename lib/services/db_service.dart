import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/transaction.dart';
import '../utils/env.dart';

class DbService {
  DbService._internal();

  late final SupabaseClient _client;

  static Future<DbService> initialize() async {
    await Supabase.initialize(
      anonKey: Env.supabaseKey,
      url: Env.supabaseUrl,
    );

    final service = DbService._internal();
    service._client = Supabase.instance.client;

    return service;
  }

  Future<Transaction> insertTransaction(Transaction transaction) async {
    try {
      final response = await _client
      .from('transaction')
      .insert(transaction.toJson())
      .select()
      .single();

      return Transaction.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        throw DuplicateReceiptException();
      }

      throw Exception("Database Error: ${e.message}");
    }
  }
}


// Custom exceptions
class DuplicateReceiptException implements Exception {}
