import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:onfly/modules/home/pages/home/widgets/expense_card.dart';
import 'package:onfly/modules/home/pages/reports/reports_controller.dart';
import 'package:onfly/modules/home/pages/reports/widgets/bar_char.dart';
import 'package:onfly/modules/home/pages/reports/widgets/pie_chart.dart';
import 'package:onfly/shared/enuns.dart';
import 'package:onfly/shared/theme/colors.dart';
import 'package:onfly/shared/utils/currency.dart';
import 'package:onfly/shared/widgets/custom_app_bar.dart';
import 'package:onfly/shared/widgets/custom_drawer.dart';
import 'package:onfly/shared/widgets/custom_form_field.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReportsController controller;
  @override
  void initState() {
    controller = ReportsController(context: context);
    controller.listenToExpensesStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(title: 'Relatórios'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: controller.state,
              builder: (context, value, child) {
                if (value == ViewState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gráfico semanal',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Form(
                        key: controller.formKey,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: CustomFormField(
                                controller: controller.startDateController,
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
                                  if (date != null) {
                                    controller.startDate = date;
                                    controller.endDate = date.add(
                                      const Duration(days: 7),
                                    );
                                  }
                                  controller.startDateController.text =
                                      date != null ? '${DateFormat('dd/MM/yyyy', 'pt_BR').format(date)} - ${DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDate)}' : '';
                                  controller.listenToExpensesStream();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      BarChartSample1(
                        listExpenseByDay: controller.listExpenseByDay,
                      ),
                      const Text(
                        'Gráfico Categoria',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Form(
                        key: controller.formKeyPie,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: CustomFormField(
                                controller: controller.dateControllerPie,
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
                                  if (date != null && date.isBefore(controller.endDatePie)) {
                                    controller.startDatePie = date;
                                    controller.dateControllerPie.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.startDatePie);
                                  } else if (date != null) {
                                    controller.startDatePie = date;
                                    controller.endDatePie = date.add(const Duration(days: 1, seconds: 500));
                                    controller.endDateControllerPie.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDatePie);
                                    controller.dateControllerPie.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.startDatePie);
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
                                controller: controller.endDateControllerPie,
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
                                  if (date != null && date.isAfter(controller.startDatePie)) {
                                    controller.endDatePie = date;
                                    controller.endDateControllerPie.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDatePie);
                                  } else if (date != null) {
                                    controller.endDatePie = date;
                                    controller.startDatePie = date.subtract(const Duration(days: 1));
                                    controller.dateControllerPie.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.startDatePie);
                                    controller.endDateControllerPie.text = DateFormat('dd/MM/yyyy', 'pt_BR').format(controller.endDatePie);
                                  }
                                  controller.listenToExpensesStream();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.expenseByCategory.isNotEmpty)
                        PieChartCategory(
                          expenseByCategory: controller.expenseByCategory,
                        ),
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
