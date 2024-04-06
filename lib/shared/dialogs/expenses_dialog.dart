import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onfly/shared/models/expenses.dart';
import 'package:onfly/shared/utils/currency.dart';
import 'package:onfly/shared/widgets/custom_form_field.dart';

class ExpensesDialog {
  final BuildContext context;
  ExpensesDialog({
    required this.context,
  });

  bool isDialogOpen = false;

  DateTime date = DateTime.now();
  Future<ReturnExpenseDialog?> showExpensesDialog(Expense? expense) async {
    final List<AllCurrencies> listCurrencies = Currency().getAllCurrencies();

    bool onDone = false;
    bool onDelete = false;
    bool onCreate = false;

    TextEditingController dateController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    AllCurrencies currentSelectedValue = Currency().getAllCurrencies().first;
    final formKey = GlobalKey<FormState>();

    if (expense != null) {
      categoryController.text = expense.category;
      descriptionController.text = expense.description;
      valueController.text = expense.value.toString().replaceAll('.', ',');
      dateController.text = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').format(expense.date);
    } else {
      dateController.text = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').format(DateTime.now());
      dateController.text = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').format(DateTime.now());
    }

    if (!isDialogOpen) {
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (c, setState) {
            return AlertDialog(
              title: const Text('Nova despesa'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomFormField(
                            controller: categoryController,
                            key: const Key('category'),
                            textInputAction: TextInputAction.next,
                            label: 'Categoria',
                            hintText: 'Categoria',
                            keyboardType: TextInputType.name,
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            controller: descriptionController,
                            key: const Key('description'),
                            textInputAction: TextInputAction.next,
                            label: 'Descrição',
                            hintText: 'Descrição',
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                          ),
                          DropdownSearch<AllCurrencies>(
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              searchDelay: Duration(seconds: 0),
                            ),
                            items: listCurrencies,
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            onChanged: (AllCurrencies? data) {
                              if (data != null) {
                                currentSelectedValue = data;
                              }
                            },
                            selectedItem: listCurrencies.first,
                            itemAsString: (AllCurrencies currency) => currency.name,
                          ),
                          CustomFormField(
                            controller: valueController,
                            key: const Key('value'),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                            label: 'Valor',
                            hintText: 'Valor',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r"[0-9,]")),
                            ],
                            textInputAction: TextInputAction.next,
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            controller: dateController,
                            label: 'Data da despesa',
                            hintText: 'Data da despesa',
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());
                              date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                this.date = date;
                              }
                              dateController.text = date != null ? DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').format(date) : '';
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                if (expense != null)
                  TextButton(
                    child: const Text(
                      'Apagar',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      onDelete = true;
                      isDialogOpen = false;
                      Navigator.of(context).pop();
                    },
                  ),
                if (expense != null)
                  TextButton(
                    child: const Text('Atualizar'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onDone = true;
                        isDialogOpen = false;
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                if (expense == null)
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onCreate = true;
                        isDialogOpen = false;
                        Navigator.of(context).pop();
                      }
                    },
                  ),
              ],
            );
          });
        },
      ).then((value) => {
            isDialogOpen = false,
          });

      if (onDone && expense != null) {
        return ReturnExpenseDialog(
          type: 'update',
          expense: Expense(
            id: expense.id,
            userId: expense.userId,
            category: categoryController.text,
            description: descriptionController.text,
            value: NumberFormat('', 'pt_Br').parse(valueController.text).toDouble(),
            currency: currentSelectedValue.code,
            date: date,
          ),
        );
      } else if (onDelete && expense != null) {
        return ReturnExpenseDialog(
          type: 'delete',
          expense: Expense(
            userId: expense.userId,
            id: expense.id,
            category: categoryController.text,
            description: descriptionController.text,
            value: NumberFormat('', 'pt_Br').parse(valueController.text).toDouble(),
            currency: currentSelectedValue.code,
            date: date,
          ),
        );
      } else if (onCreate) {
        return ReturnExpenseDialog(
          type: 'create',
          expense: Expense(
            category: categoryController.text,
            description: descriptionController.text,
            value: NumberFormat('', 'pt_Br').parse(valueController.text).toDouble(),
            currency: currentSelectedValue.code,
            date: date,
          ),
        );
      }
    }
    return null;
  }

  void closeLoading() {
    if (isDialogOpen) {
      Navigator.of(context).pop();
      isDialogOpen = false;
    }
  }
}

class ReturnExpenseDialog {
  final String type;
  final Expense? expense;

  ReturnExpenseDialog({
    required this.type,
    this.expense,
  });
}
