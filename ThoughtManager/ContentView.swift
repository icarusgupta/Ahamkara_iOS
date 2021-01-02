//
//  ContentView.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//

import SwiftUI


struct ContentView: View {
    let genericRecordList = GenericRecordModelList()
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        NavigationView {
            VStack {
                Text("Ahamkara").font(.largeTitle).foregroundColor(.purple)
                Text("Thought Manager").font(.title)
                Image("rwdevcon-bg")
                List{
                    ForEach(genericRecordList.recordModelList) { recordModel in
                        NavigationLink(destination: GenericRecord(genericRecordModel: recordModel)){
                            Text("\(recordModel.name)").frame(width: 200, height: 25).textButtonStyle()
                        }
                    }
                    NavigationLink(destination: HistoricalGraphTab()) {
                        Text("Show History").frame(width: 200, height: 25).textButtonStyle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
