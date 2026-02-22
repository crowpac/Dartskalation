import 'package:flutter/material.dart';

// --- SPRACH-KONFIGURATION ---
final ValueNotifier<bool> isGermanNotifier = ValueNotifier(false);

// --- HIGHSCORE DATENMODELL ---
class ScoreEntry {
  String name;
  int score;
  ScoreEntry(this.name, this.score);
}

// --- GLOBALER HIGHSCORE SPEICHER (TOP 3 PRO MODUS) ---
Map<String, List<ScoreEntry>> highScores = {
  'mode_normal': [],
  'mode_stop': [],
  'mode_punish': [],
  'mode_hardcore': [],
  'mode_cricket': [],
  'mode_custom': [],
};

Map<String, String> get txt => isGermanNotifier.value ? _de : _en;

// --- DEUTSCHE TEXTE ---
final Map<String, String> _de = {
  'title': 'DARTSKALATION',
  'made_by': 'Made by Aikill Beens',
  'rules_hint':
      'Runde 1: Triff die 1. Runde 2: Triff die 2.\nNur das Ziel zählt.\nRunde 21: BULLSEYE.',

  // MODUS TITEL
  'mode_normal': 'NORMAL (Klassik)',
  'mode_stop': 'RUNDE STOPPEN',
  'mode_punish': 'BESTRAFUNG',
  'mode_hardcore': 'HARDCORE',
  'mode_cricket': 'Cricket Dartskalation',
  'mode_custom': 'MATRIX',

  // BUTTON INFOS
  'info_normal': 'Punkte sammeln. Keine Strafen.',
  'info_stop': 'Fehlwurf = Sofort Rundenende!',
  'info_punish': 'Falsches Feld = Punktabzug!',
  'info_hardcore': 'Fehler = Alles auf 0!',
  'info_cricket': '3x treffen, dann punkten.',
  'info_custom': 'Deine eigenen Regeln.',

  'btn_leaderboard': 'BESTENLISTE',
  'leaderboard_title': 'TOP 3 REKORDE (Sitzung)',
  'leaderboard_reset': 'Alles Löschen',
  'no_records': 'Noch keine Einträge.',

  // LANGE BESCHREIBUNGEN
  'desc_normal': 'Klassisches Spiel. Punkte sammeln. Keine Strafen.',
  'desc_stop': 'Ziel verfehlt? Runde sofort vorbei!',
  'desc_punish': 'Falsches Feld? Punktabzug! Board verfehlt? -100 Punkte!',
  'desc_hardcore': 'Nichts oder Falsches getroffen? PUNKTE RESET AUF 0!',
  'desc_cricket':
      '3 Treffer öffnen das Feld für Punkte.\nDu sammelst so lange Punkte, bis ALLE Spieler das Feld 3x getroffen haben.',
  'desc_custom': 'Eigene Matrix-Regeln aktiv. Siehe oben.',

  'setup_title': 'Einrichtung: ',
  'player_name': 'Spielername',
  'start_game': 'SPIEL STARTEN',
  'custom_rules': 'MATRIX REGELN',
  'rule_double': 'Doppel Feld',
  'rule_triple': 'Triple Feld',
  'rule_miss': 'Ziel verfehlt',
  'game_over': 'SPIEL VORBEI',
  'winner': 'GEWINNER',
  'new_record': 'NEUER HIGHSCORE!',
  'enter_name': 'Name eingeben:',
  'save': 'Speichern',
  'back_menu': 'ZURÜCK ZUM MENÜ',
  'target': 'ZIEL',
  'miss_board': 'BOARD VERFEHLT (-100)',
  'miss_next': 'DANEBEN / WEITER',
  'wrong_field': 'FALSCHES FELD',
  'btn_single': 'EINFACH',
  'btn_double': 'DOPPEL',
  'btn_triple': 'TRIPLE',
  'dialog_title': 'Welches Feld getroffen?',
  'cancel': 'Abbrechen',
  'bull': 'BULL (25)',
  'bullseye': 'BULLSEYE (50)',
  'dd_x1': 'Einfach (x1)',
  'dd_x2': 'Doppel (x2)',
  'dd_x3': 'Dreifach (x3)',
  'dd_mx1': 'Minus Einfach (-x1)',
  'dd_mx2': 'Minus Doppel (-x2)',
  'dd_mx3': 'Minus Dreifach (-x3)',
  'dd_stop': 'Runde Stoppen',
  'dd_reset': 'Punkte Reset (0)',
  'dd_cont0': 'Weiter (0 Pkt)',
  'dd_miss': 'Miss Logik (Abzug)',
};

