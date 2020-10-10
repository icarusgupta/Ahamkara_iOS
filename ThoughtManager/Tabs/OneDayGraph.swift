//
//  OneDayGraph.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//

import SwiftUI

struct OneDayGraphTab: View {
        
    @State private var curDate = Date()
    
    var body: some View {
        VStack {
            //DatePicker(selection: $curDate, in: ...Date(), displayedComponents: .date) {
            //    Text("Pick date")
            //}
            //Text("Record thoughts for \(curDate)")
        }
    }
}

struct OneDayGraphTab_Previews: PreviewProvider {
    static var previews: some View {
        OneDayGraphTab()
    }
}
