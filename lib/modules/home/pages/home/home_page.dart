import 'package:flutter/material.dart';
import 'package:onfly/modules/home/pages/home/home_controller.dart';
import 'package:onfly/shared/enuns.dart';
import 'package:onfly/shared/utils/currency.dart';
import 'package:onfly/shared/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  @override
  void initState() {
    controller = HomeController(context: context);
    controller.listenToExpensesStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Despesas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.showDialogExpenses(null);
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: controller.state,
              builder: (context, value, child) {
                if (value == ViewState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = controller.listExpenses[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(expense.category),
                              Text(expense.description),
                            ],
                          ),
                          Text(
                            Currency().formatMoney(value: expense.value, currency: expense.currency),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.showDialogExpenses(expense);
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.deleteExpense(expense.id ?? '');
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
