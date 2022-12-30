//
//  NoteFingeringDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/29/22.
//

import SwiftUI

struct NoteFingeringDetailView: View {
    let noteFingering: NoteFingering
    
    var body: some View {
        HStack {
            letterView(note: noteFingering.notes[0])
            
            Spacer()
            
            if noteFingering.notes.count == 2 {
                letterView(note: noteFingering.notes[1])
            }
        }
        .font(.title)
        .padding()
    }
    
    @ViewBuilder
    func letterView(note: Note) -> some View {
        HStack(spacing: 0) {
            Text(note.capitalizedLetter())
            
            if (note.type == .sharp) {
                Image("Sharp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 26)
            } else if (note.type == .flat) {
                Image("Flat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 22)
            }
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[0])
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[1])
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[2])
            }
        }
    }
}
