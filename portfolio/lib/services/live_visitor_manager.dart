// import 'package:firebase_database/firebase_database.dart';
// import 'package:uuid/uuid.dart';

// class LiveVisitorManager {
//   final _db = FirebaseDatabase.instance.ref();
//   final String _sessionId = const Uuid().v4();

//   Future<void> connect() async {
//     final sessionRef = _db.child("liveSessions/$_sessionId");

//     // Set this user's session
//     await sessionRef.set(true);

//     // Setup onDisconnect to remove this user's session
//     sessionRef.onDisconnect().remove();

//     // Update total count (optional, since we can count sessions live)
//     _updateLiveVisitorCount();
//   }

//   Future<void> _updateLiveVisitorCount() async {
//     final sessionsRef = _db.child("liveSessions");

//     // Listen for session count changes and update the count node
//     sessionsRef.onValue.listen((event) {
//       final count = (event.snapshot.value as Map?)?.length ?? 0;
//       _db.child("visitors/live_visitors").set(count);
//     });
//   }

//   // Optional: cleanup (not required due to onDisconnect)
//   Future<void> disconnect() async {
//     await _db.child("liveSessions/$_sessionId").remove();
//   }
// }
