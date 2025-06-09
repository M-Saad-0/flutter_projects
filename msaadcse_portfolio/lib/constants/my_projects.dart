import 'package:msaadcse_portfolio/models/project.dart';

const myProjects = [
  Project(
    projectName: "NextGen AI Healthcare & Medical Rentals",
    description:
        "A full-stack mobile app built with Flutter and Node.js that allows users to rent medical equipment. Features include AI-based symptom diagnosis using TFLite and a medicine-specific chatbot powered by a Flask API.",
    picture: "images/healthcare.jpg",
    skillsUsed: ["Flutter","BLoC", "NodeJs", "Firebase", "TFLite", "Flask", "AI"],
    url: "https://github.com/M-Saad-0/nextgenai_healthcare_frontend/releases/tag/v1.0.0",
  ),
  Project(
    projectName: "TailorTape App",
    description:
        "A smart measuring app for tailors to store and manage customer body measurements using Flutter and Firebase Firestore. Includes both light and dark themes for a better user experience and clean modern UI.",
    picture: "images/tailortape.jpg",
    skillsUsed: ["Flutter", "Firebase", "Firestore", "Provider", "UI/UX", "Theming"],
    url: "https://github.com/M-Saad-0/flutter_projects/tree/main/tailortape-app",
  ),
  Project(
    projectName: "AI Chatbot App",
    description:
        "An interactive chatbot app that utilizes the Gemini API for smart replies. Built using Flutter and Hive for local message storage, the app also applies BLoC pattern for clean and reactive state management.",
    picture: "images/aichatbot.jpg",
    skillsUsed: ["Flutter", "Gemini API", "Hive", "AI", "BLoC"],
    url: "https://github.com/M-Saad-0/flutter_projects/tree/main/ai_chatbot",
  ),
  Project(
    projectName: "Tic-Tac-Toe App",
    description:
        "A feature-rich multiplayer Tic-Tac-Toe game built with Flutter. It supports customizable UI themes and persistent local score tracking using Shared Preferences, offering a smooth and personalized game experience.",
    picture: "images/tictactoe.jpg",
    skillsUsed: ["Flutter", "Shared Prefs", "Game Logic", "UI/UX"],
    url: "https://github.com/M-Saad-0", // Add GitHub or Play Store URL if available
  ),
];
