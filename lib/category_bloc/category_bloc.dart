import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw8/model/item.dart' as it;

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit():super(CategoryInitState());
  List<it.Item> items = [];
  List<it.Item> cart = [];

  getItem(){
    items.addAll(it.items);
    emit(CategoryGettingState());

    Future.delayed(const Duration(seconds: 1),(){
      emit(CategoryGetSuccessState());
    });

  }



  addCartItems(it.Item item){
      cart.add(item);
      for(int i=0;i<items.length;i++){
          for(int j=0;j<cart.length;j++){
            if(items[i].id==cart[j].id) {
              items[i].isAdd = true;
            }
          }
      }
      print('Cart: $cart');
      emit(CategoryAddState());

      // Future.delayed(const Duration(seconds: 1),(){
      //   getItemCart();
      //   emit(CategoryCartSuccessState());
      // });
  }


  getItemCart(){
    //cart.addAll(cart);
    emit(CategoryCartGetState());
    print('get cart: $cart');
    Future.delayed(const Duration(seconds: 3),(){
      if(cart.isNotEmpty){
        emit(CategoryCartSuccessState());
      }else{
        emit(CategoryEmptyState());
      }
    });
  }

  removeCartItems(it.Item item){
    if(cart.isNotEmpty){
      for(int i=0;i<cart.length;i++){
        cart.removeWhere((element) => element.id == item.id);
        emit(CategoryRemoveState());
      }
      for(int i=0;i<items.length;i++){
        for(int j=0;j<cart.length;j++){
          if(items[i]==cart[j]){
            items[i].isAdd = false;
          }
        }
      }
    }else{
      emit(CategoryEmptyState());
    }

  }
}

class CategoryState{}

class CategoryInitState extends CategoryState{}

class CategoryRemoveState extends CategoryState{}

class CategoryAddState extends CategoryState{}

class CategoryEmptyState extends CategoryState{}

class CategoryGettingState extends CategoryState{}

class CategoryGetSuccessState extends CategoryState{}

class CategoryCartSuccessState extends CategoryState{}

class CategoryCartGetState extends CategoryState{}

class CategoryCartEmptyState extends CategoryState{}