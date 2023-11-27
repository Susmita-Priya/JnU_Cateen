import 'package:flutter/material.dart';

class help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Section'),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'How to Use this App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Image.asset('assets/studenthelp/Screenshot_121.png'),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "1. How to login ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    //Image.asset('assets/studenthelp/Screenshot_121.png'),
                    Text(
                      "First select \"student\" module\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_121.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nThen fillup login form with valid information then press \"sign in\" button\n",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_122.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nIf U haven't registered, then give email and password then press \"continue\" button then fillup signup form with valid information,then press \"submit\" button for complete registration\n",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_123.png',
                      height: 500,
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_124.png',
                      height: 420,
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_125.png',
                      height: 214,
                    ),

                    Text(
                      "\n\n\n2. How to order food ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    //Image.asset('assets/studenthelp/Screenshot_121.png'),
                    Text(
                      "First Go Home page\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_126.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nThen Select any food from food item and press \"add to cart\" button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_127.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nThen Go to \"my cart\" for placing order\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_128.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nCheck ordered food, u can also deselect any item then press \"checkout\" button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_129.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nCheck total amount then press \"payment\" button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_130.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nAfter pressing it will open Bkash payment interface\n"
                      "first enter bkash number and press \"confirm\"\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_131.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nThen enter pin that have been sent to entered number and press \"confirm\"\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_132.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nFinally, enter OTP that have been sent to entered number and press \"confirm\" for compelete order procedure\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_133.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n3. How Can check whether my order is placed or not ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"my order queue\" from drawer\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_134.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nIf your order is confirmed then u can see it in queue\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_135.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n4. How Can check order Status ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nIf your order is confirmed by canteen then Go to \"trace order\"\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_136.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n5. How Can take food ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nFirst press QR icon from order list\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_137.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nIf the order status is \"Packing done\" then go to canteen and they scan your QR Code and give your parcel\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_138.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n6. How Can Check cancelled order and how can back money ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"cancelled order\" for checking ur order is cancelled or not."
                      "\nIf cancelled then go to canteen within 24 hours and they will return money if u are the right person\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_140.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nIf they return money then u can find status \"Returned money\"\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_139.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n6. How Can added any food in wishlist ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nSelect any item then press heart icon and it will added item in wishlist\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_141.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nthen u can check wishlist from \"Favourite\" section\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_142.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n7. How Can give feedback ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"Feedback\" section from drawer\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_143.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nThen fill up the form and press \"Submit\" button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_144.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n8. How Can I check my feedback list ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"My Feedback List\" section from drawer\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_145.png',
                      height: 500,
                    ),
                    Text(
                      "\n\ncheck ur feedbacks ,u can also delete feedback\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_146.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n9. How Can search any item ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nPress serach icon\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_147.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nAnd Write item name\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_148.png',
                      height: 257,
                    ),
                    Text(
                      "\n\n\n10. How Can Check and update profile ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"Profile\" from drawer and check ur profile\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_149.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nIf u update profile picture then press camera icon that besides the profile picture\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_150.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nSelect picture from folder and press \"update\" button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_151.png',
                      height: 500,
                    ),
                    Text(
                      "\nIf u update info then write correct info in text field then press \"update\" button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_152.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n11. How Can Change language ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"Language\" from drawer\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_153.png',
                      height: 500,
                    ),
                    Text(
                      "\n\nSelect ur desired language\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_154.png',
                      height: 500,
                    ),
                    Text(
                      "\nOR before login u can also choose language pressing language button\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_155.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n12. How Can get information about this apps ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nGo to \"About Us\" from drawer\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_156.png',
                      height: 500,
                    ),
                    Text(
                      "\nThen check information about apps\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_157.png',
                      height: 500,
                    ),
                    Text(
                      "\n\n\n13. How Can logout from my account ?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Text(
                      "\nPress \"Logout\" from drawer\n",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      'assets/studenthelp/Screenshot_158.png',
                      height: 500,
                    ),
                  ],
                )),
            //  Image.network('https://example.com/help/image2.jpg'),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
