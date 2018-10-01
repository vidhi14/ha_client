part of 'main.dart';

class EntityViewPage extends StatefulWidget {
  EntityViewPage({Key key, this.entity}) : super(key: key);

  final Entity entity;

  @override
  _EntityViewPageState createState() => new _EntityViewPageState();
}

class _EntityViewPageState extends State<EntityViewPage> {
  String _title;
  Entity _entity;
  StreamSubscription _stateSubscription;

  @override
  void initState() {
    super.initState();
    _entity = widget.entity;
    if (_stateSubscription != null) _stateSubscription.cancel();
    _stateSubscription = eventBus.on<StateChangedEvent>().listen((event) {
      if (event.entityId == _entity.entityId) {
        setState(() {});
      }
    });
    _prepareData();
  }

  _prepareData() async {
    _title = _entity.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(_title),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: _entity.buildWidget(context, false)
      ),
    );
  }

  @override
  void dispose(){
    if (_stateSubscription != null) _stateSubscription.cancel();
    super.dispose();
  }
}