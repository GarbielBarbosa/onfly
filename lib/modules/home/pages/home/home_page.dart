import 'package:flutter/material.dart';
import 'package:onfly/modules/home/pages/home/home_controller.dart';
import 'package:onfly/modules/home/pages/home/widgets/expense_card.dart';
import 'package:onfly/shared/enuns.dart';
import 'package:onfly/shared/utils/currency.dart';
import 'package:onfly/shared/widgets/custom_app_bar.dart';
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
      appBar: const CustomAppBar(title: 'Despesas'),
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
                    return ExpenseCard(
                      expense: expense,
                      onEdit: () {
                        controller.showDialogExpenses(expense);
                      },
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
