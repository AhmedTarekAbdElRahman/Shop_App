import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/shop_app/cart_screen/cart_screen.dart';
import '../../modules/shop_app/search/search_screen.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTO(
                        context,
                        SearchScreen()
                    );
                  },
                  icon: Icon(Icons.search)
              )
            ],
            title: Text(
              'Salla',
            ),
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateTO(context, CartScreen());
            },
            child: Icon(
              Icons.shopping_cart
            ),
          ),
        );
      },
    );
  }
}
