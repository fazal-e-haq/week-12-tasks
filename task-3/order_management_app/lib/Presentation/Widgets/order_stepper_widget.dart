import 'package:flutter/material.dart';
import 'package:order_management_app/Models/order_model.dart';

class OrderStepperWidget extends StatelessWidget {
  const OrderStepperWidget({super.key, required this.status});
  final OrderStatus status;
  int getStep() {
    switch (status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.processing:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.delivered:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: getStep(),
      controlsBuilder: (context, details) => SizedBox(),
      elevation: 5,
      steps: [
        Step(
          title: Text(
            'Pending',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: SizedBox(),
        ),
        Step(
          title: Text(
            'Processing',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: SizedBox(),
        ),
        Step(
          title: Text(
            'Shipped',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: SizedBox(),
        ),
        Step(
          title: Text(
            'Delivered',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: SizedBox(),
        ),
      ],
    );
  }
}
