//
//  ContentView.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//

import SwiftUI


struct ContentView: View {
    let genericRecordList = GenericRecordModelList()
    
    var body: some View {
        //Image("ion")
        NavigationView {
            VStack {
                List(genericRecordList.recordModelList, id:\.name){ recordModel in
                //let recordModel = genericRecordList!.recordModelList
                NavigationLink(destination: GenericRecord(genericRecordModel: recordModel )){
                        Text("\(recordModel.name)")
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
