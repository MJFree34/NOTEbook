//
//  AddFingeringChartView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/2/23.
//

import SwiftUI

struct AddFingeringChartView: View {
    private enum Mode {
        case update
        case add
    }
    
    private enum NoteRangeSelection: String {
        case none
        case min
        case center
        case max
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    let categoryName: String
    
    private var mode: Mode
    
    @State private var instrumentType: InstrumentType?
    @State private var clef: Clef?
    @State private var noteRangeSelection: NoteRangeSelection = .none
    @State private var minNote: Note?
    @State private var centerNote: Note?
    @State private var maxNote: Note?
    
    private let staffLineSpacing: CGFloat = 18
    private let staffWidth: CGFloat = 300
    private let noteLineSpacing: CGFloat = 10
    
    private var isFilledOut: Bool {
        instrumentType != nil && clef != nil
    }
    
    init(categoryName: String) {
        self.categoryName = categoryName
        self.mode = .add
    }
    
    init(categoryName: String, instrumentType: InstrumentType, minNote: Note? = nil, centerNote: Note? = nil, maxNote: Note? = nil) {
        self.categoryName = categoryName
        self.mode = .update
        self._instrumentType = .init(initialValue: instrumentType)
        
        if let minNote = minNote, let maxNote = maxNote {
            self._clef = .init(initialValue: minNote.clef)
            self._minNote = .init(initialValue: minNote)
            self._centerNote = .init(initialValue: centerNote)
            self._maxNote = .init(initialValue: maxNote)
        }
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
                    .disabled(mode == .update)
                }
                
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
                        createAndAddChart()
                        dismiss()
                    } label: {
                        Text("\(mode == .add ? "Add" : "Update") \(instrumentType != nil ? instrumentType!.rawValue : "Chart")")
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isFilledOut)
                }
            }
            .onChange(of: clef) { newClef in
                if let newClef = newClef {
                    if minNote == nil && centerNote == nil && maxNote == nil {
                        minNote = Note.middleNote(for: newClef)
                        centerNote = Note.middleNote(for: newClef)
                        maxNote = Note.middleNote(for: newClef)
                    } else if let minNote = minNote, let centerNote = centerNote, let maxNote = maxNote {
                        if minNote < Note.minNote(for: newClef) {
                            self.minNote = Note.minNote(for: newClef)
                        } else if minNote > Note.maxNote(for: newClef) {
                            self.minNote = Note.maxNote(for: newClef)
                        }
                        
                        if centerNote < Note.minNote(for: newClef) {
                            self.centerNote = Note.minNote(for: newClef)
                        } else if centerNote > Note.maxNote(for: newClef) {
                            self.centerNote = Note.maxNote(for: newClef)
                        }
                        
                        if maxNote > Note.maxNote(for: newClef) {
                            self.maxNote = Note.maxNote(for: newClef)
                        } else if maxNote < Note.minNote(for: newClef) {
                            self.maxNote = Note.minNote(for: newClef)
                        }
                        
                        self.minNote = Note(letter: self.minNote!.letter, type: self.minNote!.type, octave: self.minNote!.octave, clef: newClef)
                        self.centerNote = Note(letter: self.centerNote!.letter, type: self.centerNote!.type, octave: self.centerNote!.octave, clef: newClef)
                        self.maxNote = Note(letter: self.maxNote!.letter, type: self.maxNote!.type, octave: self.maxNote!.octave, clef: newClef)
                        
                        if minNote > maxNote {
                            self.minNote = self.maxNote
                        }
                        
                        if centerNote < minNote {
                            self.centerNote = minNote
                        } else if centerNote > maxNote {
                            self.centerNote = maxNote
                        }
                    }
                }
            }
            .navigationTitle("\(mode == .add ? "Add Chart in \(categoryName)" : "Update \(instrumentType!.rawValue)")")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func noteRangePicker() -> some View {
        VStack {
            if let minNote = minNote, let centerNote = centerNote, let maxNote = maxNote {
                HStack {
                    noteLabel(selection: .min, letter: minNote.capitalizedLetter())
                    
                    noteLabel(selection: .center, letter: centerNote.capitalizedLetter())
                        .foregroundColor(Color("MediumRed"))
                    
                    noteLabel(selection: .max, letter: maxNote.capitalizedLetter())
                    
                    Spacer()
                    
                    verticalStepper(
                        increment: {
                            switch noteRangeSelection {
                            case .min:
                                if minNote.position == centerNote.position {
                                    self.centerNote = centerNote.higherNote()
                                }
                                self.minNote = minNote.higherNote()
                            case .center:
                                self.centerNote = centerNote.higherNote()
                            case .max:
                                self.maxNote = maxNote.higherNote()
                            case .none:
                                break
                            }
                        }, decrement: {
                            switch noteRangeSelection {
                            case .min:
                                self.minNote = minNote.lowerNote()
                            case .center:
                                self.centerNote = centerNote.lowerNote()
                            case .max:
                                if maxNote.position == centerNote.position {
                                    self.centerNote = centerNote.lowerNote()
                                }
                                self.maxNote = maxNote.lowerNote()
                            case .none:
                                break
                            }
                        },
                        disableIncrement: disableIncrement(),
                        disableDecrement: disableDecrement()
                    )
                }
                .padding(.horizontal)
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
    private func noteLabel(selection: NoteRangeSelection, letter: String) -> some View {
        VStack {
            Text(selection.rawValue)
                .font(.caption)
            
            Text(letter)
                .font(.title)
        }
        .frame(width: 60, height: 60)
        .background(RoundedRectangle(cornerRadius: 5).fill(selection == noteRangeSelection ? Color("LightAqua") : .white))
        .onTapGesture {
            if noteRangeSelection != selection {
                noteRangeSelection = selection
            } else {
                noteRangeSelection = .none
            }
        }
    }
    
    private func disableIncrement() -> Bool {
        if let minNote = minNote, let centerNote = centerNote, let maxNote = maxNote, let clef = clef {
            switch noteRangeSelection {
            case .min:
                return minNote.position == Note.maxNote(for: clef).position || minNote.position == maxNote.position
            case .center:
                return centerNote.position == maxNote.position
            case .max:
                return maxNote.position == Note.maxNote(for: clef).position
            case .none:
                return true
            }
        }
        return true
    }
    
    private func disableDecrement() -> Bool {
        if let minNote = minNote, let centerNote = centerNote, let maxNote = maxNote, let clef = clef {
            switch noteRangeSelection {
            case .min:
                return minNote.position == Note.minNote(for: clef).position
            case .center:
                return centerNote.position == minNote.position
            case .max:
                return maxNote.position == Note.minNote(for: clef).position || maxNote.position == minNote.position
            case .none:
                return true
            }
        }
        return true
    }
    
    @ViewBuilder
    private func verticalStepper(increment: @escaping () -> Void, decrement: @escaping () -> Void, disableIncrement: Bool, disableDecrement: Bool) -> some View {
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
    private func staffLinesView() -> some View {
        VStack(spacing: staffLineSpacing) {
            ForEach(0..<5) { _ in
                Rectangle()
                    .frame(width: staffWidth, height: 2)
            }
        }
    }
    
    @ViewBuilder
    private func clefView(clef: Clef) -> some View {
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
    private func notesView() -> some View {
        HStack(spacing: 20) {
            Spacer()
            
            if let minNote = minNote, let centerNote = centerNote, let maxNote = maxNote {
                noteView(note: minNote)
                
                Spacer()
                
                noteView(note: centerNote)
                
                Spacer()
                
                noteView(note: maxNote)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func noteView(note: Note) -> some View {
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
    private func wholeNoteView() -> some View {
        Image("CellWholeNote")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 20)
    }
    
    private func calculatedExtraLinesOffset(positionsFromCenterStaff: Int, extraLines: Int) -> CGFloat {
        let isInSpace = abs(positionsFromCenterStaff) % 2 == 1
        let isBelowStaff = positionsFromCenterStaff < -4
        let finalBelowOffset = isInSpace ? -Int(noteLineSpacing) * (extraLines - 1) - Int(noteLineSpacing) - 1 : -Int(noteLineSpacing) * (extraLines - 1) - 1
        let finalAboveOffset = isInSpace ? Int(noteLineSpacing) * (extraLines - 1) + Int(noteLineSpacing) - 1 : Int(noteLineSpacing) * (extraLines - 1) - 1
        return CGFloat(isBelowStaff ? finalBelowOffset : finalAboveOffset)
    }
    
    private func createAndAddChart() {
        let instrument = Instrument(type: instrumentType!)
        var naturalNotes = [Note]()
        var flatNotes = [Note]()
        var sharpNotes = [Note]()
        var noteFingerings = [NoteFingering]()
        
        if let minNote = minNote, let maxNote = maxNote {
            naturalNotes = helperChartsController.generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .natural)
            flatNotes = helperChartsController.generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .flat)
            sharpNotes = helperChartsController.generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .sharp)
            noteFingerings = helperChartsController.generateNoteFingerings(in: categoryName, instrumentType: instrument.type, naturalNotes: naturalNotes, flatNotes: flatNotes, sharpNotes: sharpNotes)
        }
        
        let chart = FingeringChart(instrument: instrument, centerNote: centerNote, naturalNotes: naturalNotes, flatNotes: flatNotes, sharpNotes: sharpNotes, noteFingerings: noteFingerings)
        
        switch mode {
        case .add:
            helperChartsController.addChart(in: categoryName, chart: chart)
        case .update:
            helperChartsController.updateChart(in: categoryName, chart: chart)
        }
    }
}

struct AddFingeringChartView_Previews: PreviewProvider {
    static var previews: some View {
        AddFingeringChartView(categoryName: HelperChartsController.exampleChartCategory.name)
            .environmentObject(HelperChartsController.shared)
    }
}
