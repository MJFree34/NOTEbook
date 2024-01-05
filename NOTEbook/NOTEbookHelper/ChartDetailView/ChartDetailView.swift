//
//  ChartDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/26/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

struct ChartDetailView: View, ActionableView {
    enum Action {
        case addFingering(noteFingeringId: UUID, fingering: any Fingering)
        case delete(noteFingeringId: UUID, at: IndexSet)
        case move(noteFingeringId: UUID, from: IndexSet, to: Int)
        case updateChart(FingeringChart)
        case updateFingering(noteFingeringId: UUID, at: Int, fingering: any Fingering)
    }

    @Environment(\.dismiss) private var dismiss

    var chart: FingeringChart
    var onAction: ActionClosure

    @State private var showEditSheet = false

    var body: some View {
        noteFingeringGrid
            .padding(edges: .horizontal, spacing: .base)
            .background(theme: .aqua)
            .navigationTitle(chart.instrument.name)
            .sheet(isPresented: $showEditSheet) {
                AddEditChartView(chart: chart) { action in
                    switch action {
                    case .submitChart(let updatedChart):
                        onAction?(.updateChart(updatedChart))
                    }
                }
                .interactiveDismissDisabled()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showEditSheet = true
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
    }

    private var noteFingeringGrid: some View {
        GeometryReader { geo in
            ScrollView {
                let paddedGridWidth = Int(geo.frame(in: .local).width + Spacing.base.rawValue)
                let paddedMinCellWidth = Constants.minNoteFingeringCellWidth + Int(Spacing.base.rawValue)
                let numCols = paddedGridWidth / paddedMinCellWidth

                HStack(alignment: .top, spacing: .base) {
                    ForEach(0..<numCols, id: \.self) { number in
                        noteFingeringGridColumn(number: number, modMultiplier: numCols)
                    }
                }
            }
        }
    }

    private func noteFingeringGridColumn(number: Int, modMultiplier: Int) -> some View {
        VStack(spacing: .base) {
            ForEach(Array(chart.noteFingerings.enumerated()), id: \.element.id) { index, noteFingering in
                if index % modMultiplier == number {
                    NavigationLink {
                        NoteFingeringDetailView(noteFingering: noteFingering, type: chart.instrument.fingeringViewType) { action in
                            switch action {
                            case .add(let fingering):
                                onAction?(.addFingering(noteFingeringId: noteFingering.id, fingering: fingering))
                            case .delete(let atOffsets):
                                onAction?(.delete(noteFingeringId: noteFingering.id, at: atOffsets))
                            case let .move(fromOffsets, toOffset):
                                onAction?(.move(noteFingeringId: noteFingering.id, from: fromOffsets, to: toOffset))
                            case let .update(index, fingering):
                                onAction?(.updateFingering(noteFingeringId: noteFingering.id, at: index, fingering: fingering))
                            }
                        }
                    } label: {
                        NoteFingeringCell(noteFingering: noteFingering)
                            .foregroundColor(calculateCellForegroundColor(noteFingering: noteFingering))
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }

    private func calculateCellForegroundColor(noteFingering: NoteFingering) -> Color {
        let highlight = noteFingering.notes.first == chart.centerNote
        let isEmpty = noteFingering.fingerings.isEmpty
        let color: Color = highlight ? .theme(.aqua, .foreground) : .contrast(.foreground)
        return color.opacity(isEmpty ? 0.5 : 1)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TintedNavigationStack {
            ChartDetailView(chart: .placeholder, onAction: nil)
        }
    }
}
