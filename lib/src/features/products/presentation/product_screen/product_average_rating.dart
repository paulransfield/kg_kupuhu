import 'package:flutter/material.dart';
import 'package:kg_router/src/constants/app_sizes.dart';
import 'package:kg_router/src/features/products/domain/product.dart';

import 'package:kg_router/src/constants/kg_colors.dart' show MyColors;

/// Shows the product average rating score and the number of ratings
class ProductAverageRating extends StatelessWidget {
  const ProductAverageRating({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.teal,
        ),
        gapW8,
        Text(
          product.avgRating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        gapW8,
        Text(
          product.numRatings == 1
              ? '1 rating'
              : '${product.numRatings} ratings',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
