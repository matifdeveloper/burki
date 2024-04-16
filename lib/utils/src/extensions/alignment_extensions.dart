/*
********************************************************************************

    _____/\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_
    ___/\\\\\\\\\\\\\__\///////\\\/////__\/////\\\///__\/\\\///////////__
    __/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\\\\\\\\\_____
    _\/\\\\\\\\\\\\\\\_______\/\\\___________\/\\\_____\/\\\///////______
    _\/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\________/\\\\\\\\\\\_\/\\\_____________
    _\///________\///________\///________\///////////__\///______________

    Created by Muhammad Atif on 4/16/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'package:flutter/widgets.dart';

extension AlignmentExtensions on Alignment {
  // Custom alignment method to center horizontally and vertically
  Alignment get center {
    return const Alignment(0.0, 0.0);
  }

  // Custom alignment method to center horizontally
  Alignment get centerHorizontal {
    return Alignment.centerLeft;
  }

  // Custom alignment method to center vertically
  Alignment get centerVertical {
    return Alignment.topCenter;
  }

  // Custom alignment method to align to the top left corner
  Alignment get topLeft {
    return Alignment.topLeft;
  }

  // Custom alignment method to align to the top right corner
  Alignment get topRight {
    return Alignment.topRight;
  }

  // Custom alignment method to align to the bottom left corner
  Alignment get bottomLeft {
    return Alignment.bottomLeft;
  }

  // Custom alignment method to align to the bottom right corner
  Alignment get bottomRight {
    return Alignment.bottomRight;
  }

  // Custom alignment method to align to the top center
  Alignment get topCenter {
    return Alignment.topCenter;
  }

  // Custom alignment method to align to the bottom center
  Alignment get bottomCenter {
    return Alignment.bottomCenter;
  }

  // Custom alignment method to align to the center left
  Alignment get centerLeft {
    return Alignment.centerLeft;
  }

  // Custom alignment method to align to the center right
  Alignment get centerRight {
    return Alignment.centerRight;
  }
}
