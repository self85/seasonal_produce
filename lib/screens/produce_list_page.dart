import 'package:flutter/material.dart';
import 'package:seasonal_produce/models/produce_item.dart';
import 'package:seasonal_produce/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';

const String kSelectedLocationKey = 'selected_location';
const String kSelectedLanguageKey = 'selected_language';

enum ViewType {
  list,
  icon,
  card,
}

class ProduceListPage extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const ProduceListPage({super.key, required this.onLocaleChange});

  @override
  ProduceListPageState createState() => ProduceListPageState();
}

class ProduceListPageState extends State<ProduceListPage> {
  String? _selectedLocation = "sweden";
  String? _selectedLanguage = "english";
  late List<ProduceItem> items;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLocation = prefs.getString(kSelectedLocationKey) ?? "sweden";
      _selectedLanguage = prefs.getString(kSelectedLanguageKey) ?? "english";
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kSelectedLocationKey, _selectedLocation ?? "sweden");
    await prefs.setString(kSelectedLanguageKey, _selectedLanguage ?? "english");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = [
      ProduceItem(S.of(context).apples, 'assets/produce/apple.jpeg', {
      'sweden': [1, 2, 3, 8, 9, 10, 11, 12],
      'andalucia': [9, 10, 11, 12]
    }),
    ProduceItem(S.of(context).strawberries, 'assets/produce/strawberry.jpeg', {
      'sweden': [6, 7, 8],
      'andalucia': [3, 4, 5, 6]
    }),
    ProduceItem(S.of(context).blueberries, 'assets/produce/blueberry.jpeg', {
      'sweden': [7, 8],
      'andalucia': [5, 6, 7]
    }),
    ProduceItem(S.of(context).raspberries, 'assets/produce/raspberry.jpeg', {
      'sweden': [7, 8],
      'andalucia': [5, 6, 7, 8]
    }),
    ProduceItem(S.of(context).mushrooms, 'assets/produce/mushroom.jpeg', {
      'sweden': [7, 8, 9, 10],
      'andalucia': [1, 2, 3, 10, 11, 12]
    }),
    ProduceItem(S.of(context).grapes, 'assets/produce/grape.jpeg', {
      'sweden': [7, 8, 9, 10, 11, 12],
      'andalucia': [8, 9, 10]
    }),
    ProduceItem(S.of(context).pears, 'assets/produce/pear.jpeg', {
      'sweden': [8, 9, 10, 11],
      'andalucia': [8, 9, 10, 11]
    }),
    ProduceItem(S.of(context).plums, 'assets/produce/plum.jpeg', {
      'sweden': [8, 9, 10],
      'andalucia': [6, 7, 8]
    }),
    ProduceItem(S.of(context).cherries, 'assets/produce/cherry.jpeg', {
      'sweden': [7, 8, 9],
      'andalucia': [5, 6, 7]
    }),
    ProduceItem(S.of(context).beets, 'assets/produce/beet.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 9, 10, 11, 12]
    }),
    ProduceItem(S.of(context).potatoes, 'assets/produce/potato.jpeg', {
      'sweden': [5, 6, 7, 8, 9],
      'andalucia': [3, 4, 5, 6, 7]
    }),
    ProduceItem(S.of(context).carrots, 'assets/produce/carrot.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 9, 10, 11, 12]
    }),
    ProduceItem(S.of(context).broccoli, 'assets/produce/broccoli.jpeg', {
      'sweden': [6, 7, 8, 9, 10, 11],
      'andalucia': [11, 12, 1, 2, 3, 4]
    }),
    ProduceItem(S.of(context).cauliflower, 'assets/produce/cauliflower.jpeg', {
      'sweden': [5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [10, 11, 12, 1, 2, 3]
    }),
    ProduceItem(S.of(context).peas, 'assets/produce/pea.jpeg', {
      'sweden': [6, 7, 8, 9, 10],
      'andalucia': [4, 5, 6]
    }),
    ProduceItem(S.of(context).cabbage, 'assets/produce/cabbage.jpeg', {
      'sweden': [1, 2, 3, 4, 7, 8, 9, 10, 11, 12],
      'andalucia': [10, 11, 12, 1, 2, 3, 4]
    }),
    ProduceItem(S.of(context).kale, 'assets/produce/kale.jpeg', {
      'sweden': [1, 2, 10, 11, 12],
      'andalucia': [11, 12, 1, 2]
    }),
    ProduceItem(S.of(context).brusselsSprouts, 'assets/produce/brusselsprout.jpeg', {
      'sweden': [1, 2, 3, 9, 10, 11, 12],
      'andalucia': [11, 12, 1, 2]
    }),
    ProduceItem(S.of(context).papaya, 'assets/produce/papaya.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }),
    ProduceItem(S.of(context).pineapple, 'assets/produce/pineapple.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }),
    ProduceItem(S.of(context).mango, 'assets/produce/mango.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [8, 9, 10]
    }),
    ProduceItem(S.of(context).passionfruit, 'assets/produce/passionfruit.jpeg', {
      'sweden': [1, 2, 3, 4, 7, 8, 9, 10, 12],
      'andalucia': [8, 9, 10]
    }),
    ProduceItem(S.of(context).kiwi, 'assets/produce/kiwi.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [11, 12, 1, 2, 3, 4]
    }),
    ProduceItem(S.of(context).lychee, 'assets/produce/lychee.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [7, 8]
    }),
    ProduceItem(S.of(context).pomegranate, 'assets/produce/pomegranate.jpeg', {
      'sweden': [1, 2, 3, 9, 10, 11, 12],
      'andalucia': [9, 10, 11, 12]
    }),
    ProduceItem(S.of(context).coconut, 'assets/produce/coconut.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }),
    ProduceItem(S.of(context).avocado, 'assets/produce/avocado.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [10, 11, 12, 1, 2, 3, 4, 5]
    }),
    ProduceItem(S.of(context).oranges, 'assets/produce/orange.jpeg', {
      'sweden': [], 
      'andalucia': [1, 2, 3, 10, 11, 12]
    }),
    ProduceItem(S.of(context).lemons, 'assets/produce/lemon.jpeg', {
      'sweden': [], 
      'andalucia': [1, 2, 3, 10, 11, 12]
    }),
    ProduceItem(S.of(context).olives, 'assets/produce/olive.jpeg', {
      'sweden': [], 
      'andalucia': [10, 11, 12, 1, 2, 3]
    }),
    ProduceItem(S.of(context).almonds, 'assets/produce/almond.jpeg', {
      'sweden': [], 
      'andalucia': [8, 9, 10]
    }),
    ProduceItem(S.of(context).figs, 'assets/produce/fig.jpeg', {
      'sweden': [], 
      'andalucia': [7, 8, 9]
    }),
    ProduceItem(S.of(context).lingonberries, 'assets/produce/lingonberry.jpeg', {
      'sweden': [8, 9, 10],
      'andalucia': [] 
    }),
    ProduceItem(S.of(context).cloudberries, 'assets/produce/cloudberry.jpeg', {
      'sweden': [7, 8],
      'andalucia': [] 
    }),
    ProduceItem(S.of(context).rhubarb, 'assets/produce/rhubarb.jpeg', {
      'sweden': [5, 6, 7],
      'andalucia': []
    }),
    ProduceItem(S.of(context).cranberries, 'assets/produce/cranberry.jpeg', {
      'sweden': [9, 10],
      'andalucia': [] 
    }),
    ProduceItem(S.of(context).blackcurrants, 'assets/produce/blackcurrant.jpeg', {
      'sweden': [7, 8],
      'andalucia': [] 
    })
    ];
  }

  ViewType _viewType = ViewType.card;

  @override
  Widget build(BuildContext context) {
    final String appTitle = S.of(context).appTitle;
    int currentMonth = DateTime.now().month;
    var itemsInSeason = _selectedLocation != null
        ? items.where((item) => item.isInSeason(_selectedLocation!, currentMonth)).toList()
        : items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B0D3A),
        title: Text(appTitle),
        titleTextStyle: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      selectedLocation: _selectedLocation,
                      selectedLanguage: _selectedLanguage,
                      onLocaleChange: widget.onLocaleChange,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _selectedLocation = result['selectedLocation'];
                    _selectedLanguage = result['selectedLanguage'];
                    _savePreferences();
                  });
                }
              },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildViewSelectionButtons(),
              Expanded(
                child: _buildView(itemsInSeason),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        backgroundColor: const Color(0xFF3B0D3A),
        child: Icon(
          _isExpanded ? Icons.close : Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildViewSelectionButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _viewType = ViewType.list;
              });
            },
            color: _viewType == ViewType.list ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              setState(() {
                _viewType = ViewType.icon;
              });
            },
            color: _viewType == ViewType.icon ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.view_agenda),
            onPressed: () {
              setState(() {
                _viewType = ViewType.card;
              });
            },
            color: _viewType == ViewType.card ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildView(List<ProduceItem> items) {
    switch (_viewType) {
      case ViewType.list:
        return _buildListView(items);
      case ViewType.icon:
        return _buildGridView(items);
      case ViewType.card:
      default:
        return _buildCardView(items);
    }
  }

  Widget _buildListView(List<ProduceItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            items[index].name,
            style: const TextStyle(
              fontSize: 20.0,
              color: Color(0xFF240041),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<ProduceItem> items) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 3 : // Phone
                        screenWidth < 900 ? 4 : // Small tablet
                        screenWidth < 1200 ? 5 : // Large tablet
                        6; // Extra large tablet

    double padding = screenWidth > 600 ? 16.0 : 10.0;
    double imageSize = screenWidth > 600 ? 180.0 : 100.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: padding,
          crossAxisSpacing: padding,
          childAspectRatio: 0.7, // Made taller to accommodate longer text
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    items[index].imagePath,
                    fit: BoxFit.cover,
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
              Expanded(
                flex: 2, // Increased flex for text container
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      items[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 18.0 : 14.0,
                        fontFamily: 'BebasNeue',
                        color: const Color(0xFF240041),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCardView(List<ProduceItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(15),
                  ),
                  child: Image.asset(
                    items[index].imagePath,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 20.0,
                    height: 250,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  items[index].name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}