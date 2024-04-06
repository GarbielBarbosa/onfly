// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onfly/shared/models/expenses.dart';
import 'package:onfly/shared/utils/currency.dart';

class ExpensesDialog {
  final BuildContext context;
  ExpensesDialog({
    required this.context,
  });

  bool isDialogOpen = false;

  DateTime date = DateTime.now();
  Future<Expense?> showExpensesDialog(Expense? expense) async {
    final List<AllCurrencies> listCurrencies = Currency().getAllCurrencies();
    bool onDone = false;
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
                          TextFormField(
                            controller: categoryController,
                            key: const Key('category'),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Categoria',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: descriptionController,
                            key: const Key('description'),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Descrição',
                            ),
                            validator: (e) {
                              if (e == null || e.isEmpty) {
                                return 'Campo obrigatorio';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: valueController,
                            key: const Key('value'),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r"[0-9,]")),
                            ],
                            decoration: const InputDecoration(
                              hintText: 'Valor',
                            ),
                            textInputAction: TextInputAction.next,
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
                          TextFormField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              hintText: 'Data da despesa',
                            ),
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
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    onDone = true;
                    isDialogOpen = false;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        },
      ).then((value) => {
            isDialogOpen = false,
          });
      if (onDone) {
        if (expense != null) {
          return Expense(
            id: expense.id,
            category: categoryController.text,
            description: descriptionController.text,
            value: NumberFormat('', 'pt_Br').parse(valueController.text).toDouble(),
            currency: currentSelectedValue.code,
            date: date,
          );
        } else {
          return Expense(
            category: categoryController.text,
            description: descriptionController.text,
            value: NumberFormat('', 'pt_Br').parse(valueController.text).toDouble(),
            currency: currentSelectedValue.code,
            date: date,
          );
        }
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
