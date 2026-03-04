import 'package:_app/database/admin_database/add_vedio_database.dart';
import 'package:flutter/material.dart';

class AddVideosController {
  bool fieldsSelected = false;
  bool savedStatus = false;
  bool loading = true;

  Future<void> loadStatus(VoidCallback refresh) async {
    savedStatus = await AdminVideosDB.getFieldsStatus();

    // Restore selection if saved before
    fieldsSelected = savedStatus;

    loading = false;
    refresh();
  }

  Future<void> saveFields(BuildContext context) async {
    await AdminVideosDB.saveFields(true);

    fieldsSelected = true;
    savedStatus = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Fields saved successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  Future<void> deleteFields(BuildContext context) async {
    await AdminVideosDB.deleteFields();

    fieldsSelected = false;
    savedStatus = false;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Fields deleted!"),
        backgroundColor: Colors.red,
      ),
    );

    Navigator.pop(context);
  }
}
