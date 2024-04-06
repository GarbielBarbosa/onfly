import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:onfly/shared/models/expenses.dart';

class ExpenseService {
  static CollectionReference expenses = FirebaseFirestore.instance.collection('expenses');
  static Stream collectionStreamExpenses = FirebaseFirestore.instance.collection('expenses').snapshots();

  static Future<void> addExpenses(Expense expense) {
    return expenses.add(expense.toMap());
  }

  static getAllExpenses() async {
    List<Expense> expensesList = [];
    try {
      QuerySnapshot querySnapshot = await expenses.get();
      for (var doc in querySnapshot.docs) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          expensesList.add(Expense.fromMap(data));
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Failed to get expenses: $error');
      }
    }
    return expensesList;
  }

  static void updateExpenses(Expense expense) {
    Map<String, dynamic> expenseMap = expense.toMap();
    final id = expenseMap.remove('id');

    expenses.doc(id).update(expenseMap).then(
      (value) {
        if (kDebugMode) {
          print("expenses Updated");
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print("Failed to update expenses: $error");
        }
      },
    );
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
      return FirebaseFirestore.instance.collection('expenses').orderBy('date', descending: true).snapshots().map(
            (querySnapshot) => querySnapshot.docs.map(
              (doc) {
                Map<String, dynamic> data = doc.data();
                data['id'] = doc.id;
                return Expense.fromMap(data);
              },
            ).toList(),
          );
    } catch (error) {
      if (kDebugMode) {
        print('Failed to get expenses stream: $error');
      }
      rethrow;
    }
  }
}
