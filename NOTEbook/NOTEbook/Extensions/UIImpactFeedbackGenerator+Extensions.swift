//
//  UIImpactFeedbackGenerator+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 7/26/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import AudioToolbox
import UIKit

extension UIImpactFeedbackGenerator {
    static func lightTapticFeedbackOccurred() {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // iPhone 6s or 6s Plus
        if identifier == "iPhone8,1" || identifier == "iPhone8,2" {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    static func mediumTapticFeedbackOccurred() {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // iPhone 6s or 6s Plus
        if identifier == "iPhone8,1" || identifier == "iPhone8,2" {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        } else {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}
