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
    var imageHeight = (MediaQuery.of(context).size.height) / 2;
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
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          decoration: boxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleText(product),
              SizedBox(height: 10),
              Text(product!.description!),
              SizedBox(height: 20),
              buildThumbnailRow(widget.product),
              SizedBox(height: 20),
              buildRowColors(),
              SizedBox(height: 20),
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
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Row buildRowColors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Color'),
        SizedBox(width: 10),
        buildCircleColorAvatar(Colors.greenAccent[400]!),
        SizedBox(width: 10),
        buildCircleColorAvatar(Colors.red.shade300),
        SizedBox(width: 10),
        buildCircleColorAvatar(Colors.indigo.shade300),
        Spacer(),
      ],
    );
  }
}
