import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eshop/src/models/products.dart';

import 'widgets.dart';

class DetailBody extends StatefulWidget {
  const DetailBody({
    Key? key,
    @required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {


  @override
  Widget build(BuildContext context) {
    var imageHeight = (MediaQuery.of(context).size.height) / 3;
    Product product = widget.product!;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView(shrinkWrap: true, children: [
        Container(
          height: (imageHeight),
          child: Hero(
              tag: widget.product!.id!,
              child: Image.network(widget.product!.image!)),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: boxDecoration(),
          height: 2*imageHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleText(product),
              const SizedBox(height: 10),
              Text(product.description!),
              const SizedBox(height: 20),
              buildThumbnailRow(widget.product),
              const SizedBox(height: 20),
              buildRowColors(),
              const SizedBox(height: 20),
              buildRowBtnPrice(context, product)
            ],
          ),
        ),
      ]),
    );
  }

  Text buildTitleText(Product product) {
    return Text(
      product.title!,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Row buildRowColors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Color'),
        const SizedBox(width: 10),
        buildCircleColorAvatar(Colors.greenAccent[400]!),
        const SizedBox(width: 10),
        buildCircleColorAvatar(Colors.red.shade300),
        const SizedBox(width: 10),
        buildCircleColorAvatar(Colors.indigo.shade300),
        const Spacer(),
      ],
    );
  }
}
