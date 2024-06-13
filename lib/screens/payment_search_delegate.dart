import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment_management_app/controllers/payment/payment_controller.dart';
import 'package:payment_management_app/utils/common_text_style.dart';
import 'package:payment_management_app/utils/widgets/animations/slide_left_animation.dart';
import 'package:provider/provider.dart';
import 'package:payment_management_app/repository/common/model/user_model.dart';
import 'package:payment_management_app/repository/payment/model/payment_model.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/widgets/common_cache_network_image.dart';

class PaymentSearchDelegate extends SearchDelegate<PaymentModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        FocusScope.of(context).unfocus();
        close(context, PaymentModel());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final paymentProvider = Provider.of<PaymentController>(context, listen: false);
    return FutureBuilder<List<PaymentModel>>(
      future: paymentProvider.fetchPayments(),
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
                      padding: EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: const SizedBox(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[100],
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
            child: Text('No results found'),
          );
        } else {
          final results = snapshot.data!.where((payment) {
            final queryLower = query.toLowerCase();
            final noteContainsQuery = payment.note?.toLowerCase().contains(queryLower) ?? false;
            final amountContainsQuery = payment.amount.toString().contains(queryLower);

            final UserModel user = paymentProvider.userList.firstWhere(
                  (user) => user.id == payment.userId,
              orElse: () => UserModel(),
            );

            final firstNameContainsQuery = user.firstName?.toLowerCase().contains(queryLower) ?? false;
            final lastNameContainsQuery = user.lastName?.toLowerCase().contains(queryLower) ?? false;
            final fullNameContainsQuery = '${user.firstName?.toLowerCase() ?? ''} ${user.lastName?.toLowerCase() ?? ''}'.contains(queryLower);

            return noteContainsQuery || amountContainsQuery || firstNameContainsQuery || lastNameContainsQuery || fullNameContainsQuery;
          }).toList();

          if (results.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          }
          return SlideLeftAnimation(
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 10.h),
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 15.w),
                    child: const SizedBox(),
                  );
                },
                itemBuilder: (context, index) {
                  final payment = results[index];

                  final UserModel user = paymentProvider.userList.firstWhere(
                        (user) => user.id == payment.userId,
                    orElse: () => UserModel(),
                  );
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Theme.of(context).cardColor,
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
                            SizedBox(width: 10.w),
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
                                SizedBox(height: 2.h),
                                Text(
                                  "Payment",
                                  style: KTextStyle.txtMedium14,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                                SizedBox(height: 2.h),
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
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final paymentProvider = Provider.of<PaymentController>(context, listen: false);
    return FutureBuilder<List<PaymentModel>>(
      future: paymentProvider.fetchPayments(),
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
                      padding: EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 15.w),
                      child: const SizedBox(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[100],
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
            child: Text('No suggestions available'),
          );
        } else {
          final suggestions = query.isEmpty
              ? snapshot.data!
              : snapshot.data!.where((payment) {
            final queryLower = query.toLowerCase();
            final noteContainsQuery = payment.note?.toLowerCase().contains(queryLower) ?? false;
            final amountContainsQuery = payment.amount.toString().contains(queryLower);

            final UserModel user = paymentProvider.userList.firstWhere(
                  (user) => user.id == payment.userId,
              orElse: () => UserModel(),
            );

            final firstNameContainsQuery = user.firstName?.toLowerCase().contains(queryLower) ?? false;
            final lastNameContainsQuery = user.lastName?.toLowerCase().contains(queryLower) ?? false;
            final fullNameContainsQuery = '${user.firstName?.toLowerCase() ?? ''} ${user.lastName?.toLowerCase() ?? ''}'.contains(queryLower);

            return noteContainsQuery || amountContainsQuery || firstNameContainsQuery || lastNameContainsQuery || fullNameContainsQuery;
          }).toList();

          return Padding(
            padding: EdgeInsetsDirectional.only(top: 10.h),
            child: ListView.separated(
              itemCount: suggestions.length,
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: const SizedBox(),
                );
              },
              itemBuilder: (context, index) {
                final payment = suggestions[index];

                final UserModel user = paymentProvider.userList.firstWhere(
                      (user) => user.id == payment.userId,
                  orElse: () => UserModel(),
                );
                return SlideLeftAnimation(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Theme.of(context).cardColor,
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
                            SizedBox(width: 10.w),
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
                                SizedBox(height: 2.h),
                                Text(
                                  "Payment",
                                  style: KTextStyle.txtMedium14,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                                SizedBox(height: 2.h),
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
            ),
          );
        }
      },
    );
  }
}
