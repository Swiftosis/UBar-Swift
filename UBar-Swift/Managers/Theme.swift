//
//  Theme.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

enum Theme: Int {
  case Default, Dark

  var mainColor: UIColor {
    switch self {
    case .Default:
      return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    case .Dark:
      return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    }
  }
  var barStyle: UIBarStyle {
    switch self {
    case .Default:
      return .Default
    case .Dark:
      return .Black
    }
  }
}

let SelectedThemeKey = "SelectedTheme"

struct ThemeManager {

  static func currentTheme() -> Theme {
    if let storedTheme = NSUserDefaults.standardUserDefaults().valueForKey(SelectedThemeKey)?.integerValue {
      return Theme(rawValue: storedTheme)!
    } else {
      return .Default
    }
  }
  static func applyTheme(theme: Theme) {

    let sharedApplication = UIApplication.sharedApplication()
    sharedApplication.delegate?.window??.tintColor = theme.mainColor
    UINavigationBar.appearance().barStyle = theme.barStyle
    UINavigationBar.appearance().barTintColor = UIColor(red: 50.0/255.0 , green: 56.0/255.0, blue: 70.0/255.0, alpha: 1.0)

  }
}