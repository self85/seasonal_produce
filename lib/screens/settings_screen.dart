import 'package:flutter/material.dart';
import '/generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  final String? selectedLocation;
  final String? selectedLanguage;
  final Function(Locale) onLocaleChange;

  const SettingsScreen(
      {super.key,
      this.selectedLocation,
      this.selectedLanguage,
      required this.onLocaleChange});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late String _selectedLocation; // Default selected flag (change as needed)
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.selectedLocation ??
        'sweden'; // Use passed value or default to "sweden"
    _selectedLanguage = widget.selectedLanguage ?? 'english';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF3B0D3A),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(S.of(context).settings),
          titleTextStyle: const TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 40,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, {
                'selectedLocation': _selectedLocation,
                'selectedLanguage': _selectedLanguage,
              });
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).location,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 32,
                color: Color(0xFF240041),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Swedish Flag Icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLocation = 'sweden';
                    });
                    //Navigator.pop(context, _selectedLocation);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedLocation == 'sweden'
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/flags/sweden.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(S.of(context).sweden,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF240041),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Spanish Flag Icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLocation = 'andalucia';
                    });
                    //Navigator.pop(context, _selectedLocation);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedLocation == 'andalucia'
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/flags/andalucia.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(S.of(context).andalucia,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF240041),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
            Text(
              S.of(context).language,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 32,
                color: Color(0xFF240041),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Swedish Flag Icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'swedish';
                    });
                    widget.onLocaleChange(Locale('sv'));
                    //Navigator.pop(context, _selectedLanguage);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedLanguage == 'swedish'
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/flags/sweden.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(S.of(context).swedish,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF240041),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Spanish Flag Icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'spanish';
                      widget.onLocaleChange(Locale('es'));
                    });
                    //Navigator.pop(context, _selectedLanguage);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedLanguage == 'spanish'
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/flags/spain.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(S.of(context).spanish,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF240041),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'english';
                    });
                    widget.onLocaleChange(Locale('en'));
                    //Navigator.pop(context, _selectedLanguage);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedLanguage == 'english'
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/flags/uk.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(S.of(context).english,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF240041),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
