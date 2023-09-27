import 'package:flutter/material.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/main.dart';

class StatusContainer extends StatelessWidget {
  final String status;
  const StatusContainer({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: greyColor!.withOpacity(0.45),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          getIcon(),
          const SizedBox(
            width: 6.0,
          ),
          Text(
            status,
            style: context.customStyle(
              size: 12.0,
              color: getColor(),
            ),
          )
        ],
      ),
    );
  }

  Icon getIcon() {
    IconData data;
    switch (status) {
      case 'pending':
        data = Icons.history;
        break;
      case 'in-progress':
        data = Icons.refresh;
        break;
      case 'cancelled':
        data = Icons.cancel_outlined;
        break;
      case 'completed':
        data = Icons.done_outline;
        break;
      default:
        data = Icons.refresh;
        break;
    }
    return Icon(
      data,
      color: getColor(),
      size: 16.0,
    );
  }

  Color getColor() {
    Color color;
    switch (status) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'in-progress':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      case 'completed':
        color = AppConstants.primaryColor;
        break;
      case 'loading':
        color = Colors.blue;
        break;
      default:
        color = Colors.blue;
        break;
    }
    return color;
  }
}
