import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onfly/modules/home/pages/reports/reports_controller.dart';
import 'package:onfly/modules/home/pages/reports/widgets/bar_char.dart';
import 'package:onfly/modules/home/pages/reports/widgets/pie_chart.dart';
import 'package:onfly/shared/enuns.dart';
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
                        'Grafico semanal',
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
                      PieChartSample2(),
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
