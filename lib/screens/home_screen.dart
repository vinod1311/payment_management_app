import 'package:flutter/material.dart';
import 'package:payment_management_app/controllers/payment/payment_controller.dart';
import 'package:payment_management_app/screens/dashboard_screen.dart';
import 'package:payment_management_app/screens/payment_screen.dart';
import 'package:payment_management_app/screens/scan_receipt_screen.dart';
import 'package:payment_management_app/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import '../utils/common_text_style.dart';
import 'add_payment_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{


  late PageController _pageController;

  PaymentController paymentControllerWatch = PaymentController();

  ///---------init method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  ///---------dispose
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ///---------build method
  @override
  Widget build(BuildContext context) {
    paymentControllerWatch = context.watch<PaymentController>();

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        body:  PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            paymentControllerWatch.setSelectedBottomNavigationIndex(index);
          },
          children: <Widget>[
            const DashboardScreen(),
            const ScanReceiptScreen(),
            PaymentScreen(amount: "2000",userModel: paymentControllerWatch.userList[2],note: "added from home"),
            const SettingsScreen(),
          ],

        ),
        bottomNavigationBar: bottomNavigationBar(context,paymentControllerWatch,_pageController),
      ),
    );
  }
}

///----bottom Navigation
Theme bottomNavigationBar(BuildContext context,PaymentController paymentControllerWatch,PageController pageController){
  return Theme(
    data: Theme.of(context).copyWith(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    ),
    child: BottomNavigationBar(
      items: paymentControllerWatch.navItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon']),
          label: item['label'],
        );
      }).toList(),
      currentIndex: paymentControllerWatch.selectedBottomNavigationIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).disabledColor,
      backgroundColor: Theme.of(context).disabledColor.withOpacity(0.1),
      elevation: 0.0,
      showUnselectedLabels: true,
      enableFeedback: false,
      selectedLabelStyle: KTextStyle.txtRegular11,
      unselectedLabelStyle: KTextStyle.txtRegular10,
      onTap: (int index){
        paymentControllerWatch.setSelectedBottomNavigationIndex(index);
        pageController.jumpToPage(index);
      },
    ),
  );
}


