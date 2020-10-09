//
//  Record.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//

import SwiftUI

struct GenericRecord: View {
    
    @State private var curDate = Date()
    @State private var selectedRecordIndex = 0
    var genericRecordModel: GenericRecordModel
    var recordTypes: [RecordType]
    
    init(genericRecordModel: GenericRecordModel){
        self.genericRecordModel = genericRecordModel
        self.recordTypes = self.genericRecordModel.recordTypes
    }
    
    var body: some View {
        VStack {
            DatePicker(selection: $curDate, in: ...Date(), displayedComponents: .date)
            {
                Text("Pick date")
            }
            Text("Record for \(curDate, formatter: Helper.app.dateFormatter)")
            Picker(selection: $selectedRecordIndex, label: Text("")) {
                ForEach(0 ..< self.recordTypes.count) {
                    Text("\(self.recordTypes[$0].name)")
                }
            }
            Text("You picked: \(self.recordTypes[selectedRecordIndex].name)")
        }
    }
}

