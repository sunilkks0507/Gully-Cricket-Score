import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a retired-out dismissal persists and undoes cleanly', () async {
    final db = AppDb(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = MatchRepository(db);
    final id = await repo.startMatch(
      const MatchSetupData(
        rules: MatchRules(oversPerInnings: 2, playersPerSide: 3),
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

    await repo.appendEvent(
      id,
      const GameEvent.dismissalWithoutBall(
        inningsIndex: 0,
        wicket: Wicket(type: DismissalType.retiredOut, outBatterId: 'a1'),
        newBatterId: 'a3',
      ),
    );
    var inn = (await repo.loadState(id)).activeInnings!;
    expect(inn.wickets, 1);
    expect(inn.legalBalls, 0);
    expect(inn.strikerId, 'a3');

    await repo.undo(id);
    inn = (await repo.loadState(id)).activeInnings!;
    expect(inn.wickets, 0);
    expect(inn.strikerId, 'a1');
  });
}
