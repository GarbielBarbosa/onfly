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
  List<ExpenseByCategory> expenseByCategory = [];
  ValueNotifier<ViewState> state = ValueNotifier(ViewState.loading);

  final formKey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  TextEditingController startDateController =
      TextEditingController(text: '${DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now())} - ${DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now().add(const Duration(days: 7)))}');

  final formKeyPie = GlobalKey<FormState>();

  DateTime startDatePie = DateTime.now();
  DateTime endDatePie = DateTime.now().add(const Duration(days: 1));

  TextEditingController dateControllerPie = TextEditingController(text: DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now()));
  TextEditingController endDateControllerPie = TextEditingController(text: DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now().add(const Duration(days: 1))));

  void listenToExpensesStream() {
    ExpenseService.getAllExpensesStream().listen((List<Expense> expenses) {
      state.value = ViewState.loading;
      listExpenses = expenses;
      expenseByCategory = sumExpensesByCategory(expenses, startDatePie, endDatePie);
      int compareExpenseValues(ExpenseByCategory a, ExpenseByCategory b) {
        return b.value.compareTo(a.value);
      }

      expenseByCategory.sort(compareExpenseValues);
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

class ExpenseByCategory {
  final String category;
  double value;
  double percentage;

  ExpenseByCategory({required this.category, this.value = 0, this.percentage = 0});
}

List<ExpenseByCategory> sumExpensesByCategory(List<Expense> expenses, DateTime startDate, DateTime endDate) {
  Map<String, double> categoryMap = {};
  double totalValue = 0;

  // Calculating total value for each category
  for (var expense in expenses) {
    if (expense.date.isAfter(startDate.subtract(const Duration(days: 1))) && expense.date.isBefore(endDate.add(const Duration(days: 1)))) {
      categoryMap.update(expense.category, (value) => value + expense.value, ifAbsent: () => expense.value);
      totalValue += expense.value;
    }
  }

  // Calculating percentage for each category
  List<ExpenseByCategory> sumExpenses = categoryMap.entries.map((entry) {
    double percentage = (entry.value / totalValue) * 100;
    return ExpenseByCategory(category: entry.key, value: entry.value, percentage: percentage);
  }).toList();

  return sumExpenses;
}
