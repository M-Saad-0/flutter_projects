import 'dart:io' show Platform;
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class LiveVisitorManager {
  final _db = FirebaseDatabase.instance.ref();
  final String _sessionId = const Uuid().v4();

  Future<void> connect() async {
    final sessionRef = _db.child("liveSessions/$_sessionId");

    // Set this user's session
    await sessionRef.set(true);

    // Setup onDisconnect to remove this user's session
    sessionRef.onDisconnect().remove();

    // Update total count
    _updateLiveVisitorCount();
  }

  Future<void> _updateLiveVisitorCount() async {
    final sessionsRef = _db.child("liveSessions");

    try {
      // Listen for session count changes and update the count node
      sessionsRef.onValue.listen(
        (event) {
          final snapshot = event.snapshot;
          final count = (snapshot.value as Map?)?.length ?? 0;
          _db.child("visitors/live_visitors").set(count);
        },
        onError: (error) {
          print("Error in onValue listener: $error");
        },
      );
    } catch (e) {
      print("Failed to set up live visitor count listener: $e");
    }
  }

  Future<void> disconnect() async {
    await _db.child("liveSessions/$_sessionId").remove();
  }
}