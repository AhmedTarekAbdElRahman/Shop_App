import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';

import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String? value){
                            if(value!.isEmpty)return'enter text to searh';
                            return null;
                          },
                          onSubmit: (String? text){
                            SearchCubit.get(context).search(text);
                          },
                          label: 'search',
                          prefix: Icons.search
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if(state is SearchLoadingState)LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder:(context,index )=> buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,index,isOldPrice: false,),
                            separatorBuilder: (context,index )=>myDivider(),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }

}
