//
//  InstrumentDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/26/22.
//

import SwiftUI

struct ChartDetailView: View {
    var chart: FingeringChart
    
    var body: some View {
        VStack {
            Text("Name: \(chart.name)")
            Image("\(chart.instrument.clef.rawValue.capitalized)Clef")
            Text("Center Note: \(chart.centerNote.capitalizedLetter()) \(chart.centerNote.type.rawValue) \(chart.centerNote.position.rawValue)")
            
            Text("Notes:")
            
            List(chart.noteFingerings) { fingering in
                Text("\(fingering.notes[0].capitalizedLetter()) \(fingering.notes[0].type.rawValue) \(fingering.notes[0].position.rawValue)")
            }
        }
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDetailView(chart: HelperChartsController.exampleChart)
    }
}
