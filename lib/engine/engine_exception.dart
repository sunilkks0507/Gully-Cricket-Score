/// Thrown by the scoring engine when an event is illegal for the current state
/// or rules (see docs/04-scoring-engine-spec.md §7). Pure Dart — no Flutter.
class EngineException implements Exception {
  const EngineException(this.message);

  final String message;

  @override
  String toString() => 'EngineException: $message';
}
