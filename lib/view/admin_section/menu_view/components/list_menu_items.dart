import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class ListUserMenu extends StatefulWidget {
  const ListUserMenu({super.key});

  @override
  State<ListUserMenu> createState() => _ListUserMenuState();
}

class _ListUserMenuState extends State<ListUserMenu> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Align(
        alignment: Alignment
            .topCenter, // Keeps the container aligned centrally without taking up the full width
        child: Container(
          width: width * 0.92, // Limits the container width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: backgroundColor.withOpacity(0.7),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns items at the top
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 8.0, bottom: 15),
                child: Container(
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'asset/image/image.png',
                      width: width * 0.3,
                      fit: BoxFit.cover,
                      //height: null, // Dynamically matches the tallest content
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Chicken Cheese Burger double',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis, // Truncate if too long
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.crop_square_sharp,
                                color: Colors.red,
                                size: 36,
                              ),
                              Icon(Icons.circle, color: Colors.red, size: 14),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Flexible(
                        child: Text(
                          'Your description goes here.hehhhehhehhhehhehhehhehehhcsnckskckaclanclksancklsaklcnsalknclskacnlskncklsanclksanclkansclknasklcnsaklncklasnclkanscklsanklcnslkanclksanklcnsaklcnsalkncklsncklvjksdbkjdsbvjkdsbvjkdbsvjkbdjksvbskjdbvjkdsbvjkdbvjdsbvkjdsbvjkdsbvkjbdvknslkdnlknvlskdvkn ',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Price 20'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
