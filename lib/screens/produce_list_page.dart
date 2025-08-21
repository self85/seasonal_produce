import 'package:flutter/material.dart';
import 'package:seasonal_produce/models/produce_item.dart';
import 'package:seasonal_produce/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';

const String kSelectedLocationKey = 'selected_location';
const String kSelectedLanguageKey = 'selected_language';
const String kFavoritesKey = 'favorites';

enum ViewType {
  list,
  icon,
  card,
}

enum SortType {
  none,
  alphabetical,
  seasonal,
  favorite,
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
  bool _isSortMenuExpanded = false;
  SortType _currentSort = SortType.none;
  Set<String> _favorites = {};

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
      _favorites = prefs.getStringList(kFavoritesKey)?.toSet() ?? {};
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kSelectedLocationKey, _selectedLocation ?? "sweden");
    await prefs.setString(kSelectedLanguageKey, _selectedLanguage ?? "english");
    await prefs.setStringList(kFavoritesKey, _favorites.toList());
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
    
    itemsInSeason = _sortItems(itemsInSeason);

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
          if (_isExpanded) _buildExpandedMenu(),
          if (_isSortMenuExpanded) _buildSortingMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
            if (!_isExpanded) {
              _isSortMenuExpanded = false;
            }
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
          trailing: IconButton(
            icon: Icon(
              isFavorite(items[index].name) ? Icons.favorite : Icons.favorite_border,
              color: isFavorite(items[index].name) ? Colors.red : Colors.grey,
            ),
            onPressed: () => toggleFavorite(items[index].name),
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        items[index].imagePath,
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => toggleFavorite(items[index].name),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isFavorite(items[index].name) ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite(items[index].name) ? Colors.red : Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                Stack(
                  children: [
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
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => toggleFavorite(items[index].name),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            isFavorite(items[index].name) ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite(items[index].name) ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildExpandedMenu() {
    return Positioned(
      bottom: 90,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "sort",
            onPressed: () {
              setState(() {
                _isSortMenuExpanded = !_isSortMenuExpanded;
              });
            },
            backgroundColor: const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.sort,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSortingMenu() {
    return Positioned(
      bottom: 122,
      right: 72,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "alphabetical",
            onPressed: () {
              setState(() {
                _currentSort = SortType.alphabetical;
                _isSortMenuExpanded = false;
              });
            },
            backgroundColor: _currentSort == SortType.alphabetical 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.sort_by_alpha,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "seasonal",
            onPressed: () {
              setState(() {
                _currentSort = SortType.seasonal;
                _isSortMenuExpanded = false;
              });
            },
            backgroundColor: _currentSort == SortType.seasonal 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "favorite",
            onPressed: () {
              setState(() {
                _currentSort = SortType.favorite;
                _isSortMenuExpanded = false;
              });
            },
            backgroundColor: _currentSort == SortType.favorite 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<ProduceItem> _sortItems(List<ProduceItem> items) {
    switch (_currentSort) {
      case SortType.alphabetical:
        return List.from(items)..sort((a, b) => a.name.compareTo(b.name));
      case SortType.seasonal:
        return List.from(items)..sort((a, b) => _compareSeasonalPriority(a, b));
      case SortType.favorite:
        return List.from(items)..sort((a, b) => _compareFavoritePriority(a, b));
      case SortType.none:
      default:
        return items;
    }
  }

  int _compareSeasonalPriority(ProduceItem a, ProduceItem b) {
    if (_selectedLocation == null) return 0;
    
    int currentMonth = DateTime.now().month;
    List<int> aSeason = a.seasonalAvailability[_selectedLocation!] ?? [];
    List<int> bSeason = b.seasonalAvailability[_selectedLocation!] ?? [];
    
    // Calculate how close to the center of their season each item is (peak season)
    double aPeakScore = _calculatePeakSeasonScore(aSeason, currentMonth);
    double bPeakScore = _calculatePeakSeasonScore(bSeason, currentMonth);
    
    // Higher peak score comes first
    return bPeakScore.compareTo(aPeakScore);
  }

  double _calculatePeakSeasonScore(List<int> seasonMonths, int currentMonth) {
    if (seasonMonths.isEmpty) return 0.0;
    
    // If only one month, and it's current month, it's peak season
    if (seasonMonths.length == 1) {
      return seasonMonths.contains(currentMonth) ? 1.0 : 0.0;
    }
    
    // For multiple months, find the middle of the season
    List<int> sortedMonths = List.from(seasonMonths)..sort();
    
    // Handle seasons that wrap around the year (e.g., Nov-Jan)
    if (sortedMonths.last - sortedMonths.first > 6) {
      // Season spans across year boundary
      int midMonth = _findWrappedSeasonMiddle(sortedMonths);
      return _distanceFromPeak(currentMonth, midMonth.toDouble());
    } else {
      // Normal season within the year
      double midMonth = (sortedMonths.first + sortedMonths.last) / 2.0;
      return _distanceFromPeak(currentMonth, midMonth);
    }
  }

  int _findWrappedSeasonMiddle(List<int> months) {
    // For seasons like [1,2,3,11,12], find middle of the wrapped season
    List<int> earlyMonths = months.where((m) => m <= 6).toList();
    List<int> lateMonths = months.where((m) => m > 6).toList();
    
    if (earlyMonths.isNotEmpty && lateMonths.isNotEmpty) {
      // Season wraps around year
      int spanStart = lateMonths.first;
      int spanEnd = earlyMonths.last + 12; // Adjust to next year
      return ((spanStart + spanEnd) / 2).round() % 12;
    }
    
    return months.first;
  }

  double _distanceFromPeak(int currentMonth, double peakMonth) {
    double distance = (currentMonth - peakMonth).abs();
    // Convert distance to score (closer to peak = higher score)
    return 1.0 - (distance / 6.0).clamp(0.0, 1.0);
  }

  void toggleFavorite(String itemName) {
    setState(() {
      if (_favorites.contains(itemName)) {
        _favorites.remove(itemName);
      } else {
        _favorites.add(itemName);
      }
    });
    _savePreferences();
  }

  bool isFavorite(String itemName) {
    return _favorites.contains(itemName);
  }

  int _compareFavoritePriority(ProduceItem a, ProduceItem b) {
    bool aIsFavorite = isFavorite(a.name);
    bool bIsFavorite = isFavorite(b.name);
    
    // If both are favorites or both are not favorites, sort alphabetically
    if (aIsFavorite == bIsFavorite) {
      return a.name.compareTo(b.name);
    }
    
    // Favorites come first
    return aIsFavorite ? -1 : 1;
  }
}