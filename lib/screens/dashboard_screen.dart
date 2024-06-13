import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/controllers/payment/payment_controller.dart';
import 'package:payment_management_app/repository/common/model/user_model.dart';
import 'package:payment_management_app/screens/add_payment_screen.dart';
import 'package:payment_management_app/screens/payment_search_delegate.dart';
import 'package:payment_management_app/utils/common_text_style.dart';
import 'package:payment_management_app/utils/widgets/animations/custom_page_transition_switcher.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shimmer/shimmer.dart';
import '../repository/payment/model/payment_model.dart';
import '../utils/widgets/animations/slide_left_animation.dart';
import '../utils/widgets/common_cache_network_image.dart';
import '../utils/widgets/animations/fade_through_page_route.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  ///---- init method
  @override void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  ///-----build method
  @override Widget build(BuildContext context) {

    ///----controller
    final paymentControllerWatch = Provider.of<PaymentController>(context);

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: CustomPageTransitionSwitcher(
        transitionType: SharedAxisTransitionType.horizontal,
        transitionDuration: const Duration(milliseconds: 500),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            headerSliverBuilder: (context,isScroll) => [
              sliverAppBar(context),
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.all(15.h),
                  child: Column(
                    children: [
                      balanceCardWidget(context),
                      SizedBox(height: 20.h),
                      sendAgainSection(paymentControllerWatch),
                    ],
                  ),
                ),
              ),
            ],
            body: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w)+EdgeInsets.only(top: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Activity', style: KTextStyle.txtSemiBold16),
                      Icon(Icons.filter_list_sharp,color: Theme.of(context).colorScheme.primary,)
                    ],
                  ),
                ),
                searchTransactionTextField(context),
                Expanded(child: activityListWidget(paymentControllerWatch)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


///-----sliver appbar
SliverAppBar sliverAppBar(BuildContext context){
  return SliverAppBar(
    expandedHeight: 100.h,
    backgroundColor: Theme.of(context).cardColor,
    collapsedHeight: 100.h,
    pinned: true,
    stretch: false,
    automaticallyImplyLeading: false,
    actions: [
      Padding(
        padding:  EdgeInsetsDirectional.only(end: 5.w),
        child: IconButton(
          onPressed: (){},
          icon: badges.Badge(
            badgeContent: Text("2",style: KTextStyle.txtMedium10.copyWith(color: Colors.white),),
            position: badges.BadgePosition.topStart(top: -10, start: 12),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              elevation: 0,
            ),
            child:Icon(Icons.notifications,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      )
    ],
    flexibleSpace: Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: 15.w,vertical: 25.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsetsDirectional.all(3.h),
                  child: CommonCachedNetworkImage(
                    boxFit: BoxFit.contain,
                    imgUrl: "https://avatar.iran.liara.run/public/98",
                    shimmerRadius: 30.r,
                  ),
                ),
              ),
              SizedBox(width: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi,Vanessa',
                    style: KTextStyle.txtMedium16,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Here\'s your spending dashboard.',
                    style: KTextStyle.txtRegular12,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

///-----balance card
Widget balanceCardWidget(BuildContext context){
  return SlideLeftAnimation(
    child: Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('\$204.05', style: KTextStyle.txtBold24.copyWith(color: Colors.black)),
              Text('Your Balance', style: KTextStyle.txtMedium12.copyWith(color: Theme.of(context).disabledColor)),

            ],
          ),
          SizedBox(
            height: 50.h, // Ensure the height of the divider is appropriate
            child: VerticalDivider(
              width: 20,
              thickness: 2,
              color: Theme.of(context).disabledColor,
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('30', style: KTextStyle.txtBold24.copyWith(color:Theme.of(context).colorScheme.primary )),
                  Text('Last days', style: KTextStyle.txtMedium12.copyWith(color: Theme.of(context).disabledColor)),
                ],
              ),
              Icon(Icons.arrow_drop_down,color:Theme.of(context).colorScheme.primary,size: 30.sp,)
            ],
          )
        ],
      ),
    ),
  );
}

///-----send again user list
Widget sendAgainSection(PaymentController todoController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Send Again', style: KTextStyle.txtBold20),
      SizedBox(height: 10.h),
      SizedBox(
        height: 100.h,
        child: ListView.builder(
          itemCount: todoController.userList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            UserModel userModel = todoController.userList[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsetsDirectional.all(3.h),
                        child: CommonCachedNetworkImage(
                          boxFit: BoxFit.contain,
                          imgUrl: userModel.avtarUrl ?? "",
                          shimmerRadius: 30.r,
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, FadeThroughPageRoute(page: AddPaymentScreen(userModel: userModel,)));
                    },
                  ),
                  SizedBox(height: 5.h),
                  Text(userModel.firstName ?? "",style: KTextStyle.txtMedium12.copyWith(),),
                  Text(userModel.lastName ?? "",style: KTextStyle.txtMedium12.copyWith(),),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

///----- activity or payment transaction list
Widget activityListWidget(PaymentController paymentController){
  return  FutureBuilder<List<PaymentModel>>(
    future: paymentController.fetchPayments(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SlideLeftAnimation(
          child: Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade300,
              direction: ShimmerDirection.ltr,
              child: ListView.separated(
                itemCount: 7,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 15.w),
                    child: const SizedBox(),
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[100]
                    ),
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsetsDirectional.all(3.h),
                        child: const SizedBox(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text('No transaction found'),
        );
      } else {

        List<PaymentModel> paymentList = snapshot.data ?? [];
        return ListView.separated(
          itemCount: paymentList.length,
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 15.w),
              child: const SizedBox(),
            );
          },
          itemBuilder: (context, index) {
            final payment = paymentList[index];

            final UserModel user = paymentController.userList.firstWhere(
                  (user) => user.id == payment.userId,
              orElse: () => UserModel(),
            );
            return SlideLeftAnimation(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Theme.of(context).cardColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsetsDirectional.all(3.h),
                            child: CommonCachedNetworkImage(
                              boxFit: BoxFit.contain,
                              imgUrl: user.avtarUrl ?? "",
                              shimmerRadius: 30.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user.firstName} ${user.lastName}",
                              style: KTextStyle.txtSemiBold14,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            SizedBox(height: 2.h,),
                            Text("Payment",style: KTextStyle.txtMedium14,),
                            SizedBox(height: 2.h,),
                            Text(
                              payment.note ?? 'No Note',
                              style: KTextStyle.txtRegular12.copyWith(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "\$${payment.amount.toString()}",
                      style: KTextStyle.txtMedium12,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    },
  );
}

///------ search text-field
Widget searchTransactionTextField(BuildContext context){
  return SlideLeftAnimation(
    child: InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        showSearch(context: context, delegate: PaymentSearchDelegate());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w) + EdgeInsets.only(top: 15.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: TextField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            hintText: 'Search Transaction',
            enabled: false,
            hintStyle: KTextStyle.txtRegular14,
            prefixIcon: Icon(Icons.search,color: Theme.of(context).colorScheme.primary,),
            border: InputBorder.none,
          ),
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
    ),
  );
}
