//
//  UIImage+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 6/17/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import ImageIO
import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

extension UIImage {
    struct Assets {
        static let appIcon200x200 = "AppIcon200x200"
        static let getStartedIcons = "GetStartedIcons"
        static let gridButton = "GridButton"
        static let instrumentsButton = "InstrumentsButton"
        static let pickerButton = "PickerButton"
        static let pressedGridButton = "PressedGridButton"
        static let pressedPickerButton = "PressedPickerButton"
        static let swipeArrow = "SwipeArrow"
    }
    
    struct MusicSymbols {
        static let bassClef = "BassClef"
        static let cellWholeNote = "CellWholeNote"
        static let flat = "Flat"
        static let lowerQuarterNote = "LowerQuarterNote"
        static let natural = "Natural"
        static let sharp = "Sharp"
        static let trebleClef = "TrebleClef"
        static let upperQuarterNote = "UpperQuarterNote"
    }
    
    struct TutorialGifs {
        static let accidentals = "AccidentalsFinal"
        static let alternateFingerings = "AlternateFingeringsFinal"
        static let notePicker = "NotePickerFinal"
        static let chart = "ChartFinal"
        static let instruments = "InstrumentsFinal"
    }
    
    struct Instruments {
        struct Triggers {
            static let bbEmpty = "BbTriggerEmpty"
            static let bbFull = "BbTriggerFull"
            static let fEmpty = "FTriggerEmpty"
            static let fFull = "FTriggerFull"
        }
        
        struct Clarinet {
            static let bottomKeysEmpty = "ClarinetBottomKeysEmpty"
            static let bottomKeysEmptyFull = "ClarinetBottomKeysEmptyFull"
            static let bottomKeysFull = "ClarinetBottomKeysFull"
            static let bottomKeysFullEmpty = "ClarinetBottomKeysFullEmpty"
            static let circleKeyEmpty = "ClarinetCircleKeyEmpty"
            static let circleKeyFull = "ClarinetCircleKeyFull"
            static let largeSideKeyEmpty = "ClarinetLargeSideKeyEmpty"
            static let largeSideKeyFull = "ClarinetLargeSideKeyFull"
            static let middleLeverKeyEmpty = "ClarinetMiddleLeverKeyEmpty"
            static let middleLeverKeyFull = "ClarinetMiddleLeverKeyFull"
            static let smallSideKeyEmpty = "ClarinetSmallSideKeyEmpty"
            static let smallSideKeyFull = "ClarinetSmallSideKeyFull"
            static let thinLeftLeverKeyEmpty = "ClarinetThinLeftLeverKeyEmpty"
            static let thinLeftLeverKeyFull = "ClarinetThinLeftLeverKeyFull"
            static let thinRightLeverKeyEmpty = "ClarinetThinRightLeverKeyEmpty"
            static let thinRightLeverKeyFull = "ClarinetThinRightLeverKeyFull"
            static let thumbKeysEmpty = "ClarinetThumbKeysEmpty"
            static let thumbKeysEmptyFull = "ClarinetThumbKeysEmptyFull"
            static let thumbKeysFull = "ClarinetThumbKeysFull"
            static let thumbKeysFullEmpty = "ClarinetThumbKeysFullEmpty"
            static let topLeverKeyEmpty = "ClarinetTopLeverKeyEmpty"
            static let topLeverKeyFull = "ClarinetTopLeverKeyFull"
            static let triggerGroupKeysEmpty = "ClarinetTriggerGroupKeysEmpty"
            static let triggerGroupKeysEmptyEmptyFull = "ClarinetTriggerGroupKeysEmptyEmptyFull"
            static let triggerGroupKeysEmptyFullEmpty = "ClarinetTriggerGroupKeysEmptyFullEmpty"
            static let triggerGroupKeysEmptyFullFull = "ClarinetTriggerGroupKeysEmptyFullFull"
            static let triggerGroupKeysFull = "ClarinetTriggerGroupKeysFull"
            static let triggerGroupKeysFullEmptyEmpty = "ClarinetTriggerGroupKeysFullEmptyEmpty"
            static let triggerGroupKeysFullEmptyFull = "ClarinetTriggerGroupKeysFullEmptyFull"
            static let triggerGroupKeysFullFullEmpty = "ClarinetTriggerGroupKeysFullFullEmpty"
        }
        
        struct Flute {
            static let circleKeyEmpty = "FluteCircleKeyEmpty"
            static let circleKeyFull = "FluteCircleKeyFull"
            static let footKey1Empty = "FluteFootKey1Empty"
            static let footKey1Full = "FluteFootKey1Full"
            static let footKey2Empty = "FluteFootKey2Empty"
            static let footKey2Full = "FluteFootKey2Full"
            static let leverKeysEmpty = "FluteLeverKeysEmpty"
            static let leverKeysEmptyFull = "FluteLeverKeysEmptyFull"
            static let leverKeysFull = "FluteLeverKeysFull"
            static let leverKeysFullEmpty = "FluteLeverKeysFullEmpty"
            static let pinkyKeyEmpty = "FlutePinkyKeyEmpty"
            static let pinkyKeyFull = "FlutePinkyKeyFull"
            static let thumbKeysEmpty = "FluteThumbKeysEmpty"
            static let thumbKeysEmptyFull = "FluteThumbKeysEmptyFull"
            static let thumbKeysFull = "FluteThumbKeysFull"
            static let thumbKeysFullEmpty = "FluteThumbKeysFullEmpty"
            static let trillKeyEmpty = "FluteTrillKeyEmpty"
            static let trillKeyFull = "FluteTrillKeyFull"
        }
        