// --- ENGLISCHE TEXTE ---
final Map<String, String> _en = {
  'title': 'DARTSKALATION',
  'made_by': 'Made by Aikill Beens',
  'rules_hint':
      'Round 1: Hit 1. Round 2: Hit 2.\nOnly target counts.\nRound 21: BULLSEYE.',
  'mode_normal': 'NORMAL (Classic)',
  'mode_stop': 'ROUND STOP',
  'mode_punish': 'PUNISHMENT',
  'mode_hardcore': 'HARDCORE',
  'mode_cricket': 'Cricket Dartskalation',
  'mode_custom': 'MATRIX',
  'info_normal': 'Just points. No penalties.',
  'info_stop': 'Miss target = Turn over!',
  'info_punish': 'Wrong field = Minus points!',
  'info_hardcore': 'Any mistake = Reset to 0!',
  'info_cricket': 'Hit 3x, then score.',
  'info_custom': 'Your own custom rules.',
  'btn_leaderboard': 'LEADERBOARD',
  'leaderboard_title': 'TOP 3 RECORDS (Session)',
  'leaderboard_reset': 'Reset All',
  'no_records': 'No records yet.',
  'desc_normal': 'Classic Game. Collect points. No penalties.',
  'desc_stop': 'Miss the target? Turn ends immediately!',
  'desc_punish': 'Wrong field? Points deduction! Miss board? -100 Points!',
  'desc_hardcore': 'Hit nothing or wrong field? FULL SCORE RESET TO 0!',
  'desc_cricket':
      'Hit 3x to open scoring.\nCollect points until ALL players have hit the number 3x.',
  'desc_custom': 'Custom Matrix Rules active. Check settings above.',
  'setup_title': 'Setup: ',
  'player_name': 'Player Name',
  'start_game': 'START GAME',
  'custom_rules': 'CUSTOM MATRIX RULES',
  'rule_double': 'Double Field',
  'rule_triple': 'Triple Field',
  'rule_miss': 'Miss Target',
  'game_over': 'GAME OVER',
  'winner': 'WINNER',
  'new_record': 'NEW HIGHSCORE!',
  'enter_name': 'Enter Name:',
  'save': 'Save',
  'back_menu': 'BACK TO MENU',
  'target': 'TARGET',
  'miss_board': 'MISS BOARD (-100)',
  'miss_next': 'MISS / NEXT',
  'wrong_field': 'WRONG FIELD',
  'btn_single': 'SINGLE',
  'btn_double': 'DOUBLE',
  'btn_triple': 'TRIPLE',
  'dialog_title': 'Which field hit?',
  'cancel': 'Cancel',
  'bull': 'BULL (25)',
  'bullseye': 'BULLSEYE (50)',
  'dd_x1': 'Single (x1)',
  'dd_x2': 'Double (x2)',
  'dd_x3': 'Triple (x3)',
  'dd_mx1': 'Minus Single (-x1)',
  'dd_mx2': 'Minus Double (-x2)',
  'dd_mx3': 'Minus Triple (-x3)',
  'dd_stop': 'Stop Round',
  'dd_reset': 'Reset Points (0)',
  'dd_cont0': 'Continue (0 Pts)',
  'dd_miss': 'Miss Logic (-Points)',
};

void main() {
  runApp(const DartskalationApp());
}

