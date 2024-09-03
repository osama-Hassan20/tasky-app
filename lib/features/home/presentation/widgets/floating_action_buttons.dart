import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/features/task_details/presentation/task_details_view.dart';

import '../../../add_task/presentation/add_task_view.dart';
import '../manager/home_cubit/cubit.dart';

class FloatingActionButtons extends StatefulWidget {
  const FloatingActionButtons({super.key, required this.cubit});
  final HomeCubit cubit;
  @override
  State<FloatingActionButtons> createState() => _FloatingActionButtonsState();
}

class _FloatingActionButtonsState extends State<FloatingActionButtons> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'qr',
          backgroundColor: const Color(0xffEBE5FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('QR Code Scanner'),
                content: SizedBox(
                  width: 300,
                  height: 300,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (controller) {
                      this.controller = controller;
                      controller.scannedDataStream.listen((event) {
                        setState(() {
                          result = event;
                          print('result!.code   =   ${result!.code}');
                          controller.stopCamera();
                          Navigator.pop(context);
                          for (int index = 0;
                              index < widget.cubit.tasksModel.length;
                              index++) {
                            if (widget.cubit.tasksModel[index].id ==
                                result!.code) {
                              navigateTo(
                                  context,
                                  TaskDetailsView(
                                      taskModel:
                                          widget.cubit.tasksModel[index]));
                            }
                          }
                        });
                      });
                    },
                  ),
                ),
              ),
            );
          },
          child: const Icon(
            Icons.qr_code,
            color: Color(0xff5F33E1),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        FloatingActionButton(
          heroTag: 'add',
          backgroundColor: const Color(0xff5F33E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          onPressed: () {
            navigateTo(context, AddTaskView());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
