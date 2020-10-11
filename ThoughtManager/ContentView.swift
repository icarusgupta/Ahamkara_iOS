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
                Text("Thought Manager")
                Image("rwdevcon-bg")
                List(genericRecordList.recordModelList, id:\.name){ recordModel in
                NavigationLink(destination: GenericRecord(genericRecordModel: recordModel )){
                        Text("\(recordModel.name)")
                    }
                }
            }
            NavigationLink(destination: TempView()){
                        Text("Temp")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
