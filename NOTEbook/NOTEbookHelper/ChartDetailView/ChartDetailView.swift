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
        case delete(noteFingeringId: UUID, at: IndexSet)
        case move(noteFingeringId: UUID, from: IndexSet, to: Int)
        case submitFingering(noteFingeringId: UUID, at: Int?, fingering: any Fingering)
        case updateChart(FingeringChart)
    }

    @Environment(\.dismiss) private var dismiss

    var chart: FingeringChart
    var onAction: ActionClosure

    @State private var showEditSheet = false

    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: .base) {
                noteFingeringGridColumn(number: 0)
                noteFingeringGridColumn(number: 1)
            }
        }
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

    private func noteFingeringGridColumn(number: Int) -> some View {
        VStack(spacing: .base) {
            ForEach(Array(chart.noteFingerings.enumerated()), id: \.element.id) { index, noteFingering in
                if index.isEven() && number.isEven() || index.isOdd() && number.isOdd() {
                    NavigationLink {
                        NoteFingeringDetailView(noteFingering: noteFingering, type: chart.instrument.fingeringViewType) { action in
                            switch action {
                            case .delete(let atOffsets):
                                onAction?(.delete(noteFingeringId: noteFingering.id, at: atOffsets))
                            case let .move(fromOffsets, toOffset):
                                onAction?(.move(noteFingeringId: noteFingering.id, from: fromOffsets, to: toOffset))
                            case let .submit(index, fingering):
                                onAction?(.submitFingering(noteFingeringId: noteFingering.id, at: index, fingering: fingering))
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
