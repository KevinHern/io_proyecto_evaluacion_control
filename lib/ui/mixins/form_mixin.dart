// Basic Imports
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../components/dialogs.dart';

// Models
import '../../data/models/operation_result.dart';
import '../models/subscreen_managerUI.dart';

class FormMixin {
  void execute(
      {required BuildContext context,
      required Future<OperationResult> useCasesFunction,
      required Function updateUI}) async {
    // Showing Loader
    final ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 1, msg: "Enviando datos...");

    // Sending Data
    final OperationResult result = await useCasesFunction;

    // Closing Progress Dialog
    if (pd.isOpen()) {
      pd.close();
    }

    // Showing message to the user
    await FormDialogs.informativeDialog(
        context: context, message: result.message!);

    // Update UI
    if (result.success) {
      updateUI();
    }
  }
}
