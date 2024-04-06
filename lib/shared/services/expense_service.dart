import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:onfly/shared/models/expenses.dart';

class ExpenseService {
  static CollectionReference expenses = FirebaseFirestore.instance.collection('expenses');

  static Future<void> addExpenses(Expense expense) {
    Map<String, dynamic> expenseMap = expense.toMap();
    expenseMap.remove('id');
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    expenseMap.update('userId', (value) => uid);

    return expenses.add(expenseMap);
  }

  static Future<void> updateExpenses(Expense expense) {
    Map<String, dynamic> expenseMap = expense.toMap();
    final id = expenseMap.remove('id');

    return expenses.doc(id).update(expenseMap);
  }

  static void deleteExpenses(String id) {
    expenses.doc(id).delete().then(
      (value) {
        if (kDebugMode) {
          print("expenses delete");
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print("Failed to delete: $error");
        }
      },
    );
  }

  static Stream<List<Expense>> getAllExpensesStream() {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;
      return FirebaseFirestore.instance.collection('expenses').where('userId', isEqualTo: uid).snapshots().map((querySnapshot) {
        List<Expense> expenses = querySnapshot.docs.map((doc) => Expense.fromMap({...doc.data(), 'id': doc.id})).toList();

        expenses.sort((a, b) => b.date.compareTo(a.date));

        return expenses;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Failed to get expenses stream: $error');
      }
      rethrow;
    }
  }
}
