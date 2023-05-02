//
//  NoteFingeringDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/29/22.
//

import SwiftUI

struct NoteFingeringDetailView: View {
    let noteFingering: NoteFingering
    let instrumentType: InstrumentType
    
    var body: some View {
        VStack(alignment: .center) {
            NoteCell(noteFingering: noteFingering)
                .fixedSize()
            
            List {
                if (noteFingering.fingerings.isEmpty) {
                    Text("No fingering exists")
                } else {
                    ForEach(noteFingering.fingerings, id: \.self) { fingering in
                        fingeringView(fingering: fingering)
                    }
                }
            }
            .listStyle(.inset)
            .scrollDisabled(true)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func fingeringView(fingering: Fingering) -> some View {
        switch instrumentType {
        case .trumpet:
            ThreeValveFingeringView(fingering: fingering)
        default:
            Text("Fingering")
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[0], instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[1], instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[2], instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
        }
    }
}
