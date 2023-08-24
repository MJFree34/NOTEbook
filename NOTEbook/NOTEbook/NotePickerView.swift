//
//  NotePickerView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import CommonUI
import SwiftUI

struct NotePickerView: View {
    @StateObject private var viewModel = ChartsViewModel()

    var body: some View {
        content
            .onAppear {
                viewModel.start()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.screenState {
        case .loading:
            ProgressView()
        case .loaded:
            Text("Hello World")
        case .error(let error):
            Text("Error: \(error.localizedDescription)")
        }
    }
}

struct NotePickerView_Previews: PreviewProvider {
    static var previews: some View {
        NotePickerView()
    }
}
