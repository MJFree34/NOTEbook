//
//  ChartsController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/18/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

class ChartsController {
    static let shared = ChartsController()
    
    private var charts = [FingeringChart]()
    
    var currentChart: FingeringChart
    
    init() {
        do {
            charts = try ChartsLoader.loadCharts()
        } catch {
            fatalError("Fail to load charts")
        }
        
        currentChart = charts[0]
    }
}

extension ChartsController {
    var numberOfNoteFingeringsInCurrentChart: Int {
        return currentChart.noteFingerings.count
    }
    
    func chart(at index: Int) -> FingeringChart {
        return charts[index]
    }
    
    func noteFingeringInCurrentChart(for note: Note) -> NoteFingering? {
        for noteFingering in currentChart.noteFingerings {
            if noteFingering.notes.contains(note) {
                return noteFingering
            }
        }
        
        return nil
    }
    
    func currentFingering(note: Note) -> NoteFingering? {
        for fingering in currentChart.noteFingerings {
            for fingeringNote in fingering.notes {
                if fingeringNote == note {
                    return fingering
                }
            }
        }
        
        return nil
    }
    
    func currentNote(from noteType: NoteType, index: Int) -> Note {
        switch noteType {
        case .natural:
            return currentChart.naturalNotes[index]
        case .sharp:
            if index == currentChart.sharpNotes.count {
                return currentChart.sharpNotes[currentChart.sharpNotes.count - 1]
            }
            return currentChart.sharpNotes[index]
        case .flat:
            return currentChart.flatNotes[index]
        }
    }
}
