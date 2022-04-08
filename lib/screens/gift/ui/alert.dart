import 'package:beautina_provider/utils/ui/space.dart';
import 'package:beautina_provider/utils/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:ndialog/ndialog.dart';
import 'package:emojis/emoji.dart'; // to use Emoji utilities
import 'package:flutter_screenutil/flutter_screenutil.dart';

final String strAdv = """
لكل 50 طلب تسويق ممول مجاني

عند وصول عدد الطلبات في حسابك 50 طلب 
من أشخاص مختلفين تحصين على مكافأة تسويق 
تستهدف لايقل عن 5000 شخص مهتم في منطقتك 
مقدمة لك من فريق تسويق بيوتينا، سيتم التواصل والتنسيق معك

كيف أحصل على 50 طلب؟ 

عن طريق حصولك على الطلبات في صفحتك

:مثال
شاركي صفحتك مع زبائنك وفي مواقع التواصل

:فوائد العرض

تسويق ممنهج مجاني يستهدف 3500 شخص مهتم- 
كلما زاد عدد طلباتك تزداد أولوية ظهورك في بحث الزبائن-

""";
final String q1 =
    'لكل 50 طلب تسويق ممول مجاني ${Emoji.byName('smiling face with sunglasses')!.char}';
final String a1 = '''
عند وصول عدد الطلبات في حسابك 50 طلب من أشخاص مختلفين تحصين على مكافأة تسويق تستهدف لايقل عن 5000 شخص مهتم في منطقتك مقدمة لك من فريق تسويق بيوتينا، سيتم التواصل والتنسيق معك.
''';

final String q2 =
    '''كيف أحصل على 50 طلب؟ ${Emoji.byName('face with monocle')!.char}''';
final String a2 = 'عن طريق حصولك على الطلبات في صفحتك';

final String q3 = 'مثال:';
final String a3 =
    'شاركي صفحتك مع زبائنك وفي مواقع التواصل، ويطلبون خدماتك من التطبيق';

final String q4 = 'فوائد العرض: ${Emoji.byName('two hearts')!.char}';
final String a4 = '''- تسويق ممنهج مجاني يستهدف 5000 شخص مهتم
- كلما زاد عدد طلباتك تزداد أولوية ظهورك في بحث الزبائن
''';

List<String> listQuestions = [q1, q2, q3, q4];
List<String> listAnswers = [a1, a2, a3, a4];
List<IconData> listIcons = [
  Icons.attach_money,
  Icons.question_answer,
  Icons.question_answer,
  Icons.money
];

showOfferAlert(BuildContext context) {
  DialogBackground(
    blur: 300,
    color: Colors.black,
    barrierColor: Colors.black,
    dialog: NDialog(
      dialogStyle: DialogStyle(
          backgroundColor: Colors.black,
          titleDivider: true,
          borderRadius: BorderRadius.circular(25)),
      // title: Text("Hi, This is NDialog"),

      content: Container(
        height: 0.5.sh,
        width: 0.8.sw,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listQuestions.length,
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: Column(
                children: [
                  Container(
                    // height: ,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        GWdgtTextTitleDesc(
                          color: Colors.yellow.withOpacity(0.6),
                          string: listQuestions[index],
                        ),
                      ],
                    ),
                  ),
                  Y(),
                  GWdgtTextDescDesc(
                    color: Colors.white.withOpacity(0.6),
                    string: listAnswers[index],
                    textAlgin: TextAlign.justify,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    )..show(
        context,
      ),
  );
}
