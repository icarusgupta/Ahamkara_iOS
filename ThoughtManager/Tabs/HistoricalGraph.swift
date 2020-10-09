//
//  HistoricalGraph.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//
import SwiftUI

struct HistoricalGraphTab: View {
        
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        VStack {
            DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                Text("Pick start date")
            }
            DatePicker(selection: $endDate, in: ...Date(), displayedComponents: .date) {
                Text("Pick end date")
            }
            Text("Record thoughts between \(startDate) \(endDate)")
        }
    }
}

struct HistoricalGraphTab_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalGraphTab()
    }
}
