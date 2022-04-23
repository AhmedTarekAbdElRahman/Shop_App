import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/styles/colors.dart';
class ProductDescription extends StatelessWidget {
  int index;

  ProductDescription({required this.index});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
      builder: (context, state) {
          var model=ShopCubit.get(context).homeModel!.data!.products[index];
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Product Descriptions'.toUpperCase(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  child: CarouselSlider.builder(

                      unlimitedMode: true,
                      slideBuilder: (index) {
                        return Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Image(
                                image: NetworkImage(model.images![index]),
                                width: double.infinity,
                                height: 200,
                              ),
                              if(model.discount!=0)Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0
                                ),
                                color: Colors.red,
                                child: Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      slideTransform: FlipHorizontalTransform(),
                      slideIndicator: CircularSlideIndicator(
                        padding: EdgeInsets.only(bottom: 32),
                      ),
                      itemCount: model.images!.length
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                      model.name!,
                      style: TextStyle(
                          fontSize: 18.0,
                          height: 1.3,
                          color: defaultColor,
                        fontWeight: FontWeight.bold

                      )
                    ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                      children: [
                        Text('The Price ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                        ),
                        Text(
                            '${ model.price!.round()}',
                            style: TextStyle(
                            fontSize: 16.0,
                            color: defaultColor
                            ),
                        ),
                        SizedBox(
                            width: 5.0,
                        ),
                        if(model.discount!=0)Text(
                            ' ${ model.oldPrice!.round()}',
                            style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                          ),
                        ),
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                  child: Text(model.description!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
