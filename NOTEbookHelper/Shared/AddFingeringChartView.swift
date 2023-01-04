//
//  AddFingeringChartView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/2/23.
//

import SwiftUI

struct AddFingeringChartView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    var categoryName: String
    
    @State private var instrumentType: InstrumentType?
    @State private var inputNoteRange = false
    @State private var clef: Clef?
    @State private var minNote: Note?
    @State private var maxNote: Note?
    
    private let staffLineSpacing: CGFloat = 18
    private let staffWidth: CGFloat = 300
    private let noteLineSpacing: CGFloat = 10
    
    var isFilledOut: Bool {
        instrumentType != nil && (!inputNoteRange || (clef != nil))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Instrument") {
                    Picker("Instrument", selection: $instrumentType) {
                        Text("")
                            .tag(nil as InstrumentType?)
                        
                        ForEach(InstrumentType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type as InstrumentType?)
                        }
                    }
                }
                
                Section("Note Range Toggle") {
                    Toggle("Input Note Range", isOn: $inputNoteRange)
                }
                
                if inputNoteRange {
                    Section("Clef") {
                        Picker("Clef", selection: $clef) {
                            Text("")
                                .tag(nil as Clef?)
                            
                            ForEach(Clef.allCases) { clef in
                                Text(clef.rawValue.capitalized)
                                    .tag(clef as Clef?)
                            }
                        }
                    }
                    
                    if clef != nil {
                        Section("Note Range") {
                            HStack {
                                Spacer()
                                noteRangePicker()
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        let instrument = Instrument(type: instrumentType!)
                        var centerNote: Note?
                        var naturalNotes = [Note]()
                        var flatNotes = [Note]()
                        var sharpNotes = [Note]()
                        var noteFingerings = [NoteFingering]()
                        
                        if inputNoteRange, let minNote = minNote, let maxNote = maxNote {
                            naturalNotes = helperChartsController.generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .natural)
                            flatNotes = helperChartsController.generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .flat)
                            sharpNotes = helperChartsController.generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .sharp)
                            centerNote = naturalNotes[naturalNotes.count / 2]
                            noteFingerings = helperChartsController.generateEmptyNoteFingerings(naturalNotes: naturalNotes, flatNotes: flatNotes, sharpNotes: sharpNotes)
                        }
                        
                        let chart = FingeringChart(instrument: instrument, centerNote: centerNote, naturalNotes: naturalNotes, flatNotes: flatNotes, sharpNotes: sharpNotes, noteFingerings: noteFingerings)
                        
                        helperChartsController.addChart(in: categoryName, chart: chart)
                        dismiss()
                    } label: {
                        Text("Add \(instrumentType != nil ? instrumentType!.rawValue : "Chart")")
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isFilledOut)
                }
            }
            .onChange(of: clef) { newClef in
                if let newClef = newClef {
                    if minNote == nil && maxNote == nil {
                        minNote = Note.middleNote(for: newClef)
                        maxNote = Note.middleNote(for: newClef)
                    } else if let minNote = minNote, let maxNote = maxNote {
                        if minNote < Note.minNote(for: newClef) {
                            self.minNote = Note.minNote(for: newClef)
                        } else if minNote > Note.maxNote(for: newClef) {
                            self.minNote = Note.maxNote(for: newClef)
                        }
                        
                        if maxNote > Note.maxNote(for: newClef) {
                            self.maxNote = Note.maxNote(for: newClef)
                        } else if maxNote < Note.minNote(for: newClef) {
                            self.maxNote = Note.minNote(for: newClef)
                        }
                        
                        self.minNote = Note(letter: self.minNote!.letter, type: self.minNote!.type, octave: self.minNote!.octave, clef: newClef)
                        self.maxNote = Note(letter: self.maxNote!.letter, type: self.maxNote!.type, octave: self.maxNote!.octave, clef: newClef)
                        
                        if minNote > maxNote {
                            self.minNote = self.maxNote
                        }
                    }
                }
            }
            .navigationTitle("Add Chart in \(categoryName)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func noteRangePicker() -> some View {
        VStack {
            HStack {
                minNotePicker()
                Spacer()
                maxNotePicker()
            }
            
            Spacer()
            
            ZStack {
                staffLinesView()
                
                HStack {
                    clefView(clef: clef!)
                        .frame(width: 60)
                    
                    notesView()
                }
            }
            
            Spacer()
        }
        .frame(minHeight: 480)
    }
    
    @ViewBuilder
    func minNotePicker() -> some View {
        HStack {
            if let minNote = minNote, let maxNote = maxNote {
                verticalStepper(
                    increment: {
                        self.minNote = minNote.higherNote()
                    },
                    decrement: {
                        self.minNote = minNote.lowerNote()
                    },
                    disableIncrement: minNote.position == Note.maxNote(for: clef!).position || minNote.position == maxNote.position,
                    disableDecrement: minNote.position == Note.minNote(for: clef!).position
                )
                .padding(.trailing)
                
                VStack {
                    Text("MIN")
                        .font(.caption)
                    
                    Text(minNote.capitalizedLetter())
                        .font(.title)
                }
            }
        }
    }
    
    @ViewBuilder
    func maxNotePicker() -> some View {
        HStack {
            if let maxNote = maxNote, let minNote = minNote {
                VStack {
                    Text("MAX")
                        .font(.caption)
                    
                    Text(maxNote.capitalizedLetter())
                        .font(.title)
                }
                
                verticalStepper(
                    increment: {
                        self.maxNote = maxNote.higherNote()
                    },
                    decrement: {
                        self.maxNote = maxNote.lowerNote()
                    },
                    disableIncrement: maxNote.position == Note.maxNote(for: clef!).position,
                    disableDecrement: maxNote.position == Note.minNote(for: clef!).position || maxNote.position == minNote.position
                )
                .padding(.leading)
            }
        }
    }
    
    @ViewBuilder
    func verticalStepper(increment: @escaping () -> Void, decrement: @escaping () -> Void, disableIncrement: Bool, disableDecrement: Bool) -> some View {
        VStack(spacing: 4) {
            Button {
                increment()
            } label: {
                Image(systemName: "chevron.up")
                    .padding(2)
            }
            .disabled(disableIncrement)
            
            Button {
                decrement()
            } label: {
                Image(systemName: "chevron.down")
                    .padding(2)
            }
            .disabled(disableDecrement)
        }
        .buttonStyle(.bordered)
    }
    
    @ViewBuilder
    func staffLinesView() -> some View {
        VStack(spacing: staffLineSpacing) {
            ForEach(0..<5) { _ in
                Rectangle()
                    .frame(width: staffWidth, height: 2)
            }
        }
    }
    
    @ViewBuilder
    func clefView(clef: Clef) -> some View {
        if clef == .treble {
            Image("TrebleClef")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 152)
                .offset(x: -6)
        } else {
            Image("BassClef")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .offset(x: -6, y: -9)
        }
    }
    
    @ViewBuilder
    func notesView() -> some View {
        HStack(spacing: 20) {
            Spacer()
            
            if let minNote = minNote {
                noteView(note: minNote)
            }
            
            Spacer()
            
            if let maxNote = maxNote {
                noteView(note: maxNote)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func noteView(note: Note) -> some View {
        ZStack(alignment: .center) {
            wholeNoteView()
            
            if note.positionsFromCenterStaff() < -5 || note.positionsFromCenterStaff() > 5 {
                let extraLines = abs(note.positionsFromCenterStaff()) / 2 - 2
                
                VStack(spacing: staffLineSpacing) {
                    ForEach(0..<extraLines, id: \.self) { _ in
                        Rectangle()
                            .frame(width: 40, height: 2)
                    }
                }
                .offset(y: calculatedExtraLinesOffset(positionsFromCenterStaff: note.positionsFromCenterStaff(), extraLines: extraLines))
            } else {
                Rectangle()
                    .frame(width: 40, height: 2)
                    .hidden()
            }
        }
        .offset(y: CGFloat(note.positionsFromCenterStaff()) * -noteLineSpacing)
    }
    
    @ViewBuilder
    func wholeNoteView() -> some View {
        Image("CellWholeNote")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 20)
    }
    
    func calculatedExtraLinesOffset(positionsFromCenterStaff: Int, extraLines: Int) -> CGFloat {
        let isInSpace = abs(positionsFromCenterStaff) % 2 == 1
        let isBelowStaff = positionsFromCenterStaff < -4
        let finalBelowOffset = isInSpace ? -Int(noteLineSpacing) * (extraLines - 1) - Int(noteLineSpacing) - 1 : -Int(noteLineSpacing) * (extraLines - 1) - 1
        let finalAboveOffset = isInSpace ? Int(noteLineSpacing) * (extraLines - 1) + Int(noteLineSpacing) - 1 : Int(noteLineSpacing) * (extraLines - 1) - 1
        return CGFloat(isBelowStaff ? finalBelowOffset : finalAboveOffset)
    }
}

struct AddFingeringChartView_Previews: PreviewProvider {
    static var previews: some View {
        AddFingeringChartView(categoryName: HelperChartsController.exampleChartCategory.name)
            .environmentObject(HelperChartsController.shared)
    }
}
