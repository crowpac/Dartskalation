import 'package:flutter/material.dart';
import 'dart:math';

// --- SPRACH-KONFIGURATION ---
final ValueNotifier<bool> isGermanNotifier = ValueNotifier(false);
final ValueNotifier<String> autodartsIpNotifier = ValueNotifier("192.168.178.50");

// --- HIGHSCORE DATENMODELL ---
class ScoreEntry {
  String name;
  int score;
  ScoreEntry(this.name, this.score);
}

// --- SPIELER DATENMODELL ---
class Player {
  String name;
  RuleAction doubleAction;
  RuleAction tripleAction;
  RuleAction missAction;
  int lives;

  Player({
    required this.name,
    required this.doubleAction,
    required this.tripleAction,
    required this.missAction,
    this.lives = 3,
  });
}

// --- GLOBALER HIGHSCORE SPEICHER ---
Map<String, List<ScoreEntry>> highScores = {
  'mode_normal': [],
  'mode_stop': [],
  'mode_punish': [],
  'mode_hardcore': [],
  'mode_cricket': [],
  'mode_custom': [],
  'mode_br_classic': [],
  'mode_br_tornado': [],
  'mode_br_shrink': [],
};

Map<String, String> get txt => isGermanNotifier.value ? _de : _en;

// --- DEUTSCHE TEXTE ---
final Map<String, String> _de = {
  'title': 'DARTSKALATION',
  'made_by': 'Made by Aikill Beens',
  'rule_title': 'GRUNDREGEL',
  'rules_hint': 'Runde 1: Triff 1.\nRunde 2: Triff 2.\n...\nRunde 21: BULLSEYE.\nNur das Ziel zählt!',
  'mode_normal': 'NORMAL',
  'mode_stop': 'RUNDE STOPPEN',
  'mode_punish': 'BESTRAFUNG',
  'mode_hardcore': 'HARDCORE',
  'mode_cricket': 'CRICKET',
  'mode_custom': 'MATRIX',
  'mode_battle_royale': 'BATTLE ROYALE',
  'mode_br_classic': 'CLASSIC',
  'mode_br_tornado': 'TORNADO',
  'mode_br_shrink': 'SCHRUMPF',
  'info_normal': 'Punkte sammeln. Keine Strafen.',
  'info_stop': 'Fehlwurf = Sofort Rundenende!',
  'info_punish': 'Falsches Feld = Punktabzug!',
  'info_hardcore': 'Fehler = Alles auf 0!',
  'info_cricket': '3x treffen, dann punkten.',
  'info_custom': 'Deine eigenen Regeln.',
  'info_battle_royale': 'Flüchte in die Safe Zone.',
  'info_br_classic': 'Die Todeszone wächst 1-20.',
  'info_br_tornado': 'Zufällige Todesfelder.',
  'info_br_shrink': 'Das Board schrumpft.',
  'btn_leaderboard': 'BESTENLISTE',
  'leaderboard_title': 'TOP 3 REKORDE',
  'leaderboard_reset': 'Alles Löschen',
  'no_records': 'Noch keine Einträge.',
  'desc_normal': 'Klassisches Spiel. Punkte sammeln. Keine Strafen.',
  'desc_stop': 'Ziel verfehlt? Runde sofort vorbei!',
  'desc_punish': 'Falsches Feld? Punktabzug! Board verfehlt? -100 Punkte!',
  'desc_hardcore': 'Nichts oder Falsches getroffen? PUNKTE RESET AUF 0!',
  'desc_cricket': '3 Treffer öffnen das Feld für Punkte.',
  'desc_custom': 'Eigene Matrix-Regeln aktiv. Siehe oben.',
  'desc_br_classic': 'Classic: Die Danger Zone startet bei 1 und wächst jede Runde bis 20.',
  'desc_br_tornado': 'Tornado: Jede Runde kommt ein zufälliges Feld zur Danger Zone hinzu.',
  'desc_br_shrink': 'Schrumpf: Die Safe Zone wandert jede Runde weiter nach innen.',
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
  'ip_title': 'Autodarts IP',
  'br_safe': 'SAFE ZONE\n(Runde überlebt!)',
  'br_danger': 'DANGER ZONE\n(-1 Pfeil!)',
  'br_danger_title': 'DANGER ZONE:',
  'br_eliminated': 'ELIMINIERT',
  'br_shrink_1': 'DOPPEL & AUSSEN',
  'br_shrink_2': 'ÄUSSERER SINGLE-RING',
  'br_shrink_3': 'TRIPLE-RING',
  'br_shrink_4': 'INNERER SINGLE-RING',
  'br_shrink_5': 'ALLES AUSSER BULL',
};

