import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:we_chat/blocs/qr_bloc.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/resources/strings.dart';
import 'package:we_chat/widgets/leading_view.dart';
import 'package:we_chat/widgets/round_corner_button_view.dart';

class QrPage extends StatefulWidget {
  final bool isScannerMode;

  const QrPage({
    Key? key,
    this.isScannerMode = false,
  }) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => QrBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: colorPrimary,
          leading: LeadingView(
            text: "",
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "Qr Code",
          ),
        ),
        body: Selector(
          selector: (BuildContext context, QrBloc bloc) => bloc.isScannerMode,
          builder: (BuildContext context, bool mode, Widget? child) => mode
              ? QrScannerView(
                  onQrViewCreated: (controller) =>
                      _onQRViewCreated(context, controller),
                )
              : QrImageView(
                  isScannerMode: mode,
                ),
        ),
      ),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController? controller) {
    controller?.scannedDataStream.listen((scanData) {
      final bloc = Provider.of<QrBloc>(context, listen: false);

      /// create new contact with scan user
      bloc.onGetUserAndAddToContact(scanData.code ?? "").then((value) {
        _navigateToHomePage(context);
      });
    });
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
}

class QrImageView extends StatelessWidget {
  final bool isScannerMode;

  const QrImageView({
    Key? key,
    required this.isScannerMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QrBloc>(
      builder: (
        BuildContext context,
        QrBloc bloc,
        Widget? child,
      ) =>
          Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImage(
              data: bloc.user?.id ?? "0",
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(
              height: marginMedium3,
            ),
            const Text(
              "My QR Code",
              style: TextStyle(
                fontSize: textRegular3x,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: marginMedium3,
            ),
            Text(
              bloc.user?.id ?? "-",
              style: const TextStyle(
                fontSize: textRegular2x,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: marginMedium3,
            ),
            RoundCornerButtonView(
              text: scanQrCode,
              onTap: () {
                bloc.onTapScanner(isScannerMode);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QrScannerView extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final Function onQrViewCreated;

  QrScannerView({
    Key? key,
    required this.onQrViewCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      overlay: QrScannerOverlayShape(),
      onQRViewCreated: (qrViewController) => onQrViewCreated(qrViewController),
    );
  }
}
