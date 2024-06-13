import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/repository/common/model/user_model.dart';
import 'package:payment_management_app/screens/home_screen.dart';
import 'package:payment_management_app/screens/payment_screen.dart';
import 'package:payment_management_app/utils/common_text_style.dart';
import 'package:payment_management_app/utils/widgets/animations/fade_through_page_route.dart';

import '../utils/widgets/common_cache_network_image.dart';

class AddPaymentScreen extends StatefulWidget {
  final UserModel userModel;
  final bool isFromHomeScreen;
  const AddPaymentScreen({super.key,required this.userModel,this.isFromHomeScreen = false});

  @override
  AddPaymentScreenState createState() => AddPaymentScreenState();
}

class AddPaymentScreenState extends State<AddPaymentScreen> {

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: widget.isFromHomeScreen ?  const SizedBox.shrink() : IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: (){
              Navigator.pushReplacement(context, FadeThroughPageRoute(page: const HomeScreen()));
            },
          ) ,
        ),
        body: Padding(
          padding: EdgeInsets.all(15.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsetsDirectional.all(3.h),
                    child:CommonCachedNetworkImage(
                      boxFit: BoxFit.contain,
                      imgUrl: widget.userModel.avtarUrl ?? "https://avatar.iran.liara.run/public/98",
                      shimmerRadius: 50.r,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Paying ${widget.userModel.firstName} ${widget.userModel.lastName}',
                  style: KTextStyle.txtSemiBold20,
                ),
                SizedBox(height: 32.h),

                SizedBox(
                  width: 200.w,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: KTextStyle.txtBold40.copyWith(color: Theme.of(context).disabledColor),
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixText: '\$',
                      prefixStyle: KTextStyle.txtBold40.copyWith(color: Theme.of(context).disabledColor),
                      alignLabelWithHint: true,
                      hintText: '0',
                      border: InputBorder.none
                    ),
                  ),
                ),
            SizedBox(height: 5.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: _noteController,
                cursorColor: Theme.of(context).disabledColor,
                decoration: InputDecoration(
                  hintText: 'Add a note',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.r),
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).disabledColor
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).disabledColor
                      )
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                ),
              ),
            ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, FadeThroughPageRoute(page: PaymentScreen(amount: _amountController.text,note: _noteController.text,userModel: widget.userModel,)));
          },
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r)
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
