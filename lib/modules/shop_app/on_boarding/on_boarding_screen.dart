import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../login/shop_login_screen.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
   required this.image,
   required this.title,
   required this.body,
});
}
class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardControlling =PageController();

  List<BoardingModel>boarding=[
    BoardingModel(
      image:'assets/image/challenge1.jpg' ,
      title:'on Boarding 1 title',
      body:'on Boarding 1 body' ,
    ),
    BoardingModel(
      image:'assets/image/challenge1.jpg' ,
      title:'on Boarding 2 title',
      body:'on Boarding 2 body' ,
    ),
    BoardingModel(
      image:'assets/image/challenge1.jpg' ,
      title:'on Boarding 3 title',
      body:'on Boarding 3 body' ,
    ),
  ];
  bool isLast=false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value!){
        navigateAndFinish(context,ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
            'SKIP'
          ))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics:BouncingScrollPhysics(),
                controller: boardControlling,
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast=true;
                    });
                    print('last index');
                  }else{
                    setState(() {
                      isLast=false;
                    });
                    print('not last index');
                  }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardControlling,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                      activeDotColor: defaultColor
                    ),
                    count: boarding.length
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }else{
                        boardControlling.nextPage(
                            duration: Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios
                    ),
                ),
              ],
            )
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}
