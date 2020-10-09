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
    @State var showsDatePicker: Bool = false
    @State var showsPicker: Bool = false
    @State var isPressed: [Bool]
    @State var pressedFeeling: String = FeelingType.neutral.rawValue
    
    var genericRecordModel: GenericRecordModel
    var recordTypes: [RecordType]
    var recordTypeName: String
    
    init(genericRecordModel: GenericRecordModel){
        self.genericRecordModel = genericRecordModel
        self.recordTypes = self.genericRecordModel.recordTypes
        self.recordTypeName = genericRecordModel.name
        _isPressed = State(initialValue: [Bool](repeating: false, count: genericRecordModel.scoreTypes.count))
    }
    
    var body: some View {
        Form {
            Section {
                Text("Choose date to record activity: \(curDate, formatter: Helper.app.dateFormatter)")
                    .onTapGesture {
                        self.showsDatePicker.toggle()
                    }
                if showsDatePicker {
                    DatePicker("Pick date", selection: $curDate, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .frame(height: 80, alignment: .center)
                        .compositingGroup()
                        .clipped()
                        .onTapGesture {
                            self.showsDatePicker.toggle()
                        }
                }
                Text("Choose \(self.recordTypeName) type")
                    .onTapGesture {
                        self.showsPicker.toggle()
                    }
                if showsPicker{
                    Picker(selection: $selectedRecordIndex, label: Text("")) {
                        ForEach(0 ..< self.recordTypes.count) {
                            Text("\(self.recordTypes[$0].name)")
                        }
                    }
                }
                VStack {
                    Divider()
                    //ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(0..<8) { index in
                            let pressedFeelingLocal = self.genericRecordModel.scoreTypes[index].name
                            Image(pressedFeelingLocal)
                                .frame(width: 30, height:30)
                                .scaleEffect(self.isPressed[index] ? 2.0 : 1.0)
                                .animation(.easeInOut)
                                .foregroundColor(.green)
                                .gesture(
                                    TapGesture()
                                        .onEnded({
                                            isPressed[index] = true
                                            self.pressedFeeling = pressedFeelingLocal
                                        })
                                )
                        }
                    }.padding()
                    //}.frame(height: 100)
                    Divider()
                    Spacer()
                }.background(Color.black)
            }
        }
    }
}

