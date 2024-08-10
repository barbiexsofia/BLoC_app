part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemAddedToWishlistActionState extends HomeActionState {
  final ProductDataModel clickedProduct;

  HomeProductItemAddedToWishlistActionState({required this.clickedProduct});
}

class HomeProductItemAddedToCartActionState extends HomeActionState {
  final ProductDataModel clickedProduct;

  HomeProductItemAddedToCartActionState({required this.clickedProduct});
}
