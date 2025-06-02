// import 'package:flutter/material.dart';
// import 'package:portfolio/models/skill.dart';

// List<Skill> mySkill = [
//   Skill(
//     skillName: "Flutter",
//     iconUrl: "https://storage.googleapis.com/cms-storage-bucket/4fd5520fe28ebf839174.svg",
//     skillLevel: 0.80,
//     color: Colors.blue,
//   ),
//   Skill(
//     skillName: "Dart",
//     iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.png",
//     skillLevel: 0.85,
//     color: Colors.lightBlue,
//   ),
//   Skill(
//     skillName: "Git",
//     iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.png",
//     skillLevel: 0.65,
//     color: Colors.orange,
//   ),
//   Skill(
//     skillName: "Firebase",
//     iconUrl: "https://www.vectorlogo.zone/logos/firebase/firebase-icon.png",
//     skillLevel: 0.75,
//     color: Colors.deepOrange,
//   ),
//   Skill(
//     skillName: "NodeJs",
//     iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nodejs/nodejs-original.png",
//     skillLevel: 0.50,
//     color: Colors.green,
//   ),
//   Skill(
//     skillName: "Golang",
//     iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/go/go-original.png",
//     skillLevel: 0.45,
//     color: Color(0xFF00ADD8),
//   ),
//   Skill(
//     skillName: "MongoDB",
//     iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mongodb/mongodb-original.png",
//     skillLevel: 0.55,
//     color: Color(0xFF47A248),
//   ),
//   Skill(
//     skillName: "SQL",
//     iconUrl: "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original.png",
//     skillLevel: 0.45,
//     color: Color(0xFF00758F),
//   ),
//   // Skill(
//   //   skillName: "REST API",
//   //   iconUrl: "https://cdn-icons-png.flaticon.com/512/2374/2374424.png", // generic REST icon
//   //   skillLevel: 0.60,
//   //   color: Colors.teal,
//   // ),
//   Skill(
//     skillName: "BLoC",
//     iconUrl: "https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png",
//     skillLevel: 0.70,
//     color: Colors.indigo,
//   ),
// ];


import 'package:flutter/material.dart';
import 'package:portfolio/constants/svgs.dart';
import 'package:portfolio/models/skill.dart';

List<Skill> mySkill = [
  Skill(skillName: "Flutter", iconUrl: flutter, skillLevel: 0.80, color: Colors.blue),
  Skill(skillName: "Dart", iconUrl: dart, skillLevel: 0.85, color: Colors.lightBlue),
  Skill(skillName: "Git", iconUrl: git, skillLevel: 0.65, color: Colors.deepOrange),
  Skill(skillName: "Firebase", iconUrl: firebase, skillLevel: 0.75, color: Colors.orange),
  Skill(skillName: "NodeJs", iconUrl: nodejs, skillLevel: 0.50, color: Colors.green),
  Skill(skillName: "Golang", iconUrl: golang, skillLevel: 0.45, color: Color(0xFF00ADD8)),
  Skill(skillName: "MongoDB", iconUrl: mongodb, skillLevel: 0.55, color: Color(0xFF47A248)),
  Skill(skillName: "SQL", iconUrl: sql, skillLevel: 0.45, color: Color(0xFF00758F)),
  Skill(skillName: "BLoC", iconUrl: bloc, skillLevel: 0.70, color: Colors.indigo),
];


final skillLogoMap = {
"Flutter":flutter,
"Dart":dart,
"Git":git,
"Firebase":firebase,
"NodeJs":nodejs,
"Golang":golang,
"MongoDB":mongodb,
"SQL":sql,
"BLoC":bloc,
};

// https://www.vectorlogo.zone/?q=