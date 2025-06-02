import 'package:flutter/material.dart';
import 'package:portfolio/constants/svgs.dart';

const myContacts = {
  "GitHub": "https://github.com/M-Saad-0",
  "LinkedIn": "https://www.linkedin.com/in/muhammad-saad-a583b9230/",
  "Email": "mailto:msaad97.se@gmail.com",
  "Phone": "tel:+923079374165",
};

String getLogo(String logo) =>
    {
      "GitHub":
          
               github,
      "LinkedIn": linkedin,
      "Email": gmail,
      "Phone": whatsapp,
    }[logo] ??
    "";
