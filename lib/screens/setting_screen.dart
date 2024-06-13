import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/controllers/payment/payment_controller.dart';
import 'package:payment_management_app/controllers/theme/theme_controller.dart';
import 'package:payment_management_app/screens/payment_search_delegate.dart';
import 'package:payment_management_app/utils/common_text_style.dart';
import 'package:payment_management_app/utils/widgets/animations/custom_page_transition_switcher.dart';
import 'package:provider/provider.dart';
import '../utils/widgets/animations/slide_left_animation.dart';
import '../utils/widgets/common_cache_network_image.dart';
import '../utils/widgets/custom_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  PaymentController paymentControllerWatch = PaymentController();
  ThemeController themeControllerWatch = ThemeController();

  ///------build method
  @override Widget build(BuildContext context) {

    ///-------controllers
    paymentControllerWatch = context.watch<PaymentController>();
    themeControllerWatch = context.watch<ThemeController>();

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: CustomPageTransitionSwitcher(
        transitionType: SharedAxisTransitionType.horizontal,
        transitionDuration: const Duration(milliseconds: 500),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: (context,hey) => [
              sliverAppBar(context,themeControllerWatch)
            ],
            body: Column(
              children: [
                searchTransactionTextField(context),
                Expanded(child: settingListWidget(paymentControllerWatch.settingItemsList)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///------sliver app bar
SliverAppBar sliverAppBar(BuildContext context,ThemeController themeControllerWatch){
  return SliverAppBar(
    expandedHeight: 100.h,
    backgroundColor: Theme.of(context).cardColor,
    foregroundColor: Theme.of(context).cardColor,
    collapsedHeight: 100.h,
    pinned: true,
    floating: true,
    automaticallyImplyLeading: false,
    actions: [
      Padding(
        padding:  EdgeInsetsDirectional.only(end: 5.w),
        child: CustomToggleButton(
          value: themeControllerWatch.isDarkMode,
          inactiveIcon: Icons.light_mode_rounded,
          activeIcon: Icons.dark_mode_rounded,
          onChanged: (){
            themeControllerWatch.toggleTheme();
          },
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size(double.infinity,100.h),
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 15.w,vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsetsDirectional.all(3.h),
                child: CommonCachedNetworkImage(
                  boxFit: BoxFit.contain,
                  imgUrl: "https://avatar.iran.liara.run/public/98",
                  shimmerRadius: 40.r,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Mae Jamison',
              style: KTextStyle.txtMedium16,
            ),
            SizedBox(height: 3.h),
            Text(
              'mae@gmail.com',
              style: KTextStyle.txtRegular11,
            ),
          ],
        ),
      ),
    ),
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

///------- setting list widget
Widget settingListWidget(List settingItemsList){
  return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
      child: ListView.separated(
          itemCount: settingItemsList.length,
          itemBuilder: (context,index){
            Map<String,dynamic> listObject = settingItemsList[index];
            return SlideLeftAnimation(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(listObject['icon'],size: 20.sp,color: Theme.of(context).disabledColor),
                      SizedBox(width: 8.w,),
                      Text(
                        listObject['title'],
                        style: KTextStyle.txtMedium14,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,size: 15.sp,color: Theme.of(context).colorScheme.primary,),
                ],
              ),
            );
          },
          separatorBuilder: (context,index){
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10.w),
              child: const Divider(
                color: Colors.grey,
                thickness: 0.4,
              ),
            );
          },

      ),
  );
}
