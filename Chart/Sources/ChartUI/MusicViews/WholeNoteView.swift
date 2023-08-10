//
//  WholeNoteView.swift
//  ChartUI
//
//  Created by Matt Free on 7/30/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import CommonUI
import SwiftUI

public struct WholeNoteView: View {
    private let ratio: Double

    public init(ratio: Double = 1.0) {
        self.ratio = ratio
    }

    public var body: some View {
        ResizableImage(Constants.Note.whole, bundle: Bundle.module)
            .frame(height: 20 * ratio)
    }
}

struct WholeNoteView_Previews: PreviewProvider {
    static var previews: some View {
        WholeNoteView()
            .previewComponent()
    }
}
