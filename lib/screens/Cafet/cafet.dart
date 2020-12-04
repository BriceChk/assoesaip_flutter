import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sumup/sumup.dart';

final String classicFont = "Nunito";
final Color cardColor = white;
final Color hearderColor = skyBlueCrayola1;
final Color shadowColor = navyBlue;
final Color fontColor = Colors.black;
final Color titleColor = navyBlue;
final Color splashColor = skyBlueCrayola1;

final BorderRadius borderHeader = BorderRadius.only(
  bottomLeft: Radius.circular(25),
  bottomRight: Radius.circular(25),
);

var formatDate = DateFormat('EEEE').format(DateTime.now());

class CafetCategories extends StatefulWidget {
  @override
  _CafetCategoriesState createState() => _CafetCategoriesState();
}

class _CafetCategoriesState extends State<CafetCategories> {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );

  @override
  Widget build(BuildContext context) {
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        //* We wrap our header inside the sliverAppBar with somme properties
        SliverAppBar(
          shape: roundedBorder,
          centerTitle: true,
          actions: [
            Header(),
          ],
          toolbarHeight: 130,
          pinned: true,
          backgroundColor: hearderColor,
        )
      ],
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: hearderColor,
        borderRadius: borderHeader,
      ),

      //* In order to have a padding horizontaly
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        //* Column in order to have 2 differents text widget one under the others
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Menu du " + '$formatDate',
              style: TextStyle(
                fontSize: 30,
                color: fontColor,
                fontFamily: classicFont,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

final String affiliateKey = 'your-affiliate-key';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Sumup plugin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async {
                var init = await Sumup.init(affiliateKey);
                print(init);
              },
              child: Text('Init'),
            ),
            FlatButton(
              onPressed: () async {
                var login = await Sumup.login();
                print(login);
              },
              child: Text('Login'),
            ),
            FlatButton(
              onPressed: () async {
                var settings = await Sumup.openSettings();
                print(settings);
              },
              child: Text('Open settings'),
            ),
            FlatButton(
              onPressed: () async {
                var payment = SumupPayment(
                  title: 'Test payment',
                  total: 1.2,
                  currency: 'EUR',
                  foreignTransactionId: '',
                  saleItemsCount: 0,
                  skipSuccessScreen: false,
                  tip: .0,
                );

                var request = SumupPaymentRequest(payment, info: {
                  'AccountId': 'taxi0334',
                  'From': 'Paris',
                  'To': 'Berlin',
                });

                var checkout = await Sumup.checkout(request);
                print(checkout);
              },
              child: Text('Checkout'),
            ),
            FlatButton(
              onPressed: () async {
                var isLogged = await Sumup.isLoggedIn;
                print(isLogged);
              },
              child: Text('Is logged in'),
            ),
            FlatButton(
              onPressed: () async {
                var isInProgress = await Sumup.isCheckoutInProgress;
                print(isInProgress);
              },
              child: Text('Is checkout in progress'),
            ),
            FlatButton(
              onPressed: () async {
                var merchant = await Sumup.merchant;
                print(merchant);
              },
              child: Text('Current merchant'),
            ),
            FlatButton(
              onPressed: () async {
                var logout = await Sumup.logout();
                print(logout);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    ),
  );
}
