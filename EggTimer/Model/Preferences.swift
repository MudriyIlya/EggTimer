//
//  Preferences.swift
//  EggTimer
//
//  Created by Ilya Mudriy on 12/03/2019.
//  Copyright © 2019 Ilya Mudriy. All rights reserved.
//

import Foundation
struct Preferences {
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            return 360
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
