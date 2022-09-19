import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw8/category_bloc/category_bloc.dart';
import 'package:flutterhw8/model/item.dart' as it;
import 'package:flutterhw8/pages/category_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //List<it.Item> cart = [];
  final CategoryCubit _categoryCubit =CategoryCubit();
  @override
  void initState() {
    //print('Cart: $cart');
    _categoryCubit.getItemCart();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var heightM = MediaQuery.of(context).size.height - 240;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pop(context, MaterialPageRoute(builder: (ctx)=>const CategoryPage()));
          _categoryCubit.getItem();
          },),
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryCubit,CategoryState>(
            bloc: _categoryCubit,
            builder: (ctx, state){
              print('State: $state');
              if(state is CategoryCartGetState){
                return Container(
                  width: double.infinity,
                  height: heightM,
                  color: Colors.yellow,
                  child: const Center(
                  child: CircularProgressIndicator(),
                  ),
                );
              }
              if(state is CategoryCartSuccessState){
                return Container(
                  width: double.infinity,
                  height: heightM,
                  color: Colors.yellow,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _categoryCubit.cart.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return item(_categoryCubit.cart[index]);
                    },
                  ),
                );
              }
              // if(_categoryCubit.cart.isEmpty){
              //   return Container(
              //     width: double.infinity,
              //     height: heightM,
              //     color: Colors.yellow,
              //     child: const Center(
              //       child: Text(
              //         'Empty'
              //       ),
              //     )
              //   );
              // }
              return Container(

              );

            },
          ),
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: 1,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 200,
              color: Colors.yellow,
              child: buyItems(_categoryCubit.cart),
            ),
          )
        ],
      ),
    );
  }

  Widget buyItems(List<it.Item> items){
      var price=0;
      for(int i=0;i<items.length;i++){
        price+=items[i].price!;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('\$$price',style: const TextStyle(color: Colors.black45,fontSize: 48,)),
          const Text('Buy',style: TextStyle(color: Colors.blue,fontSize: 48),)
        ],
      );
  }

  Widget item(it.Item item) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.black45,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            '${item.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          const SizedBox(width: 64,)
        ],
      ),
    );
  }
}
