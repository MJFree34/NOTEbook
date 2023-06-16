//
//  NotePickerView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//

import SwiftUI

struct NotePickerView: View {
    @EnvironmentObject private var chartsController: ChartsController
    
    var body: some View {
        List {
            ForEach(chartsController.chartCategories) { chartCategory in
                Text(chartCategory.name)
            }
        }
    }
}

struct NotePickerView_Previews: PreviewProvider {
    static var previews: some View {
        NotePickerView()
            .environmentObject(ChartsController.shared)
    }
}
