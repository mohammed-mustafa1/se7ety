import 'package:flutter/material.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/intro/onboarding/data/model/on_boarding_model.dart';
import 'package:se7ety/features/intro/onboarding/presentation/widgets/on_boarding_page_view_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int activIndex = 0;
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: AppAssets.onBoarding1,
      title: 'ابحث عن دكتور متخصص',
      subTitle:
          'اكتشف مجموعة واسعة من الاطباء الخبراء والمتخصصين في مختلف المجالات',
    ),
    OnBoardingModel(
      image: AppAssets.onBoarding2,
      title: 'سهولة الحجز',
      subTitle: 'احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان',
    ),
    OnBoardingModel(
      image: AppAssets.onBoarding3,
      title: 'امن وسري',
      subTitle: 'كن مطمئنا لأن خصوصيتك وأمانك هما أهم أولوياتنا',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: activIndex < onBoardingList.length - 1,
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.all(16)),
              onPressed: () {},
              child: Text(
                'تخطي',
                style: TextStyles.getBody(color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: PageController(initialPage: 0),
                onPageChanged: (value) {
                  activIndex = value;
                  setState(() {});
                },
                itemCount: onBoardingList.length,
                itemBuilder: (context, index) {
                  return OnBoardingPageViewItem(
                    title: onBoardingList[index].title,
                    subTitle: onBoardingList[index].subTitle,
                    image: onBoardingList[index].image,
                  );
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: activIndex == onBoardingList.length - 1,
                    child: MainButton(
                      width: 80,
                      height: 50,
                      onTap: () {
                        context.pushTo(AppRouter.welcome);
                      },
                      text: 'هيا بنا ',
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: activIndex,
                    count: onBoardingList.length,
                    curve: Curves.linear,
                    effect: WormEffect(
                      dotWidth: 20,
                      dotHeight: 12,
                      activeDotColor: AppColors.primaryColor,
                      spacing: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
