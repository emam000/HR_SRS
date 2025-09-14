import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/add_employee_view.dart';

class AddEmployeeButtonWidget extends StatelessWidget {
  const AddEmployeeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddEmployeeView()));
      },
      tooltip: 'إضافة موظف',
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
