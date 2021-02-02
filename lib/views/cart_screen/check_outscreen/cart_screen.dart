import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();
  }

  openSlidingAddress(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: false,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                'Add New Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You can Add a new delivery address.'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Text(
            'Cart',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 45,
            width: 200,
            color: Colors.blue[900],
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'You Dont Have saved address',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
                  child: InkWell(
                    onTap: () {
                      openSlidingAddress(context);
                    },
                    child: Text('ADD NEW',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Suggested Items',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Container(
              height: 75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image(
                    image: AssetImage('assets/images/download.jpg'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/812zAGhL84L._SL1500_.jpg'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: NetworkImage(
                        'https://www.bayzon.com/images/productimages/1563771762fine-classic.jpg'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: AssetImage('assets/images/download.jpg'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/812zAGhL84L._SL1500_.jpg'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: NetworkImage(
                        'https://www.bayzon.com/images/productimages/1563771762fine-classic.jpg'),
                  ),
                  Image(
                    image: NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/812zAGhL84L._SL1500_.jpg'),
                  ),
                  SizedBox(width: 10),
                  Image(
                    image: NetworkImage(
                        'https://www.bayzon.com/images/productimages/1563771762fine-classic.jpg'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Grocery',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('sold by ...(1 item)'),
            trailing: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 5),
                  child: Text(
                    'SubTotal: 999.0 EGP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                  child: Text('Free Delivery'),
                )
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Image(
                image: NetworkImage(
                    'https://images-na.ssl-images-amazon.com/images/I/812zAGhL84L._SL1500_.jpg'),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 0, 0),
              child: Text(
                  'Braun All in One Hair Trimmer With Gillette Fusion 5 ProGlide'),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 0, 0),
              child: Row(
                children: [
                  Text('999.00 EGP'),
                  SizedBox(
                    width: 105,
                  ),
                  quantity == 1
                      ? Text('')
                      : Container(
                          width: 45,
                          height: 45,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity == 1) {
                                  return;
                                }
                                quantity--;
                              });
                            },
                            icon: Icon(
                              Icons.minimize,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text('$quantity'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 200),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            title: Text(
              'Sub Total (1 item)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '999.00 EGP',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: RaisedButton(
              color: Colors.red,
              onPressed: () {},
              child: Text(
                'CHECKOUT',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
