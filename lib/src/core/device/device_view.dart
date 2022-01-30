import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/pointing_word_reader/pointing_word_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Device',
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        color: _theme.backgroundColor,
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () =>
                    pushNewScreen(context, screen: PointingWordReaderView()),
                child: Text('Pointed Word Reader'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
