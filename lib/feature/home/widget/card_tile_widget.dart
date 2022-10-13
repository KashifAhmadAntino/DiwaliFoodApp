import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';

class CardTileWidget extends StatefulWidget {
  CardTileWidget(
      {Key? key,
      required this.prod_name,
      required this.prod_rate,
      required this.prod_subtext})
      : super(key: key);

  final int counter = 0;
  String prod_name;
  String prod_subtext;
  int prod_rate;

  @override
  State<CardTileWidget> createState() => _CardTileWidgetState();
}

class _CardTileWidgetState extends State<CardTileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(18.0),
              //   child: Image.network(""),
              // ),
              ListTile(
                //leading: Icon(Icons.arrow_drop_down_circle),
                title: Text(
                  widget.prod_name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.prod_subtext,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.prod_rate.toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      (widget.prod_rate * widget.counter).toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              widget.counter == 0
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  // backgroundColor: Colors.green
                                  ),
                              child: const Text(
                                'ADD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    )
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
                                onPressed: () {},
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        Text(
                          widget.counter.toString(),
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
                                onPressed: () {},
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
