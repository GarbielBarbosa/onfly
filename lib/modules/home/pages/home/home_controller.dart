import 'package:flutter/material.dart';
import 'package:onfly/shared/models/expenses.dart';
import 'package:onfly/shared/dialogs/alert_dialog.dart';
import 'package:onfly/shared/dialogs/expenses_dialog.dart';
import 'package:onfly/shared/dialogs/loading.dart';
import 'package:onfly/shared/enuns.dart';
import 'package:onfly/shared/services/expense_service.dart';

class HomeController {
  final BuildContext context;
  final Loading loading;
  final SimpleAlertDialog alert;

  final ExpensesDialog expensesDialog;
  HomeController({required this.context})
      : loading = Loading(context: context),
        alert = SimpleAlertDialog(context: context),
        expensesDialog = ExpensesDialog(context: context);

  List<Expense> listExpenses = [];
  ValueNotifier<ViewState> state = ValueNotifier(ViewState.loading);

  showDialogExpenses(Expense? e) async {
    try {
      final r = await expensesDialog.showExpensesDialog(e);
      if (r?.expense != null && r?.type == 'create') {
        addExpenses(r!.expense!);
      } else if (r?.expense != null && r?.type == 'update') {
        updateExpenses(r!.expense!);
      } else if (r?.expense != null && r?.type == 'delete') {
        deleteExpense(r!.expense!.id ?? '');
      }
    } catch (e) {}
  }

  Future<void> addExpenses(Expense expense) async {
    try {
      ExpenseService.addExpenses(expense);
    } catch (e) {
      print("Failed to add Expenses: $e");
    }
  }

  Future<void> updateExpenses(Expense expense) async {
    try {
      ExpenseService.updateExpenses(expense);
    } catch (e) {
      print("Failed to update Expenses: $e");
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      ExpenseService.deleteExpenses(id);
    } catch (e) {
      print("Failed to add Expenses: $e");
    }
  }

  void listenToExpensesStream() {
    ExpenseService.getAllExpensesStream().listen((List<Expense> expenses) {
      state.value = ViewState.loading;
      listExpenses = expenses;
      state.value = ViewState.sucess;
    }, onError: (error) {
      state.value = ViewState.error;
    });
  }
}
