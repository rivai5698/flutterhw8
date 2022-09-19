import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw8/category_bloc/category_bloc.dart';
import 'package:flutterhw8/pages/cart_page.dart';
import '../model/item.dart' as it;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<it.Item> items = [];
  final CategoryCubit _categoryCubit = CategoryCubit();

  @override
  void initState() {
    // TODO: implement initState
    //items.addAll(it.items);
    _categoryCubit.getItem();
    super.initState();
  }
  @override
  void setState(VoidCallback fn) {
    _categoryCubit.getItem();
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              //
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const CartPage()));
              //_categoryCubit.getItemCart();
            },
          ),
        ],
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (ctx, state) {
          if (state is CategoryGettingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryGetSuccessState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _categoryCubit.items.length,
              itemBuilder: (BuildContext context, int index) {
                return item(_categoryCubit.items[index],
                    _categoryCubit.items[index].isAdd);
              },
            );
          }
          if (state is CategoryAddState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _categoryCubit.items.length,
              itemBuilder: (BuildContext context, int index) {
                return item(_categoryCubit.items[index],
                    _categoryCubit.items[index].isAdd);
              },
            );
          }

          return const Center(
            child: Text('Empty'),
          );
        },
      ),
    );
  }

  Widget cart(int total, bool hasItems) {
    if (total > 0) {
      hasItems = true;
    }
    return GestureDetector(
      child: Stack(
        children: [
          Visibility(
            visible: hasItems,
            child: Positioned(
                child: Text(
              '$total',
              style: const TextStyle(color: Colors.red),
            )),
          ),
          const Positioned.fill(
              child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          )),
        ],
      ),
    );
  }

  Widget item(it.Item item, bool? vis) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 80,
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${item.name}',
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  _categoryCubit.addCartItems(item);
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Visibility(
                          visible: vis!,
                          child: const Positioned(
                            child: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                          )),
                      Visibility(
                        visible: !vis,
                        child: const Positioned(
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //   BlocBuilder<CategoryCubit,CategoryState>(
    //   bloc: _categoryCubit,
    //   builder: (ctx,state){
    //     return Container(
    //       width: double.infinity,
    //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    //       height: 80,
    //       child: Row(
    //         children: [
    //           Container(
    //             height: 80,
    //             width: 80,
    //             color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    //           ),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             '${item.name}',
    //             style: const TextStyle(
    //               color: Colors.black45,
    //               fontSize: 18,
    //             ),
    //           ),
    //           Expanded(
    //             child: Align(
    //               alignment: Alignment.centerRight,
    //               child: GestureDetector(
    //                 onTap: (){
    //                   _categoryCubit.addCartItems(item);
    //                 },
    //                 child: SizedBox(
    //                   width: 80,
    //                   height: 80,
    //                   child: Stack(
    //                     alignment: Alignment.center,
    //                     children:  [
    //                       Visibility(
    //                           visible: vis!,
    //                           child: const Positioned(
    //                             child: Icon(
    //                               Icons.check,
    //                               color: Colors.grey,
    //                             ),
    //                           )),
    //                       Visibility(
    //                         visible: !vis,
    //                         child: const Positioned(
    //                           child: Text(
    //                             'Add',
    //                             style: TextStyle(color: Colors.blue),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // );
  }
}
