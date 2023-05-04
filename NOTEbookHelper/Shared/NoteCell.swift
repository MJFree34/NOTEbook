//
//  NoteCell.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/30/22.
//

import SwiftUI

struct NoteCell: View {
    let noteFingering: NoteFingering
    let highlight: Bool
    
    init(noteFingering: NoteFingering, highlight: Bool = false) {
        self.noteFingering = noteFingering
        self.highlight = highlight
    }
    
    var note1: Note { noteFingering.notes[0] }
    var note2: Note? { noteFingering.notes.count == 2 ? noteFingering.notes[1] : nil }
    var hasTwoNotes: Bool { noteFingering.notes.count == 2 }
    var positionsFromCenterStaff: Int { note1.positionsFromCenterStaff() }
    
    private let lineSpacing: CGFloat = 9
    private let staffWidth: CGFloat = 150
    
    var body: some View {
        VStack {
            fingeringLetterView(note1: note1, note2: note2)
            
            Spacer()
            
            ZStack {
                staffLinesView(note1: note1, note2: note2, hasTwoNotes: hasTwoNotes)
                
                HStack {
                    clefView(clef: note1.clef)
                    
                    Spacer()
                }
                .offset(y: calculatedClefPositionsOffset(positionsFromCenterStaff: positionsFromCenterStaff, hasTwoNotes: hasTwoNotes) * 5)
                
                fingeringNotesView(note1: note1, note2: note2)
                    .offset(y: calculatedNotesPositionsOffset(positionsFromCenterStaff: positionsFromCenterStaff, hasTwoNotes: hasTwoNotes) * -5)
            }
            .frame(width: staffWidth)
            
            Spacer()
        }
        .padding(.bottom)
    }
    
    @ViewBuilder
    func fingeringLetterView(note1: Note, note2: Note?) -> some View {
        HStack {
            letterView(note: note1)
            
            Spacer()
            
            if let note2 = note2 {
                letterView(note: note2)
            }
        }
        .font(.title)
        .padding()
    }
    
    @ViewBuilder
    func letterView(note: Note) -> some View {
        HStack(spacing: 0) {
            Text(note.capitalizedLetter())
                .foregroundColor(highlight ? Color("MediumRed") : .black)
            
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
    
    @ViewBuilder
    func staffLinesView(note1: Note, note2: Note?, hasTwoNotes: Bool) -> some View {
        VStack(spacing: lineSpacing) {
            if note1.positionsFromCenterStaff() > 4 {
                extraLinesView(note: note2 ?? note1, hasTwoNotes: hasTwoNotes)
            }
            
            ForEach(0..<5) { _ in
                Rectangle()
                    .frame(width: staffWidth, height: 1)
            }
            
            if note1.positionsFromCenterStaff() < -4 {
                extraLinesView(note: note1, hasTwoNotes: hasTwoNotes)
            }
        }
        .foregroundColor(highlight ? Color("MediumRed") : .black)
    }
    
    @ViewBuilder
    func extraLinesView(note: Note, hasTwoNotes: Bool) -> some View {
        let extraLines = abs(note.positionsFromCenterStaff()) / 2 - 2
        
        ForEach(0..<extraLines, id: \.self) { _ in
            Rectangle()
                .frame(width: hasTwoNotes ? 40 : 20, height: 1)
        }
    }
    
    @ViewBuilder
    func fingeringNotesView(note1: Note, note2: Note?) -> some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                if note1.type == .sharp {
                    Image("Sharp")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .offset(x: -2, y: 0.5)
                }
                
                wholeNoteView()
            }
            
            if let note2 = note2 {
                HStack(spacing: 0) {
                    wholeNoteView()
                    
                    if note2.type == .flat {
                        Image("Flat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                            .offset(x: 2, y: -5)
                    }
                }
                .offset(y: -5)
            }
        }
    }
    
    @ViewBuilder
    func clefView(clef: Clef) -> some View {
        if clef == .treble {
            Image("TrebleClef" + (highlight ? "Highlight" : ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 76)
                .offset(x: -2)
        } else {
            Image("BassClef" + (highlight ? "Highlight" : ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .offset(x: -2, y: -4.5)
        }
    }
    
    @ViewBuilder
    func wholeNoteView() -> some View {
        Image("CellWholeNote" + (highlight ? "Highlight" : ""))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 10)
    }
    
    func calculatedClefPositionsOffset(positionsFromCenterStaff: Int, hasTwoNotes: Bool) -> CGFloat {
        // formula: offsetPositions = ((positions / 2 * 2) + (positions < 0 ? 4 : -4)) / 2
        guard abs(positionsFromCenterStaff) >= 4 else { return 0 }
        
        let positionsRoundedDownToEven = positionsFromCenterStaff / 2 * 2
        let positionsWithFourRemoved = positionsRoundedDownToEven + (positionsFromCenterStaff < 0 ? 4 : -4)
        let positionsWithTwoNoteTopStaffOffset = positionsWithFourRemoved + (positionsFromCenterStaff > 4 && hasTwoNotes ? 2 : 0)
        let finalOffset = positionsWithTwoNoteTopStaffOffset / 2
        return CGFloat(finalOffset)
    }
    
    func calculatedNotesPositionsOffset(positionsFromCenterStaff: Int, hasTwoNotes: Bool) -> CGFloat {
        // formula: offsetPositions = (positions + (positions < 0 ? -4 : 4) + (positions % 2 == 0 ? 0 : 1) * (positions < 0 ? -1 : 1)) / 2
        guard abs(positionsFromCenterStaff) >= 4 else { return CGFloat(positionsFromCenterStaff) }
        
        let positionsWithFourAdded = positionsFromCenterStaff + (positionsFromCenterStaff < 0 ? -4 : 4)
        let positionsRoundedUpToEven = positionsWithFourAdded + (positionsFromCenterStaff % 2 == 0 ? 0 : 1) * (positionsFromCenterStaff < 0 ? -1 : 1)
        let positionsWithTwoNoteTopStaffOffset = positionsRoundedUpToEven + (positionsFromCenterStaff > 4 && hasTwoNotes && positionsFromCenterStaff % 2 != 0 ? -2 : 0)
        let finalOffset = positionsWithTwoNoteTopStaffOffset / 2
        return CGFloat(finalOffset)
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                NoteCell(noteFingering: HelperChartsController.exampleChart.noteFingerings[0])
                    .frame(width: 200, height: 200)
                
                NoteCell(noteFingering: HelperChartsController.exampleChart.noteFingerings[1], highlight: true)
                    .frame(width: 200, height: 200)

                NoteCell(noteFingering: HelperChartsController.exampleChart.noteFingerings[2])
                    .frame(width: 200, height: 200)
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
