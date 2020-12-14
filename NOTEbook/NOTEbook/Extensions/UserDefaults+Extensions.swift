//
//  UserDefaults+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 7/8/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let tutorialHasShown = "TutorialHasShown2"
        static let iapFlowHasShown = "IAPFlowHasShown"
        
        static let hapticsEnabled = "HapticsEnabled"
        static let gradientEnabled = "GradientEnabled"
        static let fingeringsLimit = "FingeringsLimit"
        
        static let currentInstrumentIndex = "CurrentInstrumentTypeIndex2"
        static let currentChartCategoryIndex = "CurrentChartCategoryIndex2"
        static let chosenFreeInstrumentGroupIndex = "ChosenFreeInstrumentGroupIndex"
        
        static let numberOfTimesLaunched = "NumberOfTimesLaunched"
        static let lastVersion = "LastVersion"
    }
}