// --- ENGLISCHE TEXTE ---
final Map<String, String> _en = {
  'title': 'DARTSKALATION',
  'made_by': 'Made by Aikill Beens',
  'rule_title': 'BASE RULE',
  'rules_hint': 'Round 1: Hit 1.\nRound 2: Hit 2.\n...\nRound 21: BULLSEYE.\nOnly target counts!',
  'mode_normal': 'NORMAL',
  'mode_stop': 'ROUND STOP',
  'mode_punish': 'PUNISHMENT',
  'mode_hardcore': 'HARDCORE',
  'mode_cricket': 'CRICKET',
  'mode_custom': 'MATRIX',
  'mode_battle_royale': 'BATTLE ROYALE',
  'mode_br_classic': 'CLASSIC',
  'mode_br_tornado': 'TORNADO',
  'mode_br_shrink': 'SHRINK',
  'info_normal': 'Just points. No penalties.',
  'info_stop': 'Miss target = Turn over!',
  'info_punish': 'Wrong field = Minus points!',
  'info_hardcore': 'Any mistake = Reset to 0!',
  'info_cricket': 'Hit 3x, then score.',
  'info_custom': 'Your own custom rules.',
  'info_battle_royale': 'Escape to the safe zone.',
  'info_br_classic': 'Death zone grows 1-20.',
  'info_br_tornado': 'Random death zones.',
  'info_br_shrink': 'The board is shrinking.',
  'btn_leaderboard': 'LEADERBOARD',
  'leaderboard_title': 'TOP 3 RECORDS',
  'leaderboard_reset': 'Reset All',
  'no_records': 'No records yet.',
  'desc_normal': 'Classic Game. Collect points. No penalties.',
  'desc_stop': 'Miss the target? Turn ends immediately!',
  'desc_punish': 'Wrong field? Points deduction! Miss board? -100 Points!',
  'desc_hardcore': 'Hit nothing or wrong field? FULL SCORE RESET TO 0!',
  'desc_cricket': 'Hit 3x to open scoring.',
  'desc_custom': 'Custom Matrix Rules active. Check settings above.',
  'desc_br_classic': 'Classic: Danger Zone starts at 1 and grows up to 20.',
  'desc_br_tornado': 'Tornado: Random fields become Danger Zones every round.',
  'desc_br_shrink': 'Shrink: Safe zone is getting smaller every round.',
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
  'ip_title': 'Autodarts IP',
  'br_safe': 'SAFE ZONE\n(Survived!)',
  'br_danger': 'DANGER ZONE\n(-1 Dart!)',
  'br_danger_title': 'DANGER ZONE:',
  'br_eliminated': 'ELIMINATED',
  'br_shrink_1': 'DOUBLE & MISS',
  'br_shrink_2': 'OUTER SINGLE-RING',
  'br_shrink_3': 'TRIPLE-RING',
  'br_shrink_4': 'INNER SINGLE-RING',
  'br_shrink_5': 'ALL EXCEPT BULL',
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
            primaryColor: Colors.green,
            scaffoldBackgroundColor: const Color(0xFF121212),
            colorScheme: const ColorScheme.dark(
              primary: Colors.green,
              secondary: Colors.greenAccent,
              surface: Color(0xFF1E1E1E),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            dialogBackgroundColor: const Color(0xFF2C2C2C),
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}

enum GameMode { normal, cricket, battleRoyale }

enum RuleAction {
  addSingle, addDouble, addTriple, subSingle, subDouble, subTriple, stop, reset, missCustom, continueZero
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
  HomeScreen({super.key});

  void _showIpDialog(BuildContext context) {
    TextEditingController ipCtrl = TextEditingController(text: autodartsIpNotifier.value);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(txt['ip_title']!),
        content: TextField(
          controller: ipCtrl,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "192.168.X.X"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(txt['cancel']!)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              autodartsIpNotifier.value = ipCtrl.text;
              Navigator.pop(context);
            },
            child: Text(txt['save']!),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        actions: [
          IconButton(
            icon: const Icon(Icons.wifi, color: Colors.blueAccent, size: 24),
            onPressed: () => _showIpDialog(context),
          ),
          TextButton.icon(
            onPressed: () => isGermanNotifier.value = !isGermanNotifier.value,
            icon: const Icon(Icons.language, color: Colors.greenAccent, size: 20),
            label: Text(isGermanNotifier.value ? "DE" : "EN",
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.track_changes, size: 44, color: Colors.green),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(txt['title']!, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1, color: Colors.white)),
                          ),
                          Text(txt['made_by']!, style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(txt['rule_title']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber, fontSize: 11, letterSpacing: 1)),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(txt['rules_hint']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 11, height: 1.3)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: _modeButton(context, 'mode_normal', 'info_normal', Colors.green[800]!, Icons.sports_score, isHero: true),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _modeButton(context, 'mode_stop', 'info_stop', Colors.blueGrey[700]!, Icons.pan_tool)),
                          const SizedBox(width: 8),
                          Expanded(child: _modeButton(context, 'mode_punish', 'info_punish', Colors.orange[900]!, Icons.gavel)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _modeButton(context, 'mode_hardcore', 'info_hardcore', Colors.red[900]!, Icons.local_fire_department)),
                          const SizedBox(width: 8),
                          Expanded(child: _modeButton(context, 'mode_cricket', 'info_cricket', Colors.purple[800]!, Icons.grid_3x3)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _modeButton(context, 'mode_custom', 'info_custom', Colors.grey[800]!, Icons.tune)),
                          const SizedBox(width: 8),
                          Expanded(child: _modeButton(context, 'mode_battle_royale', 'info_battle_royale', Colors.red[800]!, Icons.shield)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[900],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaderboardScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.emoji_events, color: Colors.white, size: 28),
                            const SizedBox(width: 10),
                            Text(txt['btn_leaderboard']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      ),
    );
  }

  Widget _modeButton(BuildContext context, String titleKey, String infoKey, Color col, IconData iconData, {bool isHero = false}) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: col,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        ),
        onPressed: () {
          if (titleKey == 'mode_battle_royale') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const BattleRoyaleSelectionScreen()));
            return;
          }

          GameSettings settings = GameSettings()..presetKey = titleKey;
          if (titleKey == 'mode_cricket') {
            settings.mode = GameMode.cricket;
            settings.descKey = 'desc_cricket';
          } else {
            settings.mode = GameMode.normal;
            if (titleKey == 'mode_normal') {
              settings.missAction = RuleAction.continueZero;
              settings.descKey = 'desc_normal';
            } else if (titleKey == 'mode_stop') {
              settings.missAction = RuleAction.stop;
              settings.descKey = 'desc_stop';
            } else if (titleKey == 'mode_punish') {
              settings.missAction = RuleAction.missCustom;
              settings.descKey = 'desc_punish';
            } else if (titleKey == 'mode_hardcore') {
              settings.missAction = RuleAction.reset;
              settings.descKey = 'desc_hardcore';
            } else {
              settings.missAction = RuleAction.continueZero;
              settings.descKey = 'desc_custom';
            }
          }
          Navigator.push(context, MaterialPageRoute(builder: (_) => SetupScreen(settings: settings)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: Colors.white, size: isHero ? 32 : 24),
            const SizedBox(height: 4),
            Text(txt[titleKey]!, style: TextStyle(fontSize: isHero ? 20 : 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 2),
            Text(txt[infoKey]!, textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: isHero ? 12 : 9, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}

class BattleRoyaleSelectionScreen extends StatelessWidget {
  const BattleRoyaleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(txt['mode_battle_royale']!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _brButton(context, 'mode_br_classic', 'info_br_classic', Colors.teal[800]!, Icons.shield)),
            const SizedBox(height: 12),
            Expanded(child: _brButton(context, 'mode_br_tornado', 'info_br_tornado', Colors.deepPurple[900]!, Icons.storm)),
            const SizedBox(height: 12),
            Expanded(child: _brButton(context, 'mode_br_shrink', 'info_br_shrink', Colors.red[800]!, Icons.compress)),
          ],
        ),
      ),
    );
  }

  Widget _brButton(BuildContext context, String key, String info, Color col, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: col, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          GameSettings settings = GameSettings()
            ..mode = GameMode.battleRoyale
            ..presetKey = key
            ..descKey = 'desc_$key';
          Navigator.push(context, MaterialPageRoute(builder: (_) => SetupScreen(settings: settings)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(txt[key]!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(txt[info]!, style: const TextStyle(fontSize: 14, color: Colors.white70, fontStyle: FontStyle.italic)),
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
  final List<Player> _players = [];
  final TextEditingController _ctrl = TextEditingController();

  void _addPlayer() {
    if (_ctrl.text.trim().isNotEmpty) {
      setState(() {
        _players.add(Player(
          name: _ctrl.text.trim(),
          doubleAction: widget.settings.doubleAction,
          tripleAction: widget.settings.tripleAction,
          missAction: widget.settings.missAction,
        ));
      });
      _ctrl.clear();
    }
  }

  String _getRuleLabel(RuleAction action) {
    switch (action) {
      case RuleAction.addSingle: return 'x1';
      case RuleAction.addDouble: return 'x2';
      case RuleAction.addTriple: return 'x3';
      case RuleAction.subSingle: return '-x1';
      case RuleAction.subDouble: return '-x2';
      case RuleAction.subTriple: return '-x3';
      case RuleAction.stop: return 'Stop';
      case RuleAction.reset: return '0';
      case RuleAction.missCustom: return '-Pts';
      case RuleAction.continueZero: return '0 Pts';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isBR = widget.settings.mode == GameMode.battleRoyale;
    bool isCustom = widget.settings.presetKey == 'mode_custom';
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("${txt['setup_title']}${txt[widget.settings.presetKey] ?? ''}")),
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
                      Text(txt['custom_rules']!, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _buildDropdown(txt['rule_double']!, widget.settings.doubleAction, (v) => setState(() => widget.settings.doubleAction = v!), isMiss: false),
                      _buildDropdown(txt['rule_triple']!, widget.settings.tripleAction, (v) => setState(() => widget.settings.tripleAction = v!), isMiss: false),
                      _buildDropdown(txt['rule_miss']!, widget.settings.missAction, (v) => setState(() => widget.settings.missAction = v!), isMiss: true),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white24),
            ] else if (widget.settings.descKey.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.redAccent.withOpacity(0.5))),
                  child: Text(txt[widget.settings.descKey] ?? "", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: txt['player_name'],
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(icon: const Icon(Icons.add_circle, color: Colors.green, size: 32), onPressed: _addPlayer),
                      ),
                      onSubmitted: (_) => _addPlayer(),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _players.length,
                      itemBuilder: (c, i) => ListTile(
                        title: Text(_players[i].name, style: const TextStyle(fontSize: 20)),
                        subtitle: isBR 
                            ? Row(children: List.generate(3, (idx) => const Icon(Icons.favorite, color: Colors.redAccent, size: 16)))
                            : (isCustom ? Text("D: ${_getRuleLabel(_players[i].doubleAction)} | T: ${_getRuleLabel(_players[i].tripleAction)} | Miss: ${_getRuleLabel(_players[i].missAction)}", style: TextStyle(color: Colors.greenAccent.withOpacity(0.8), fontSize: 11)) : null),
                        leading: CircleAvatar(backgroundColor: Colors.grey[800], child: Text("${i + 1}")),
                        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => setState(() => _players.removeAt(i))),
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
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _players.isEmpty ? null : () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => GameScreen(players: _players, settings: widget.settings)));
                  },
                  child: Text(txt['start_game']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, RuleAction current, Function(RuleAction?) onChanged, {required bool isMiss}) {
    List<DropdownMenuItem<RuleAction>> items = [];

    if (isMiss) {
      items = [
        DropdownMenuItem(value: RuleAction.continueZero, child: Text(txt['dd_cont0']!)),
        DropdownMenuItem(value: RuleAction.stop, child: Text(txt['dd_stop']!)),
        DropdownMenuItem(value: RuleAction.missCustom, child: Text(txt['dd_miss']!)),
        DropdownMenuItem(value: RuleAction.reset, child: Text(txt['dd_reset']!)),
      ];
    } else {
      items = [
        DropdownMenuItem(value: RuleAction.addSingle, child: Text(txt['dd_x1']!)),
        DropdownMenuItem(value: RuleAction.addDouble, child: Text(txt['dd_x2']!)),
        DropdownMenuItem(value: RuleAction.addTriple, child: Text(txt['dd_x3']!)),
        DropdownMenuItem(value: RuleAction.subSingle, child: Text(txt['dd_mx1']!)),
        DropdownMenuItem(value: RuleAction.subDouble, child: Text(txt['dd_mx2']!)),
        DropdownMenuItem(value: RuleAction.subTriple, child: Text(txt['dd_mx3']!)),
        DropdownMenuItem(value: RuleAction.stop, child: Text(txt['dd_stop']!)),
        DropdownMenuItem(value: RuleAction.reset, child: Text(txt['dd_reset']!)),
        DropdownMenuItem(value: RuleAction.continueZero, child: Text(txt['dd_cont0']!)),
        DropdownMenuItem(value: RuleAction.missCustom, child: Text(txt['dd_miss']!)),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          DropdownButton<RuleAction>(value: current, items: items, onChanged: onChanged),
        ],
      ),
    );
  }
}

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
              child: Text(txt['leaderboard_title']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
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
                          Text(txt[entry.key] ?? entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.greenAccent)),
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
                                  SizedBox(width: 30, child: Text(medal, style: const TextStyle(fontSize: 18))),
                                  Expanded(child: Text(score.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                                  Text("${score.score} Pts", style: const TextStyle(fontWeight: FontWeight.bold)),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
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

class GameScreen extends StatefulWidget {
  final List<Player> players;
  final GameSettings settings;
  const GameScreen({super.key, required this.players, required this.settings});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<int> scores;
  late List<int> cricketHits;
  late List<bool> isEliminated;
  late List<int> tornadoFields;
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
    isEliminated = List.filled(widget.players.length, false);
    tornadoFields = [];
    if (widget.settings.presetKey == 'mode_br_tornado') {
      _generateTornadoField();
    }
  }

  void _generateTornadoField() {
    List<int> available = List.generate(20, (i) => i + 1).where((e) => !tornadoFields.contains(e)).toList();
    if (available.isNotEmpty) {
      tornadoFields.add(available[Random().nextInt(available.length)]);
    }
  }

  void _saveState() {
    _history.add({
      'scores': List<int>.from(scores),
      'cricketHits': List<int>.from(cricketHits),
      'isEliminated': List<bool>.from(isEliminated),
      'tornadoFields': List<int>.from(tornadoFields),
      'pIdx': pIdx,
      'round': round,
      'dartsThrown': dartsThrown,
      'isGameOver': isGameOver,
      'lives': widget.players.map((p) => p.lives).toList(),
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    final last = _history.removeLast();
    setState(() {
      scores = List<int>.from(last['scores']);
      cricketHits = List<int>.from(last['cricketHits']);
      isEliminated = List<bool>.from(last['isEliminated']);
      tornadoFields = List<int>.from(last['tornadoFields']);
      pIdx = last['pIdx'];
      round = last['round'];
      dartsThrown = last['dartsThrown'];
      isGameOver = last['isGameOver'];
      List<int> oldLives = List<int>.from(last['lives']);
      for (int i = 0; i < widget.players.length; i++) {
        widget.players[i].lives = oldLives[i];
      }
    });
  }

  void _processThrow({required bool hitTarget, int multiplier = 1, int penaltyPoints = 0}) {
    if (isGameOver) return;
    _saveState();
    setState(() {
      int p = pIdx;
      bool forceTurnEnd = false;
      int targetVal = (widget.settings.mode != GameMode.cricket && round == 21) ? 25 : round;

      if (widget.settings.mode == GameMode.battleRoyale) {
        if (hitTarget) { // SAFE ZONE GETROFFEN
          dartsThrown = 0;
          forceTurnEnd = true;
          scores[p] += round; // Bonus für Überleben
        } else { // DANGER ZONE GETROFFEN
          dartsThrown++; // Verliert 1 von 3 Pfeilen
          if (dartsThrown >= 3) {
            isEliminated[p] = true;
            dartsThrown = 0;
            forceTurnEnd = true;
          }
        }
      } else if (widget.settings.mode == GameMode.cricket) {
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
          if (multiplier == 2) action = widget.players[p].doubleAction;
          if (multiplier == 3) action = widget.players[p].tripleAction;

          if (action == RuleAction.missCustom) {
            _processThrow(hitTarget: false, penaltyPoints: targetVal * multiplier);
            return;
          }

          _applyRule(p, action, targetVal);
          if (action == RuleAction.stop) forceTurnEnd = true;
          if (action == RuleAction.reset) scores[p] = 0;
        } else {
          if (penaltyPoints != 0) {
            scores[p] -= penaltyPoints;
          } else {
            if (widget.players[p].missAction == RuleAction.reset) {
              if (scores[p] > 0) scores[p] = 0;
            }
            if (widget.players[p].missAction == RuleAction.stop) forceTurnEnd = true;
          }
        }
      }
      
      if (forceTurnEnd && widget.settings.mode != GameMode.battleRoyale) {
        dartsThrown = 3;
      } else if (widget.settings.mode != GameMode.battleRoyale) {
        dartsThrown++;
      }
      
      if (widget.settings.mode == GameMode.cricket) {
        if (cricketHits.every((h) => h >= 3)) {
          round++;
          cricketHits = List.filled(widget.players.length, 0);
          if (round > 20) isGameOver = true;
        }
      }
      
      if (forceTurnEnd || (widget.settings.mode != GameMode.battleRoyale && dartsThrown >= 3)) {
        dartsThrown = 0;
        
        do {
          pIdx++;
          if (pIdx >= widget.players.length) {
            pIdx = 0;
            if (widget.settings.mode != GameMode.cricket) {
              round++;
              if (widget.settings.presetKey == 'mode_br_tornado') _generateTornadoField();
              if (round > 21 && widget.settings.mode != GameMode.battleRoyale) isGameOver = true;
            }
          }
        } while (widget.settings.mode == GameMode.battleRoyale && isEliminated[pIdx] && isEliminated.where((e) => !e).length > 1);

        if (widget.settings.mode == GameMode.battleRoyale) {
          if (isEliminated.where((e) => !e).length <= 1) {
            isGameOver = true;
          }
        }
      }
    });
  }

  void _applyRule(int p, RuleAction action, int baseVal) {
    switch (action) {
      case RuleAction.addSingle: scores[p] += baseVal; break;
      case RuleAction.addDouble: scores[p] += baseVal * 2; break;
      case RuleAction.addTriple: scores[p] += baseVal * 3; break;
      case RuleAction.subSingle: scores[p] -= baseVal; break;
      case RuleAction.subDouble: scores[p] -= baseVal * 2; break;
      case RuleAction.subTriple: scores[p] -= baseVal * 3; break;
      case RuleAction.reset: if (scores[p] > 0) scores[p] = 0; break;
      default: break;
    }
  }

  String _getBRCenterText() {
    if (widget.settings.presetKey == 'mode_br_classic') {
      int maxD = round > 20 ? 20 : round;
      if (maxD == 1) return "1";
      return "1 - $maxD";
    } else if (widget.settings.presetKey == 'mode_br_shrink') {
      if (round == 1) return txt['br_shrink_1']!;
      if (round == 2) return txt['br_shrink_2']!;
      if (round == 3) return txt['br_shrink_3']!;
      if (round == 4) return txt['br_shrink_4']!;
      return txt['br_shrink_5']!;
    } else if (widget.settings.presetKey == 'mode_br_tornado') {
      return tornadoFields.join(', ');
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    if (isGameOver) return _buildWinScreen();

    bool isBullRound = widget.settings.mode != GameMode.cricket && round == 21;
    String centerText = isBullRound ? "BULL" : "$round";
    bool showPunishmentUI = widget.settings.mode == GameMode.normal && widget.players[pIdx].missAction == RuleAction.missCustom;
    bool isBR = widget.settings.mode == GameMode.battleRoyale;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.settings.mode == GameMode.cricket ? "CRICKET" : txt[widget.settings.presetKey] ?? ''),
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: _history.isEmpty ? null : _undo)
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
                    color: isEliminated[i] && isBR 
                        ? Colors.black54 
                        : (i == pIdx ? Colors.green.withOpacity(0.2) : Colors.white10),
                    border: i == pIdx ? Border.all(color: Colors.green, width: 2) : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.players[i].name, style: TextStyle(fontWeight: FontWeight.bold, decoration: (isEliminated[i] && isBR) ? TextDecoration.lineThrough : null, color: (isEliminated[i] && isBR) ? Colors.red : Colors.white), overflow: TextOverflow.ellipsis),
                      if (!isBR) Text("${scores[i]}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      if (widget.settings.mode == GameMode.cricket)
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3, (d) => Icon(Icons.circle, size: 8, color: d < cricketHits[i] ? Colors.orange : Colors.grey[800]))),
                      if (isBR)
                        isEliminated[i] 
                        ? Text(txt['br_eliminated']!, style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold))
                        : Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3 - (i == pIdx ? dartsThrown : 0), (d) => const Icon(Icons.favorite, size: 16, color: Colors.greenAccent)))
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
                    if (isBR) Text(txt['br_danger_title']!, style: const TextStyle(color: Colors.redAccent, letterSpacing: 2, fontSize: 18, fontWeight: FontWeight.bold))
                    else Text(txt['target']!, style: const TextStyle(color: Colors.grey, letterSpacing: 2)),
                    const SizedBox(height: 10),
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(isBR ? _getBRCenterText() : centerText, textAlign: TextAlign.center, style: TextStyle(fontSize: isBR ? 60 : 120, fontWeight: FontWeight.w900, color: isBR ? Colors.red : Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (!isBR)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (i) => Icon(Icons.circle, size: 20, color: i < dartsThrown ? Colors.green : Colors.grey[800])),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (isBR)
                    Row(children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                            onPressed: () => _processThrow(hitTarget: false),
                            child: Text(txt['br_danger']!, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                            onPressed: () => _processThrow(hitTarget: true),
                            child: Text(txt['br_safe']!, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                    ])
                  else ...[
                    if (showPunishmentUI)
                      Row(children: [
                        _btn(txt['miss_board']!, Colors.red[900]!, () => _processThrow(hitTarget: false, penaltyPoints: 100)),
                        const SizedBox(width: 10),
                        _btn(txt['wrong_field']!, Colors.red[700]!, _showWrongFieldDialog),
                      ])
                    else
                      Row(children: [
                        _btn(txt['miss_next']!, Colors.red[900]!, () => _processThrow(hitTarget: false)),
                      ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      if (isBullRound) ...[
                        _btn(txt['bull']!, Colors.green[800]!, () => _processThrow(hitTarget: true, multiplier: 1)),
                        const SizedBox(width: 8),
                        _btn(txt['bullseye']!, Colors.red[900]!, () => _processThrow(hitTarget: true, multiplier: 2)),
                      ] else ...[
                        _btn(txt['btn_single']!, Colors.blueGrey, () => _processThrow(hitTarget: true, multiplier: 1)),
                        const SizedBox(width: 8),
                        _btn(txt['btn_double']!, Colors.orange[800]!, () => _processThrow(hitTarget: true, multiplier: 2)),
                        const SizedBox(width: 8),
                        _btn(txt['btn_triple']!, Colors.purple[800]!, () => _processThrow(hitTarget: true, multiplier: 3)),
                      ]
                    ]),
                  ]
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
          style: ElevatedButton.styleFrom(backgroundColor: col, padding: EdgeInsets.zero),
          onPressed: onTap,
          child: Text(txt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                        _multChip(txt['btn_single']!, 1, selectedMult, (v) => setStateDialog(() => selectedMult = v)),
                        _multChip(txt['btn_double']!, 2, selectedMult, (v) => setStateDialog(() => selectedMult = v)),
                        _multChip(txt['btn_triple']!, 3, selectedMult, (v) => setStateDialog(() => selectedMult = v)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 250,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, mainAxisSpacing: 8, crossAxisSpacing: 8),
                        itemCount: 20,
                        itemBuilder: (c, i) {
                          int val = i + 1;
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700], padding: EdgeInsets.zero),
                            onPressed: () {
                              Navigator.pop(context);
                              int penalty = val * selectedMult;
                              _processThrow(hitTarget: false, penaltyPoints: penalty);
                            },
                            child: Text("$val", style: const TextStyle(fontSize: 14)),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
                            onPressed: () {
                              Navigator.pop(context);
                              _processThrow(hitTarget: false, penaltyPoints: 25);
                            },
                            child: Text(txt['bull']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
                            onPressed: () {
                              Navigator.pop(context);
                              _processThrow(hitTarget: false, penaltyPoints: 50);
                            },
                            child: Text(txt['bullseye']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text(txt['cancel']!))
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
        child: Text(label, style: TextStyle(color: isSel ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildWinScreen() {
    int max = -99999;
    String wName = "";
    
    if (widget.settings.mode == GameMode.battleRoyale) {
      for (int i = 0; i < widget.players.length; i++) {
        if (!isEliminated[i]) {
          wName = widget.players[i].name;
          max = scores[i];
        }
      }
    } else {
      for (int i = 0; i < scores.length; i++) {
        if (scores[i] > max) {
          max = scores[i];
          wName = widget.players[i].name;
        }
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
                Text(txt['new_record']!, style: const TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold)),
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
                    highScores[modeKey]!.sort((a, b) => b.score.compareTo(a.score));
                    if (highScores[modeKey]!.length > 3) {
                      highScores[modeKey] = highScores[modeKey]!.sublist(0, 3);
                    }
                    Navigator.popUntil(context, (r) => r.isFirst);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaderboardScreen()));
                  },
                  child: Text(txt['save']!),
                )
              ] else ...[
                Text(txt['winner']!, style: const TextStyle(fontSize: 24, color: Colors.grey)),
                Text(wName, style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("$max Points", style: const TextStyle(color: Colors.green, fontSize: 24)),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                  onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
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
