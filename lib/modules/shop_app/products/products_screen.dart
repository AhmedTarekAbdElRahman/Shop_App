
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../product_descriptions/product_descriptions.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState)
            if(!state.model.status!){
              showtoast(text: state.model.message!, state: ToastStates.ERROR);
            }
        },
        builder: (context, state) {
          return ConditionalBuilder(

              condition: ShopCubit.get(context).homeModel!=null&& ShopCubit.get(context).categoriesModel!=null,
              builder: (context)=>productBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
              fallback: (context)=>Center(child: CircularProgressIndicator())
          );
        },
    );
  }

  Widget productBuilder(HomeModel model,CategoriesModel categoriesModel,context )=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              // fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            )
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style:TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800
                ) ,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>BuildCategoryItem(categoriesModel.data!.data[index],context),
                  separatorBuilder: (context,index)=>SizedBox(
                      width: 10,
                    ),
                  itemCount: categoriesModel.data!.data.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Text(
                'New Products',
                style:TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                ) ,
              ),
            ],
          ),
        ),
        GridView.count(
          childAspectRatio: 1/1.58,
          shrinkWrap: true,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: List.generate(
                      model.data!.products.length,
                      (index) => buildGridProduct(model.data!.products[index],context,index),
          ),
        ),

      ],
    ),
  );
  Widget BuildCategoryItem(DataModel model,context)=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image!),
        height: 100,
        width: 100,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text(
          model.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis ,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      )
    ],
  );

  Widget buildGridProduct(ProductModel model,context,index)=>Container(
    color: Colors.white,
    child: InkWell(
      onTap: () {
        navigateTO(context, ProductDescription(index: index,));
      } ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,

                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${ model.price!.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                       color: defaultColor

                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if(model.discount!=0)Text(
                      '${ model.oldPrice!.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id!);
                          print(model.id);
                        },

                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:ShopCubit.get(context).favorites[model.id]! ?defaultColor:Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        )
                    ),
                    IconButton(

                        onPressed: (){

                          ShopCubit.get(context).changeCart(model.id!);

                          print(model.id);

                        },



                        icon: CircleAvatar(

                          radius: 15.0,

                          backgroundColor:ShopCubit.get(context).cart[model.id]! ?defaultColor:Colors.grey,

                          child: Icon(

                            Icons.shopping_cart,

                            size: 14.0,

                            color: Colors.white,

                          ),

                        )

                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
