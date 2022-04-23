import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/shop_app/cubit/cubit.dart';
import '../../modules/shop_app/product_descriptions/product_descriptions.dart';
import '../styles/colors.dart';

Widget defaultButton({
  required double? width,
  required Color? background,
  required VoidCallback? function,
  required String? text,

}) =>
    Container(
      height: 40.0,
      decoration:BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  VoidCallback?suffixPress,
  GestureTapCallback? onTap,
  bool isClickable=true,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed:suffixPress,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
      validator: validate,
    );

// Widget buildArticalItem(article,context)=>InkWell(
//     onTap: (){
//       navigateTO(
//           context,
//           WebViewScreen(article['url'])
//       );
//     }
//     );
Widget myDivider()=>Padding(
  padding: const EdgeInsets.only(left: 20.0),
  child:   Container(

    width: double.infinity,

    color: Colors.grey[300],

    height: 1.0,

  ),
);
void navigateTO(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic> route)=>false

);
void showtoast({
  required String text,
  required ToastStates state
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
       color=Colors.green;
      break;
    case ToastStates.ERROR:
       color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.yellow;
      break;
  }
  return color;
}
Widget buildListProduct(model,context,int index,{bool? isOldPrice=false})=>InkWell(
  onTap: () {
    navigateTO(context, ProductDescription(index: index,));
  } ,
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Container(

      height: 120.0,

      child: Row  (

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(

            width: 120,

            height: 120,

            child: Stack(

              alignment: AlignmentDirectional.bottomStart,

              children: [

                Image(

                  image: NetworkImage(model.image!),

                  width: 120,

                  height: 120,

                ),

                if(model.discount!=0&&isOldPrice!)Container(

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

          ),

          SizedBox(

            width: 20,

          ),

          Expanded(

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

                Spacer(),

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

                    if(model.discount!=0&&isOldPrice!)Text(

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

  ),

);
