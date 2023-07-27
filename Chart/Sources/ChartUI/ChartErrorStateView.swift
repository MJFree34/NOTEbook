//
//  ChartErrorStateView.swift
//  ChartUI
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct ChartErrorStateView: View {
    private var error: ChartError

    public init(error: ChartError) {
        self.error = error
    }

    public var body: some View {
        VStack(spacing: .small) {
            Text("Error")
                .font(.headline)
                .bold()
                .foregroundColor(.theme(.aqua, .foreground, bundle: .module))
                .multilineTextAlignment(.center)

            Text(error.localizedDescription)
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .padding(.xLarge)
    }
}

struct ChartErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ChartErrorStateView(error: .decodingError)
            .background(theme: .aqua, bundle: .module)
    }
}
