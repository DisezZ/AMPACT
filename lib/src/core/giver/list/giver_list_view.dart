import 'package:ampact/constants.dart';
import 'package:ampact/src/authentication/models/user_model.dart';
import 'package:ampact/src/core/components/custom_app_bar.dart';
import 'package:ampact/src/core/components/custom_card.dart';
import 'package:ampact/src/core/giver/detail/giver_detail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

class GiverListView extends StatefulWidget {
  const GiverListView({Key? key}) : super(key: key);

  @override
  _GiverListViewState createState() => _GiverListViewState();
}

class _GiverListViewState extends State<GiverListView> {
  /*final queryUser = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJSON(snapshot.data()!),
        toFirestore: (user, _) => user.toJSON(),
      );*/

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final user = Provider.of<DocumentSnapshot?>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Elderly/Blinded',
      ),
      //body: Text('Hello'),
      body: Scrollbar(
        child: Container(
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
          ),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('list')
                .snapshots(),
            builder: (context, snapshot) {
              return ListView(
                children: [
                  for (var item in snapshot) {
                    
                  }
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: kDefaultPadding),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: theme.primaryColor,
          child: FittedBox(
            child: Icon(
              Icons.add,
              color: theme.backgroundColor,
              size: 32,
            ),
          ),
        ),
      ),
      /*body: FirestoreListView<UserModel>(
        query: queryUser,
        itemBuilder: (context, snapshot) {
          final users = snapshot.data();
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(users.profileImage),
            ),
            title: Text('${users.firstName} ${users.lastName}'),
            subtitle: const Text('Telphone number'),
            trailing: Icon(Icons.chevron_right_sharp),
            onTap: () {
              print('enter detail view for ${users.firstName}');
            },
            onLongPress: () {
              print('more action for ${users.firstName}');
            },
          );
        },
      ),*/
    );
  }

  /*Widget _buildTitle(Size size) {
    return Container(
      color: Colors.black,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Image.asset('assets/images/logo_name_white.png'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
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
                    blurRadius: 5,
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
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading...');
          default:
            return _buildCard(index, uid, snapshot);
        }
      },
    );
  }

  Widget _buildCard(
      int index, String uid, AsyncSnapshot<DocumentSnapshot> snapshot) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => GiverDetailView(
                    snapshot: snapshot,
                  ))),
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
  }*/
}
