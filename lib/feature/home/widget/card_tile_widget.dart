import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';

class CardTileWidget extends StatelessWidget {
  CardTileWidget(
      {Key? key,
      required this.prod_name,
      required this.prod_rate,
      required this.prod_subtext,
      required this.prod_url,
      required this.counter,
      required this.addProduct,
      required this.removeProduct})
      : super(key: key);

  final int counter;
  final String prod_name;
  final String prod_subtext;
  final String prod_rate;
  final String prod_url;
  final Function() addProduct;
  final VoidCallback removeProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 280,
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 120,
                child: Image.network(
                  prod_url,
                  fit: BoxFit.fill,
                ),
              ),
              ListTile(
                //leading: Icon(Icons.arrow_drop_down_circle),
                title: Text(
                  prod_name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  prod_subtext,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${prod_rate.toString()}",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      (prod_rate * counter).toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              counter == 0
                  ? ElevatedButton(
                      onPressed: addProduct,
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.green
                          ),
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.green)),
                            child: TextButton(
                                onPressed: () => removeProduct,
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        Text(
                          counter.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextButton(
                                onPressed: () => addProduct,
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