class DartskalationApp extends StatelessWidget {
  const DartskalationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isGermanNotifier,
      builder: (context, isGerman, child) {
        return MaterialApp(
          title: 'Dartskalation',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            fontFamily: 'sans-serif',
            primaryColor: Colors.green,
            scaffoldBackgroundColor: const Color(0xFF121212),
            colorScheme: const ColorScheme.dark(
              primary: Colors.green,
              secondary: Colors.greenAccent,
              surface: const Color(0xFF1E1E1E),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          home: const HomeScreen(),
        );
enum GameMode { normal, cricket }

enum RuleAction {
  addSingle,
  addDouble,
  addTriple,
  subSingle,
  subDouble,
  subTriple,
  stop,
  reset,
  missCustom,
  continueZero
}

class GameSettings {
  GameMode mode;
  String presetKey;
  String descKey;
  RuleAction doubleAction;
  RuleAction tripleAction;
  RuleAction missAction;

  GameSettings({
    this.mode = GameMode.normal,
    this.presetKey = "mode_custom",
    this.descKey = "",
    this.doubleAction = RuleAction.addDouble,
    this.tripleAction = RuleAction.addTriple,
    this.missAction = RuleAction.continueZero,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: MediaQuery für sichere Höhe nutzen
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40, // Etwas kompakter oben
        actions: [
          TextButton.icon(
            onPressed: () {
              isGermanNotifier.value = !isGermanNotifier.value;
            },
            icon:
                const Icon(Icons.language, color: Colors.greenAccent, size: 20),
            label: Text(isGermanNotifier.value ? "DE" : "EN",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER - KOMPAKTER GEMACHT (Icon kleiner, Text kleiner)
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.track_changes,
                        size: 40, color: Colors.green), // Kleiner (war 60)
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(txt['title']!,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              color: Colors.white)), // Kleiner (war 32)
                    ),
                    Text(txt['made_by']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 10,
                            fontStyle: FontStyle.italic)),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        txt['rules_hint']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 10, height: 1.2),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // HERO BUTTON (Normal)
              Expanded(
                flex: 2,
                child: _modeButton(
                    context, 'mode_normal', 'info_normal', Colors.green[800]!,
                    isHero: true),
              ),

              const SizedBox(height: 8),

              // GRID
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: _modeButton(context, 'mode_stop',
                                  'info_stop', Colors.blueGrey[700]!)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: _modeButton(context, 'mode_punish',
                                  'info_punish', Colors.orange[900]!)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: _modeButton(context, 'mode_hardcore',
                                  'info_hardcore', Colors.red[900]!)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: _modeButton(context, 'mode_cricket',
                                  'info_cricket', Colors.purple[800]!)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: _modeButton(context, 'mode_custom',
                                  'info_custom', Colors.grey[800]!)),
                          const SizedBox(width: 8),
                          // BESTENLISTE
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const LeaderboardScreen()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.emoji_events,
                                      color: Colors.white, size: 22),
                                  const SizedBox(height: 2),
                                  Text(txt['btn_leaderboard']!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeButton(
      BuildContext context, String titleKey, String infoKey, Color col,
      {bool isHero = false}) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: col,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          GameSettings settings = GameSettings();
          settings.presetKey = titleKey;

          if (titleKey == 'mode_cricket') {
            settings.mode = GameMode.cricket;
            settings.descKey = 'desc_cricket';
          } else {
            settings.mode = GameMode.normal;
            if (titleKey == 'mode_normal') {
              settings.doubleAction = RuleAction.addDouble;
              settings.tripleAction = RuleAction.addTriple;
              settings.missAction = RuleAction.continueZero;
              settings.descKey = 'desc_normal';
            } else if (titleKey == 'mode_stop') {
              settings.doubleAction = RuleAction.addDouble;
              settings.tripleAction = RuleAction.addTriple;
              settings.missAction = RuleAction.stop;
              settings.descKey = 'desc_stop';
            } else if (titleKey == 'mode_punish') {
              settings.doubleAction = RuleAction.addDouble;
              settings.tripleAction = RuleAction.addTriple;
              settings.missAction = RuleAction.missCustom;
              settings.descKey = 'desc_punish';
            } else if (titleKey == 'mode_hardcore') {
              settings.doubleAction = RuleAction.addDouble;
              settings.tripleAction = RuleAction.addTriple;
              settings.missAction = RuleAction.reset;
              settings.descKey = 'desc_hardcore';
            } else {
              settings.missAction = RuleAction.missCustom;
              settings.descKey = 'desc_custom';
            }
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SetupScreen(settings: settings)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              txt[titleKey]!,
              style: TextStyle(
                  fontSize: isHero ? 20 : 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              txt[infoKey]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: isHero ? 11 : 9,
                  fontStyle: FontStyle.italic),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// --- LEADERBOARD SCREEN ---
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(txt['btn_leaderboard']!)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(txt['leaderboard_title']!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber)),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: highScores.entries.map((entry) {
                  if (entry.value.isEmpty) return const SizedBox.shrink();

                  return Card(
                    color: Colors.white10,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(txt[entry.key] ?? entry.key,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.greenAccent)),
                          const Divider(color: Colors.white24),
                          ...entry.value.asMap().entries.map((rankEntry) {
                            int rank = rankEntry.key + 1;
                            ScoreEntry score = rankEntry.value;
                            String medal = "";
                            if (rank == 1) medal = "🥇";
                            if (rank == 2) medal = "🥈";
                            if (rank == 3) medal = "🥉";

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 30,
                                      child: Text(medal,
                                          style:
                                              const TextStyle(fontSize: 18))),
                                  Expanded(
                                      child: Text(score.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500))),
                                  Text("${score.score} Pts",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
                onPressed: () {
                  setState(() {
                    highScores.forEach((key, value) => value.clear());
                  });
                },
                icon: const Icon(Icons.delete),
                label: Text(txt['leaderboard_reset']!),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SetupScreen extends StatefulWidget {
  final GameSettings settings;
  const SetupScreen({super.key, required this.settings});
  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final List<String> _players = [];
  final TextEditingController _ctrl = TextEditingController();

  void _addPlayer() {
    if (_ctrl.text.trim().isNotEmpty) {
      setState(() => _players.add(_ctrl.text.trim()));
      _ctrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCustom = widget.settings.presetKey == 'mode_custom';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title:
              Text("${txt['setup_title']}${txt[widget.settings.presetKey]}")),
      body: SafeArea(
        child: Column(
          children: [
            if (isCustom) ...[
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(txt['custom_rules']!,
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _buildDropdown(
                          txt['rule_double']!,
                          widget.settings.doubleAction,
                          (v) =>
                              setState(() => widget.settings.doubleAction = v!),
                          isMiss: false),
                      _buildDropdown(
                          txt['rule_triple']!,
                          widget.settings.tripleAction,
                          (v) =>
                              setState(() => widget.settings.tripleAction = v!),
                          isMiss: false),
                      _buildDropdown(
                          txt['rule_miss']!,
                          widget.settings.missAction,
                          (v) =>
                              setState(() => widget.settings.missAction = v!),
                          isMiss: true),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white24),
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Colors.redAccent.withOpacity(0.5))),
                  child: Text(
                    txt[widget.settings.descKey]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _ctrl,
                      decoration: InputDecoration(
                        labelText: txt['player_name'],
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green),
                            onPressed: _addPlayer),
                      ),
                      onSubmitted: (_) => _addPlayer(),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _players.length,
                      itemBuilder: (c, i) => ListTile(
                        title: Text(_players[i]),
                        leading: CircleAvatar(
                            backgroundColor: Colors.grey[800],
                            child: Text("${i + 1}")),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () =>
                                setState(() => _players.removeAt(i))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _players.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GameScreen(
                                      players: _players,
                                      settings: widget.settings)));
                        },
                  child: Text(txt['start_game']!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, RuleAction current, Function(RuleAction?) onChanged,
      {required bool isMiss}) {
    List<DropdownMenuItem<RuleAction>> items = [];

    if (isMiss) {
      items = [
        DropdownMenuItem(
            value: RuleAction.continueZero, child: Text(txt['dd_cont0']!)),
        DropdownMenuItem(value: RuleAction.stop, child: Text(txt['dd_stop']!)),
        DropdownMenuItem(
            value: RuleAction.missCustom, child: Text(txt['dd_miss']!)),
        DropdownMenuItem(
            value: RuleAction.reset, child: Text(txt['dd_reset']!)),
      ];
    } else {
      items = [
        DropdownMenuItem(
            value: RuleAction.addSingle, child: Text(txt['dd_x1']!)),
        DropdownMenuItem(
            value: RuleAction.addDouble, child: Text(txt['dd_x2']!)),
        DropdownMenuItem(
            value: RuleAction.addTriple, child: Text(txt['dd_x3']!)),
        DropdownMenuItem(
            value: RuleAction.subSingle, child: Text(txt['dd_mx1']!)),
        DropdownMenuItem(
            value: RuleAction.subDouble, child: Text(txt['dd_mx2']!)),
        DropdownMenuItem(
            value: RuleAction.subTriple, child: Text(txt['dd_mx3']!)),
        DropdownMenuItem(value: RuleAction.stop, child: Text(txt['dd_stop']!)),
        DropdownMenuItem(
            value: RuleAction.reset, child: Text(txt['dd_reset']!)),
        DropdownMenuItem(
            value: RuleAction.continueZero, child: Text(txt['dd_cont0']!)),
        DropdownMenuItem(
            value: RuleAction.missCustom, child: Text(txt['dd_miss']!)),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          DropdownButton<RuleAction>(
              value: current, items: items, onChanged: onChanged),
        ],
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final List<String> players;
  final GameSettings settings;
  const GameScreen({super.key, required this.players, required this.settings});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<int> scores;
  late List<int> cricketHits;
  int pIdx = 0;
  int round = 1;
  int dartsThrown = 0;
  bool isGameOver = false;
  final List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    scores = List.filled(widget.players.length, 0);
    cricketHits = List.filled(widget.players.length, 0);
  }

  void _saveState() {
    _history.add({
      'scores': List<int>.from(scores),
      'cricketHits': List<int>.from(cricketHits),
      'pIdx': pIdx,
      'round': round,
      'dartsThrown': dartsThrown,
      'isGameOver': isGameOver,
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    final last = _history.removeLast();
    setState(() {
      scores = List<int>.from(last['scores']);
      cricketHits = List<int>.from(last['cricketHits']);
      pIdx = last['pIdx'];
      round = last['round'];
      dartsThrown = last['dartsThrown'];
      isGameOver = last['isGameOver'];
    });
  }

  void _processThrow(
      {required bool hitTarget, int multiplier = 1, int penaltyPoints = 0}) {
    if (isGameOver) return;
    _saveState();
    setState(() {
      int p = pIdx;
      bool forceTurnEnd = false;
      int targetVal = (widget.settings.mode != GameMode.cricket && round == 21)
          ? 25
          : round;

      if (widget.settings.mode == GameMode.cricket) {
        if (hitTarget) {
          for (int i = 0; i < multiplier; i++) {
            if (cricketHits[p] < 3) {
              cricketHits[p]++;
            } else {
              if (cricketHits.any((h) => h < 3)) scores[p] += round;
            }
          }
        }
      } else {
        if (hitTarget) {
          RuleAction action = RuleAction.addSingle;
          if (multiplier == 2) action = widget.settings.doubleAction;
          if (multiplier == 3) action = widget.settings.tripleAction;

          if (action == RuleAction.missCustom) {
            _processThrow(
                hitTarget: false, penaltyPoints: targetVal * multiplier);
            return;
          }

          _applyRule(p, action, targetVal);
          if (action == RuleAction.stop) forceTurnEnd = true;
          if (action == RuleAction.reset) scores[p] = 0;
        } else {
          if (penaltyPoints != 0) {
            scores[p] -= penaltyPoints;
          } else {
            if (widget.settings.missAction == RuleAction.reset) scores[p] = 0;
            if (widget.settings.missAction == RuleAction.stop)
              forceTurnEnd = true;
          }
        }
      }
      if (forceTurnEnd) {
        dartsThrown = 3;
      } else {
        dartsThrown++;
      }
      if (widget.settings.mode == GameMode.cricket) {
        if (cricketHits.every((h) => h >= 3)) {
          round++;
          cricketHits = List.filled(widget.players.length, 0);
          if (round > 20) isGameOver = true;
        }
      }
      if (dartsThrown >= 3) {
        dartsThrown = 0;
        if (pIdx >= widget.players.length - 1) {
          pIdx = 0;
          if (widget.settings.mode != GameMode.cricket) {
            round++;
            if (round > 21) isGameOver = true;
          }
        } else {
          pIdx++;
        }
      }
    });
  }

  void _applyRule(int p, RuleAction action, int baseVal) {
    switch (action) {
      case RuleAction.addSingle:
        scores[p] += baseVal;
        break;
      case RuleAction.addDouble:
        scores[p] += baseVal * 2;
        break;
      case RuleAction.addTriple:
        scores[p] += baseVal * 3;
        break;
      case RuleAction.subSingle:
        scores[p] -= baseVal;
        break;
      case RuleAction.subDouble:
        scores[p] -= baseVal * 2;
        break;
      case RuleAction.subTriple:
        scores[p] -= baseVal * 3;
        break;
      case RuleAction.reset:
        scores[p] = 0;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isGameOver) return _buildWinScreen();

    bool isBullRound = widget.settings.mode != GameMode.cricket && round == 21;
    String centerText = isBullRound ? "BULL" : "$round";
    bool showPunishmentUI = widget.settings.mode == GameMode.normal &&
        widget.settings.missAction == RuleAction.missCustom;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.settings.mode == GameMode.cricket
            ? "CRICKET"
            : txt[widget.settings.presetKey]!),
        actions: [
          IconButton(
              icon: const Icon(Icons.undo),
              onPressed: _history.isEmpty ? null : _undo)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.players.length,
                itemBuilder: (c, i) => Container(
                  width: 100,
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: i == pIdx
                        ? Colors.green.withOpacity(0.2)
                        : Colors.white10,
                    border: i == pIdx
                        ? Border.all(color: Colors.green, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.players[i],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis),
                      Text("${scores[i]}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      if (widget.settings.mode == GameMode.cricket)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                3,
                                (d) => Icon(Icons.circle,
                                    size: 8,
                                    color: d < cricketHits[i]
                                        ? Colors.orange
                                        : Colors.grey[800])))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(txt['target']!,
                        style: const TextStyle(
                            color: Colors.grey, letterSpacing: 2)),
                    FittedBox(
                        child: Text(centerText,
                            style: const TextStyle(
                                fontSize: 120,
                                fontWeight: FontWeight.w900,
                                color: Colors.white))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (i) => Icon(Icons.circle,
                              size: 20,
                              color: i < dartsThrown
                                  ? Colors.green
                                  : Colors.grey[800])),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (showPunishmentUI)
                    Row(children: [
                      _btn(
                          txt['miss_board']!,
                          Colors.red[900]!,
                          () => _processThrow(
                              hitTarget: false, penaltyPoints: 100)),
                      const SizedBox(width: 10),
                      _btn(txt['wrong_field']!, Colors.red[700]!,
                          _showWrongFieldDialog),
                    ])
                  else
                    Row(children: [
                      _btn(txt['miss_next']!, Colors.red[900]!,
                          () => _processThrow(hitTarget: false)),
                    ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    if (isBullRound) ...[
                      _btn(txt['bull']!, Colors.green[800]!,
                          () => _processThrow(hitTarget: true, multiplier: 1)),
                      const SizedBox(width: 8),
                      _btn(txt['bullseye']!, Colors.red[900]!,
                          () => _processThrow(hitTarget: true, multiplier: 2)),
                    ] else ...[
                      _btn(txt['btn_single']!, Colors.blueGrey,
                          () => _processThrow(hitTarget: true, multiplier: 1)),
                      const SizedBox(width: 8),
                      _btn(txt['btn_double']!, Colors.orange[800]!,
                          () => _processThrow(hitTarget: true, multiplier: 2)),
                      const SizedBox(width: 8),
                      _btn(txt['btn_triple']!, Colors.purple[800]!,
                          () => _processThrow(hitTarget: true, multiplier: 3)),
                    ]
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(String txt, Color col, VoidCallback onTap) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: col, padding: EdgeInsets.zero),
          onPressed: onTap,
          child: Text(txt,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }

  void _showWrongFieldDialog() {
    int selectedMult = 1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(txt['dialog_title']!, textAlign: TextAlign.center),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _multChip(txt['btn_single']!, 1, selectedMult,
                            (v) => setStateDialog(() => selectedMult = v)),
                        _multChip(txt['btn_double']!, 2, selectedMult,
                            (v) => setStateDialog(() => selectedMult = v)),
                        _multChip(txt['btn_triple']!, 3, selectedMult,
                            (v) => setStateDialog(() => selectedMult = v)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 250,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8),
                        itemCount: 20,
                        itemBuilder: (c, i) {
                          int val = i + 1;
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[700],
                                padding: EdgeInsets.zero),
                            onPressed: () {
                              Navigator.pop(context);
                              int penalty = val * selectedMult;
                              _processThrow(
                                  hitTarget: false, penaltyPoints: penalty);
                            },
                            child: Text("$val",
                                style: const TextStyle(fontSize: 14)),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800]),
                            onPressed: () {
                              Navigator.pop(context);
                              _processThrow(
                                  hitTarget: false, penaltyPoints: 25);
                            },
                            child: Text(txt['bull']!,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900]),
                            onPressed: () {
                              Navigator.pop(context);
                              _processThrow(
                                  hitTarget: false, penaltyPoints: 50);
                            },
                            child: Text(txt['bullseye']!,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(txt['cancel']!))
              ],
            );
          },
        );
      },
    );
  }

  Widget _multChip(String label, int val, int current, Function(int) onTap) {
    bool isSel = val == current;
    return GestureDetector(
      onTap: () => onTap(val),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSel ? Colors.green : Colors.black26,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSel ? Colors.greenAccent : Colors.grey),
        ),
        child: Text(label,
            style: TextStyle(
                color: isSel ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildWinScreen() {
    int max = -99999;
    String wName = "";
    for (int i = 0; i < scores.length; i++) {
      if (scores[i] > max) {
        max = scores[i];
        wName = widget.players[i];
      }
    }

    String modeKey = widget.settings.presetKey;
    List<ScoreEntry> currentList = highScores[modeKey]!;

    bool isRecord = false;
    if (currentList.length < 3 || max > currentList.last.score) {
      isRecord = true;
    }
    if (currentList.isEmpty) isRecord = true;

    TextEditingController nameCtrl = TextEditingController(text: wName);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo, color: Colors.white, size: 30),
            onPressed: () {
              if (_history.isNotEmpty) _undo();
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              if (isRecord) ...[
                Text(txt['new_record']!,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: nameCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: txt['enter_name'],
                      filled: true,
                      fillColor: Colors.white10,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    highScores[modeKey]!.add(ScoreEntry(nameCtrl.text, max));
                    highScores[modeKey]!
                        .sort((a, b) => b.score.compareTo(a.score));
                    if (highScores[modeKey]!.length > 3) {
                      highScores[modeKey] = highScores[modeKey]!.sublist(0, 3);
                    }
                    Navigator.popUntil(context, (r) => r.isFirst);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LeaderboardScreen()));
                  },
                  child: Text(txt['save']!),
                )
              ] else ...[
                Text(txt['winner']!,
                    style: const TextStyle(fontSize: 24, color: Colors.grey)),
                Text(wName,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text("$max Points",
                    style: const TextStyle(color: Colors.green, fontSize: 24)),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15)),
                  onPressed: () =>
                      Navigator.popUntil(context, (r) => r.isFirst),
                  child: Text(txt['back_menu']!),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
