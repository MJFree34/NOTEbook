//
//  HelperHomeView.swift
//  PackageName
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

struct HelperHomeView: View {
    @StateObject var viewModel = ChartsViewModel()

    var body: some View {
        NavigationStack {
            CategoriesListView(viewState: $viewModel.categoriesListViewState) { [weak viewModel] action in
                switch action {
                case .start:
                    viewModel?.start()
                }
            }
        }
        .tint(.theme(.aqua, .foreground))
    }
}

struct HelperHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HelperHomeView()
    }
}
