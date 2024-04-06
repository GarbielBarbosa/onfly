import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onfly/modules/home/pages/reports/reports_controller.dart';
import 'package:onfly/modules/home/pages/reports/widgets/bar_char.dart';
import 'package:onfly/modules/home/pages/reports/widgets/pie_chart.dart';
import 'package:onfly/modules/home/pages/reports/widgets/table_report.dart';
import 'package:onfly/shared/enuns.dart';
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
                      TableReport(controller: controller),
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
