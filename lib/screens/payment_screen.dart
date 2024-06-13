import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/controllers/payment/payment_controller.dart';
import 'package:payment_management_app/repository/common/model/user_model.dart';
import 'package:payment_management_app/repository/payment/model/payment_model.dart';
import 'package:payment_management_app/screens/home_screen.dart';
import 'package:payment_management_app/utils/common_text_style.dart';
import 'package:provider/provider.dart';
import '../utils/common.dart';
import '../utils/widgets/common_cache_network_image.dart';
import '../utils/widgets/animations/fade_through_page_route.dart';

class PaymentScreen extends StatefulWidget {
  final UserModel? userModel;
  final String? note;
  final String amount;
  const PaymentScreen({super.key,this.userModel,required this.amount,this.note});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  PaymentController paymentControllerWatch = PaymentController();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    timer?.cancel();
    timer = Timer(
      const Duration(seconds: 3),
          () async{
        handlePayment(context, paymentControllerWatch);
      },
    );


  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    paymentControllerWatch = context.watch<PaymentController>();
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 55.r,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(10.h),
                      child: CommonCachedNetworkImage(
                        boxFit: BoxFit.contain,
                        imgUrl: widget.userModel?.avtarUrl ?? "https://avatar.iran.liara.run/public/98",
                        shimmerRadius: 55.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            Column(
              children: [
                Text(
                  'Paying',
                  style: KTextStyle.txtSemiBold14.copyWith(color: Colors.white),
                ),
                Text(
                  '${widget.userModel?.firstName} ${widget.userModel?.lastName}',
                  style: KTextStyle.txtSemiBold18.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20.h),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)
                    )
                  ),
                    onPressed: (){
                      timer?.cancel();
                      Navigator.pushReplacement(context, FadeThroughPageRoute(page: const HomeScreen()));
                    },
                    child: Text('Cancel Payment',style: KTextStyle.txtSemiBold12.copyWith(color: Colors.black),)
                )

              ],
            ),
          ],
        ),
      ),
    );
  }


  Future<void> handlePayment(BuildContext context,PaymentController paymentControllerWatch)async {
    PaymentModel paymentModel = PaymentModel(
      id: getUUID(),
      amount: widget.amount,
      date: DateTime.now().toIso8601String(),
      note: widget.note,
      userId: widget.userModel?.id,
    );
    await paymentControllerWatch.addPayment(paymentModel);
    Navigator.pushReplacement(context, FadeThroughPageRoute(page: const HomeScreen()));
  }
}


