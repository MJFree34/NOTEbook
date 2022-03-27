//
//  InstrumentDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/26/22.
//

import SwiftUI

struct ChartDetailView: View {
    var chart: FingeringChart
    
    var body: some View {
        Text(chart.name)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDetailView(chart: HelperChartsController.exampleChart)
    }
}
