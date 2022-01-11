import 'package:ampact/constants.dart';
import 'package:ampact/src/core/giver/detail/giver_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiverListView extends StatefulWidget {
  const GiverListView({Key? key}) : super(key: key);

  @override
  _GiverListViewState createState() => _GiverListViewState();
}

class _GiverListViewState extends State<GiverListView> {
  final List<String> _items = [
    'Lutfee',
    'Rudeus',
    'Subaru',
    'Kazuma'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        _buildTitle(size),
        _buildCardList(),
      ],
    );
  }

  Widget _buildTitle(Size size) {
    return Container(
      //color: Colors.black,
      margin: const EdgeInsets.only(bottom: kDefaultPadding / 4),
      height: size.height * 0.175,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.15,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          SafeArea(
              child: Container(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  top: kDefaultPadding * 1.5,
                ),
                width: size.width,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.25),
                              ),
                              height: size.height * 0.01,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            child: Image.asset('assets/images/logo_name_white.png'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              //child: _buildCard(userInfo, size),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget buildCardList() {
    final userInfo = Provider.of<AsyncSnapshot<DocumentSnapshot>>(context);
    final List<dynamic> list = userInfo.data!['list'];

    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            final uid = list[index];
            return buildAndLoadCard(index, uid);
          },
        ),
      ),
    );
    //return Text('Hello');
  }

  Widget buildAndLoadCard(int index, String uid) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return const Text('Loading...');
          default:
            return buildCard(index, uid, snapshot);
        }
      },
    );
  }

  Widget _buildCard(int index, String uid, AsyncSnapshot<DocumentSnapshot> snapshot) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GiverDetailView(snapshot: snapshot),
          )
      ),
      child: Card(
        key: Key('$index'),
        child: Container(
          color: index.isOdd? oddItemColor : evenItemColor,
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 4,
            right: kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Item #$index'),
              Text(snapshot.data!['email']),
            ],
          ),
        ),
      ),
    );
  }*/

  Widget _buildCardList() {
    final size = MediaQuery.of(context).size;
    final userInfo = Provider.of<AsyncSnapshot<DocumentSnapshot>>(context);
    final List<dynamic> list = userInfo.data!['list'];

    return Expanded(
      child: Scrollbar(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          width: size.width,
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,
                children: [
                  for (int index = 0; index < list.length; index++)
                    _loadCardInfo(index, list[index])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadCardInfo(int index, String uid) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return const Text('Loading...');
          default:
            return _buildCard(index, uid, snapshot);
        }
      },
    );
  }

  Widget _buildCard(int index, String uid, AsyncSnapshot<DocumentSnapshot> snapshot) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GiverDetailView(snapshot: snapshot,))
      ),
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 5,
              color: kPrimaryColor.withOpacity(0.23),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.95),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}