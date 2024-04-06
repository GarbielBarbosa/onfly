import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onfly/shared/dialogs/alert_dialog.dart';
import 'package:onfly/shared/dialogs/expenses_dialog.dart';
import 'package:onfly/shared/dialogs/loading.dart';
import 'package:onfly/shared/enuns.dart';
import 'package:onfly/shared/models/expenses.dart';
import 'package:onfly/shared/services/expense_service.dart';

class ReportsController {
  final BuildContext context;
  final Loading loading;
  final SimpleAlertDialog alert;

  final ExpensesDialog expensesDialog;
  ReportsController({required this.context})
      : loading = Loading(context: context),
        alert = SimpleAlertDialog(context: context),
        expensesDialog = ExpensesDialog(context: context);

  List<Expense> listExpenses = [];

  List<ExpenseByDay> listExpenseByDay = [];
  ValueNotifier<ViewState> state = ValueNotifier(ViewState.loading);

  final formKey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  TextEditingController startDateController =
      TextEditingController(text: '${DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now())} - ${DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now().add(const Duration(days: 7)))}');

  void listenToExpensesStream() {
    ExpenseService.getAllExpensesStream().listen((List<Expense> expenses) {
      state.value = ViewState.loading;
      listExpenses = expenses;

      listExpenseByDay = sumExpensesByDay(expenses, startDate, endDate);

      state.value = ViewState.success;
    }, onError: (error) {
      state.value = ViewState.error;
    });
  }

  List<ExpenseByDay> sumExpensesByDay(List<Expense> expenses, DateTime startDate, DateTime endDate) {
    List<ExpenseByDay> sumExpenses = [];
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
      sumExpenses.add(ExpenseByDay(date: currentDate, value: 0));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    for (var expense in expenses) {
      if (expense.date.isAfter(startDate.subtract(const Duration(days: 1))) && expense.date.isBefore(endDate.add(const Duration(days: 1)))) {
        var index = sumExpenses.indexWhere((element) => element.date.year == expense.date.year && element.date.month == expense.date.month && element.date.day == expense.date.day);
        if (index != -1) {
          sumExpenses[index].value += expense.value;
        }
      }
    }

    return sumExpenses;
  }
}

class ExpenseByDay {
  DateTime date;
  double value;

  ExpenseByDay({required this.date, required this.value});
}
