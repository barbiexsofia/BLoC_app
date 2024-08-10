import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/cart_items.dart';
import 'package:bloc_app/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    //on<CartItemRemovedEvent>(cartItemRemovedState);
  }

  Future<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    // run function to remove that product model from cartItems
    // emit cartItemRemovedState --> I want to rebuild the widget (CartState)
    cartItems.remove(event.productDataModel);

    emit(CartSuccessState(cartItems: cartItems));
  }
}
