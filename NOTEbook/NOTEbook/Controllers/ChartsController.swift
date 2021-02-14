//
//  ChartsController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/18/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Purchases
import Foundation

class ChartsController {
    static let shared = ChartsController()
    
    private(set) var chartCategories = [ChartCategory]()
    
    private(set) var purchasedChartCategories = [ChartCategory]()
    private(set) var purchasableInstrumentGroups = [PurchasableInstrumentGroup]()
    
    var currentChart: FingeringChart
    var currentChartCategory: ChartCategory
    
    lazy var allInstrumentGroups: [PurchasableInstrumentGroup] = {
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
        
        updatePurchasableInstrumentGroups()
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
        currentChartCategory = purchasedChartCategories[categoryIndex]
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

extension ChartsController {
    func updatePurchasableInstrumentGroups() {
        let iapFlowHasShown = UserDefaults.standard.bool(forKey: UserDefaults.Keys.iapFlowHasShown)
        
        if iapFlowHasShown {
            var groups = allInstrumentGroups
            
            let freeInstrumentIndex = UserDefaults.standard.integer(forKey: UserDefaults.Keys.chosenFreeInstrumentGroupIndex)
            let freeGroup = allInstrumentGroups[freeInstrumentIndex]
            
            Purchases.shared.purchaserInfo { (purchaserInfo, error) in
                if purchaserInfo?.entitlements["all"]?.isActive == true {
                    groups.removeAll()
                } else if purchaserInfo?.entitlements["woodwinds"]?.isActive == true {
                    if purchaserInfo?.entitlements["trumpet"]?.isActive == true {
                        groups.remove(at: 3)
                    } else if purchaserInfo?.entitlements["french_horn"]?.isActive == true {
                        groups.remove(at: 4)
                    } else if purchaserInfo?.entitlements["trombone"]?.isActive == true {
                        groups.remove(at: 5)
                    } else if purchaserInfo?.entitlements["euphonium"]?.isActive == true {
                        groups.remove(at: 6)
                    } else if purchaserInfo?.entitlements["tuba"]?.isActive == true {
                        groups.remove(at: 7)
                    }
                    
                    groups.removeFirst(Constants.numberOfWoodwindGroups)
                } else if purchaserInfo?.entitlements["brass"]?.isActive == true {
                    groups.removeLast(Constants.numberOfBrassGroups)
                    
                    if purchaserInfo?.entitlements["flute"]?.isActive == true {
                        groups.remove(at: 0)
                    } else if purchaserInfo?.entitlements["clarinet"]?.isActive == true {
                        groups.remove(at: 1)
                    } else if purchaserInfo?.entitlements["saxophone"]?.isActive == true {
                        groups.remove(at: 2)
                    }
                } else {
                    if purchaserInfo?.entitlements["flute"]?.isActive == true {
                        groups.remove(at: 0)
                    } else if purchaserInfo?.entitlements["clarinet"]?.isActive == true {
                        groups.remove(at: 1)
                    } else if purchaserInfo?.entitlements["saxophone"]?.isActive == true {
                        groups.remove(at: 2)
                    } else if purchaserInfo?.entitlements["trumpet"]?.isActive == true {
                        groups.remove(at: 3)
                    } else if purchaserInfo?.entitlements["french_horn"]?.isActive == true {
                        groups.remove(at: 4)
                    } else if purchaserInfo?.entitlements["trombone"]?.isActive == true {
                        groups.remove(at: 5)
                    } else if purchaserInfo?.entitlements["euphonium"]?.isActive == true {
                        groups.remove(at: 6)
                    } else if purchaserInfo?.entitlements["tuba"]?.isActive == true {
                        groups.remove(at: 7)
                    }
                }
                
                for (index, group) in groups.enumerated() {
                    if group.groupTitle == freeGroup.groupTitle {
                        groups.remove(at: index)
                        break
                    }
                }
                
                self.purchasableInstrumentGroups = groups
                self.updatePurchasedChartCategories()
            }
        } else {
            purchasableInstrumentGroups = allInstrumentGroups
            updatePurchasedChartCategories()
        }
    }
    
    private func updatePurchasedChartCategories() {
        var purchasedInstrumentGroups = [PurchasableInstrumentGroup]()
        
        for group in allInstrumentGroups {
            var purchased = true
            
            for purchasableGroup in purchasableInstrumentGroups {
                if purchasableGroup.groupTitle == group.groupTitle {
                    purchased = false
                    break
                }
            }
            
            if purchased {
                purchasedInstrumentGroups.append(group)
            }
        }
        
        var purchasedCC = [ChartCategory]()
        
        for group in purchasedInstrumentGroups {
            switch group.groupTitle {
            case "Flute":
                purchasedCC.append(chartCategory(with: "Flute")!)
            case "Clarinet":
                purchasedCC.append(chartCategory(with: "Clarinet")!)
            case "Saxophone":
                purchasedCC.append(chartCategory(with: "Saxophone")!)
            case "Trumpet":
                purchasedCC.append(chartCategory(with: "Trumpet")!)
            case "French Horn":
                purchasedCC.append(chartCategory(with: "Mellophone")!)
                purchasedCC.append(chartCategory(with: "French Horn")!)
            case "Trombone":
                purchasedCC.append(chartCategory(with: "Trombone")!)
            case "Euphonium":
                purchasedCC.append(chartCategory(with: "Baritone")!)
                purchasedCC.append(chartCategory(with: "Euphonium")!)
            case "Tuba":
                purchasedCC.append(chartCategory(with: "Tuba")!)
            default:
                print("Inproper group title \(#fileID) \(#line)")
            }
        }
        
        purchasedChartCategories = purchasedCC
        
        print("PurchasableInstrumentGroups: \(purchasableInstrumentGroups)")
        print("PurchasedInstrumentGroups: \(purchasedInstrumentGroups)")
        print("PurchasedChartCategoriesCount: \(purchasedChartCategories.count)")
    }
    
    private func chartCategory(with name: String) -> ChartCategory? {
        for category in chartCategories {
            if category.name == name {
                return category
            }
        }
        
        return nil
    }
}
