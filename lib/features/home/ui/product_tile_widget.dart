import 'package:bloc_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_app/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc = HomeBloc();

  ProductTileWidget({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${productDataModel.price}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      //homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
