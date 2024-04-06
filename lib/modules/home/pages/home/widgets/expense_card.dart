import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onfly/shared/models/expenses.dart';
import 'package:onfly/shared/theme/colors.dart';
import 'package:onfly/shared/utils/currency.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onEdit,
  });

  final Expense expense;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        child: Container(
          color: DefaultColors().background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.filled(
                    visualDensity: VisualDensity.comfortable,
                    onPressed: () {
                      onEdit();
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                    )),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${expense.category}: ${expense.description}'),
                      Text(
                        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br').format(expense.date),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 125, 130, 136),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    '- ${Currency().formatMoney(value: expense.value, currency: expense.currency)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.right, // Adicionando alinhamento à direita
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
