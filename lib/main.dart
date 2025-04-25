import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Performance Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
        useMaterial3: true,
      ),
      home: const TestScreen(),
    );
  }
}

int buildCounter = 0;

void _incrementBuildCounter() => buildCounter++;

void _printBuildCounter() => print(buildCounter);
void _resetBuildCounter() => buildCounter = 0;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  static const int itemCount = 10000;
  static const double itemExtent = 50;
  bool useListViewBuilder = false;
  bool useWidgetChild = false;
  bool useItemExtent = false;
  bool shrinkWrap = false;
  bool withImage = false;
  @override
  Widget build(BuildContext context) {
    _incrementBuildCounter();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  TextButton(
                    onPressed: _printBuildCounter,
                    child: Text('Print Build Count'),
                  ),
                  TextButton(
                    onPressed: _resetBuildCounter,
                    child: Text('Reset Build Count'),
                  ),
                  RepaintBoundary(child: CircularProgressIndicator()),
                ],
              ),
              Row(
                children: [
                  const Text('Use ListView.builder'),
                  Switch.adaptive(
                    value: useListViewBuilder,
                    onChanged: (newValue) => setState(
                      () => useListViewBuilder = newValue,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Use widget child'),
                  Switch.adaptive(
                    value: useWidgetChild,
                    onChanged: (newValue) => setState(
                      () => useWidgetChild = newValue,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Set itemExtent'),
                  Switch.adaptive(
                    value: useItemExtent,
                    onChanged: (newValue) => setState(
                      () => useItemExtent = newValue,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('shrinkWrap'),
                  Switch.adaptive(
                    value: shrinkWrap,
                    onChanged: (newValue) => setState(
                      () => shrinkWrap = newValue,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('withImage'),
                  Switch.adaptive(
                    value: withImage,
                    onChanged: (newValue) => setState(
                      () => withImage = newValue,
                    ),
                  )
                ],
              ),
              Expanded(
                child: (useListViewBuilder)
                    ? ListView.builder(
                        itemBuilder: (context, index) => useWidgetChild
                            ? _Item(
                                index: index,
                                withImage: withImage,
                              )
                            : _item(index, withImage),
                        itemCount: itemCount,
                        itemExtent: useItemExtent ? itemExtent : null,
                        shrinkWrap: shrinkWrap,
                      )
                    : ListView(
                        shrinkWrap: shrinkWrap,
                        itemExtent: useItemExtent ? itemExtent : null,
                        children: List.generate(
                          itemCount,
                          (index) => useWidgetChild
                              ? _Item(
                                  index: index,
                                  withImage: withImage,
                                )
                              : _item(index, withImage),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int index, bool withImage) {
    return Builder(builder: (context) {
      _incrementBuildCounter();
      return ListTile(
        title: Text('Item $index (M)'),
        trailing: withImage ? Image.network(_imageUrl) : null,
      );
    });
  }
}

const _imageUrl =
    'https://avatars.mds.yandex.net/i?id=5497c7dc23d8acedf62e168321c645a8_l-5220447-images-thumbs&n=13';

class _Item extends StatelessWidget {
  final int index;
  final bool withImage;
  const _Item({
    required this.index,
    required this.withImage,
  });

  @override
  Widget build(BuildContext context) {
    _incrementBuildCounter();
    return ListTile(
      title: Text('Item $index (W)'),
      trailing: withImage ? Image.network(_imageUrl) : null,
    );
  }
}