        struct Round {
            static let empty1 = "RoundFingeringEmpty1"
            static let empty2 = "RoundFingeringEmpty2"
            static let empty3 = "RoundFingeringEmpty3"
            static let empty4 = "RoundFingeringEmpty4"
            static let full1 = "RoundFingeringFull1"
            static let full2 = "RoundFingeringFull2"
            static let full3 = "RoundFingeringFull3"
            static let full4 = "RoundFingeringFull4"
        }
        
        struct Saxophone {
            static let baritoneOctaveKeysEmpty = "SaxophoneBaritoneOctaveKeysEmpty"
            static let baritoneOctaveKeysEmptyFull = "SaxophoneBaritoneOctaveKeysEmptyFull"
            static let baritoneOctaveKeysFull = "SaxophoneBaritoneOctaveKeysFull"
            static let baritoneOctaveKeysFullEmpty = "SaxophoneBaritoneOctaveKeysFullEmpty"
            static let bisKeyEmpty = "SaxophoneBisKeyEmpty"
            static let bisKeyFull = "SaxophoneBisKeyFull"
            static let bottomKeysEmpty = "SaxophoneBottomKeysEmpty"
            static let bottomKeysEmptyFull = "SaxophoneBottomKeysEmptyFull"
            static let bottomKeysFull = "SaxophoneBottomKeysFull"
            static let bottomKeysFullEmpty = "SaxophoneBottomKeysFullEmpty"
            static let bottomLowKeyEmpty = "SaxophoneBottomLowKeyEmpty"
            static let bottomLowKeyFull = "SaxophoneBottomLowKeyFull"
            static let chromaticFSharpKeyEmpty = "SaxophoneChromaticF#KeyEmpty"
            static let chromaticFSharpKeyFull = "SaxophoneChromaticF#KeyFull"
            static let circleKeyEmpty = "SaxophoneCircleKeyEmpty"
            static let circleKeyFull = "SaxophoneCircleKeyFull"
            static let circleKeyWithLineEmpty = "SaxophoneCircleKeyWithLineEmpty"
            static let circleKeyWithLineFull = "SaxophoneCircleKeyWithLineFull"
            static let forkKeyEmpty = "SaxophoneForkKeyEmpty"
            static let forkKeyFull = "SaxophoneForkKeyFull"
            static let highFSharpKeyEmpty = "SaxophoneHighF#KeyEmpty"
            static let highFSharpKeyFull = "SaxophoneHighF#KeyFull"
            static let largeSideKeyEmpty = "SaxophoneLargeSideKeyEmpty"
            static let largeSideKeyFull = "SaxophoneLargeSideKeyFull"
            static let middleLowKeysEmpty = "SaxophoneMiddleLowKeysEmpty"
            static let middleLowKeysEmptyFull = "SaxophoneMiddleLowKeysEmptyFull"
            static let middleLowKeysFull = "SaxophoneMiddleLowKeysFull"
            static let middleLowKeysFullEmpty = "SaxophoneMiddleLowKeysFullEmpty"
            static let octaveKeyEmpty = "SaxophoneOctaveKeyEmpty"
            static let octaveKeyFull = "SaxophoneOctaveKeyFull"
            static let smallSideKeyEmpty = "SaxophoneSmallSideKeyEmpty"
            static let smallSideKeyFull = "SaxophoneSmallSideKeyFull"
            static let topLeverKeyEmpty = "SaxophoneTopLeverKeyEmpty"
            static let topLeverKeyFull = "SaxophoneTopLeverKeyFull"
            static let upperLowKeyEmpty = "SaxophoneUpperLowKeyEmpty"
            static let upperLowKeyFull = "SaxophoneUpperLowKeyFull"
        }
    }
    
    static func drawStaffLine(color: UIColor, size: CGSize, rounded: Bool) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        var img = renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.fill(CGRect(origin: .zero, size: size))
        }
        
        if rounded {
            let imageView = UIImageView(frame: CGRect(origin: .zero, size: size))
            imageView.contentMode = .center
            imageView.image = img
            imageView.layer.cornerRadius = min(size.height, size.width) / 2
            
            let imageViewRenderer = UIGraphicsImageRenderer(size: size)
            
            img = imageViewRenderer.image { ctx in
                imageView.layer.render(in: ctx.cgContext)
            }
        }
        
        return img
    }
    
    // MARK: - Gif Functions
    static func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    static func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL: URL = URL(string: gifUrl) else {
            return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    static func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    static func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    static func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    static func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    static func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}
