import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/utils/common_text_style.dart';
import 'package:payment_management_app/utils/widgets/animations/custom_page_transition_switcher.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanReceiptScreen extends StatefulWidget {
  const ScanReceiptScreen({super.key});

  @override
  State<ScanReceiptScreen> createState() => _ScanReceiptScreenState();
}

class _ScanReceiptScreenState extends State<ScanReceiptScreen> {


  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;


  ///-----init method
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  ///-----dispose method
  @override
  void dispose() {
    super.dispose();
    qrController?.dispose();
  }

  ///-----build method
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomPageTransitionSwitcher(
        transitionType: SharedAxisTransitionType.horizontal,
        transitionDuration: const Duration(milliseconds: 500),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Scan QR Code",style: KTextStyle.txtBold20,),
              SizedBox(height: 50.h,),
              Container(
                height: 400.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: QRView(
                  key: qrKey,
                  cameraFacing: CameraFacing.back,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                  ),
                  onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      log("-----------------scanData.code?.isNotEmpty ${scanData.code?.isNotEmpty}");
      if(scanData.code?.isNotEmpty ?? false){

        ///-----when Scan data getting not null then stop the qr scanner camera
        // qrController?.stopCamera();

        ///----convert String Json to Map
        log("scanData.code.toString() ${scanData.code.toString()}");
      }
    });
  }

  ///----checking the permission for qr code camera permission is given or not
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      log("Camera Permission is not given");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}