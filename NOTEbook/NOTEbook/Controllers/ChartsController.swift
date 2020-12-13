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
    
    private(set) var chartCategories = [ChartCategory]()
    
    var currentChart: FingeringChart
    var currentChartCategory: ChartCategory
    
    lazy var purchasableInstrumentGroups: [PurchasableInstrumentGroup] = {
        var groups = [PurchasableInstrumentGroup]()
        
        var appendingInstrumentNames: [String]?
        
        for category in chartCategories {
            if category.name == "Mellophone" || category.name == "Baritone" {
                var names = [String]()
                
                for chart in category.fingeringCharts {
                    let name = chart.instrument.type.rawValue
                    names.append(name)
                }
                
                appendingInstrumentNames = names
            } else {
                let name = category.name
                var titles = [String]()
                
                for chart in category.fingeringCharts {
                    let title = chart.instrument.type.rawValue
                    titles.append(title)
                }
                
                if let appendingInstrumentNames = appendingInstrumentNames {
                    titles += appendingInstrumentNames
                }
                
                appendingInstrumentNames = nil
                
                groups.append(PurchasableInstrumentGroup(groupTitle: name, instrumentTitles: titles))
            }
        }
        
        return groups
    }()
    
    init() {
        do {
            chartCategories = try ChartsLoader.loadCharts()
        } catch {
            fatalError("Fail to load charts")
        }
        
        currentChartCategory = chartCategories[UserDefaults.standard.integer(forKey: UserDefaults.Keys.currentChartCategoryIndex)]
        currentChart = currentChartCategory.fingeringCharts[UserDefaults.standard.integer(forKey: UserDefaults.Keys.currentInstrumentIndex)]
    }
}

extension ChartsController {
    var numberOfNoteFingeringsInCurrentChart: Int {
        return currentChart.noteFingerings.count
    }
    
    var numberOfCategories: Int {
        return chartCategories.count
    }
    
    var currentCategoryInstrumentsCount: Int {
        return currentChartCategory.fingeringCharts.count
    }
    
    func changeCurrentChart(to categoryIndex: Int, instrumentIndex: Int) {
        currentChartCategory = chartCategories[categoryIndex]
        currentChart = currentChartCategory.fingeringCharts[instrumentIndex]
        
        UserDefaults.standard.setValue(categoryIndex, forKey: UserDefaults.Keys.currentChartCategoryIndex)
        UserDefaults.standard.setValue(instrumentIndex, forKey: UserDefaults.Keys.currentInstrumentIndex)
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
    
    func chartCellHeight() -> Double {
        let chartCellHeight = Double(currentChart.instrument.chartCellHeight)
        let chartFingeringHeight = Double(currentChart.instrument.chartFingeringHeight)
        let instrumentMaximumFingerings = currentChart.instrument.maximumSpacingFingerings
        let fingeringsLimit = Double(UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))
        
        return (instrumentMaximumFingerings >= fingeringsLimit ? chartCellHeight - ((instrumentMaximumFingerings - fingeringsLimit) * chartFingeringHeight) : chartCellHeight)
    }
}
