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

    Created by Muhammad Atif on 3/12/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'dart:developer';
import 'package:flutter/foundation.dart';

class FlutterLogger {

  static warning(Object message) {
    if (kDebugMode) {
      log("\x1B[33m==========================================================================================\x1B[0m");
      print('\x1B[33m[📢 Warning] $message\x1B[0m');
      print("\x1B[33m==========================================================================================\x1B[0m");
    }
  }

  static error(Object message) {
    if (kDebugMode) {
      print("\x1B[31m==========================================================================================\x1B[0m");
      print('\x1B[31m[❌ Error] $message\x1B[0m');
      print(
          "\x1B[31m==========================================================================================\x1B[0m");
    }
  }

  static success(Object message) {
    if (kDebugMode) {
      print(
          "\x1B[32m==========================================================================================\x1B[0m");
      print('\x1B[32m[✅ Success] $message\x1B[0m');
      print(
          "\x1B[32m==========================================================================================\x1B[0m");
    }
  }

  static info(Object message) {
    if (kDebugMode) {
      log("\x1B[34m==========================================================================================\x1B[0m");
      log('\x1B[34m$message\x1B[0m', name: '[ℹ️ Info]');
      log("\x1B[34m==========================================================================================\x1B[0m");
    }
  }

  static String get developerName => '''
    ::: ::::::::::: ::::::::::: :::::::::: 
  :+: :+:   :+:         :+:     :+:        
 +:+   +:+  +:+         +:+     +:+        
+#++:++#++: +#+         +#+     :#::+::#   
+#+     +#+ +#+         +#+     +#+        
#+#     #+# #+#         #+#     #+#        
###     ### ###     ########### ###                                
  ''';


  static printDeveloper() {
    if (kDebugMode) {
      log('\x1B[36m$developerName\x1B[0m', name: 'Burki');
    }
  }

}