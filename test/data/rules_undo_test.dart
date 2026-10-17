import 'dart:convert';

import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// The rules stored on the match row follow undo/redo of a rules change.
void main() {
  test('undo and redo restore the stored rules', () async {
    final db = AppDb(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = MatchRepository(db);
    const original = MatchRules(oversPerInnings: 5, playersPerSide: 3);
    final id = await repo.startMatch(
      const MatchSetupData(
        rules: original,
        matchType: MatchType.standalone,
        teamAId: 'A',
        teamBId: 'B',
        xiA: ['a1', 'a2', 'a3'],
        xiB: ['b1', 'b2', 'b3'],
        battingFirstTeamId: 'A',
        strikerId: 'a1',
        nonStrikerId: 'a2',
        openingBowlerId: 'b1',
      ),
    );

    Future<MatchRules> stored() async => MatchRules.fromJson(
      jsonDecode((await repo.getMatch(id))!.rulesJson) as Map<String, dynamic>,
    );

    final changed = original.copyWith(oversPerInnings: 8, sixAndOut: true);
    await repo.appendEvent(id, GameEvent.rulesChanged(rules: changed));
    expect(await stored(), changed);

    await repo.undo(id);
    expect(await stored(), original);

    await repo.redo(id);
    expect(await stored(), changed);
  });
}
