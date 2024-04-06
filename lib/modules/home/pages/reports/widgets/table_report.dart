import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:onfly/modules/home/pages/reports/reports_controller.dart';
import 'package:onfly/shared/utils/currency.dart';
import 'package:onfly/shared/widgets/custom_form_field.dart';

class TableReport extends StatelessWidget {
  const TableReport({
    super.key,
    required this.controller,
  });

  final ReportsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Relatorio',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Form(
          key: controller.formKeyTable,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: controller.dateControllerTable,
                      label: 'Data inicial',
                      hintText: 'Data inicial',
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
                        if (date != null && date.isBefore(controller.endDateTable)) {
                          controller.startDateTable = date;
                          controller.dateControllerTable.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.startDateTable);
                        } else if (date != null) {
                          controller.startDateTable = date;
                          controller.endDateTable = date.add(const Duration(days: 1, seconds: 500));
                          controller.endDateControllerTable.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDateTable);
                          controller.dateControllerTable.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.startDateTable);
                        }
                        controller.listenToExpensesStream();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomFormField(
                      controller: controller.endDateControllerTable,
                      label: 'Data Final',
                      hintText: 'Data Final',
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
                        if (date != null && date.isAfter(controller.startDateTable)) {
                          controller.endDateTable = date;
                          controller.endDateControllerTable.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDateTable);
                        } else if (date != null) {
                          controller.endDateTable = date;
                          controller.startDateTable = date.subtract(const Duration(days: 1));
                          controller.dateControllerTable.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.startDateTable);
                          controller.endDateControllerTable.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDateTable);
                        }
                        controller.listenToExpensesStream();
                      },
                    ),
                  ),
                ],
              ),
              CustomFormField(
                controller: controller.categoryController,
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
                onEditingComplete: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  controller.listenToExpensesStream();
                },
              ),
              const SizedBox(height: 10),
              CustomFormField(
                controller: controller.descriptionController,
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
                onEditingComplete: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  controller.listenToExpensesStream();
                },
              ),
            ],
          ),
        ),
        if (controller.filteredExpenses.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Categoria',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Descrição',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Data',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Valor',
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Divider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.filteredExpenses.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(); // Separador entre os itens da lista
            },
            itemBuilder: (context, index) {
              final expense = controller.filteredExpenses[index];
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      expense.category,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      expense.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      DateFormat('dd/MM/yyyy', 'pt_BR').format(expense.date),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '- ${Currency().formatMoney(value: expense.value, currency: expense.currency)}',
                      style: const TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        ]
      ],
    );
  }
}
