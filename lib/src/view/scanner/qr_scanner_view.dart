import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';

import '../../constants/color_view_constants.dart';
import '../../utils/utils.dart';
import '../services/transfer/mobile_transfer_view.dart';

class QrScannerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QrScannerState();
}

class QrScannerState extends State<QrScannerView> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    }
    _controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this._controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        loggerNoStack.e('scanData : ' + scanData.code.toString());
        this._controller?.pauseCamera();
        this._controller?.stopCamera();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MobileTransferView(number: scanData.code.toString(),)));
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<bool> _onWillPop() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to close the scanner?'),
            actions: <Widget>[
              TextButton(
                child: Text('NO, EXIT'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: Text('OK, SAVE'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    if (result == null)
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && mounted) {
      _controller!.pauseCamera();
      _controller!.resumeCamera();
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorViewConstants.colorLightWhite,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            toolBarTransferWidget(context, 'QR Scanner', false),
            Expanded(
              child: _buildQrView(context),
            ),
          ],
        ),
      ),
    );
  }
}
