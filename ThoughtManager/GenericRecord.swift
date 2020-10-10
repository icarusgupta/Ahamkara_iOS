//
//  Record.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//

import SwiftUI

struct GenericRecord: View {
    @State private var curDate = Date()
    @State private var recordType = ""
    @State private var selectedRecordIndex = 0
    @State private var showsDatePicker: Bool = false
    @State private var showsPicker: Bool = false
    @State private var isPressed: [Bool]
    @State private var pressedFeeling: String = FeelingType.neutral.rawValue
    
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
                HStack {
                    Text("Select Date:")
                    Text("\(curDate, formatter: Helper.app.dateFormatter)")
                        .font(.subheadline)
                        .foregroundColor(Color.orange)
                        .padding(10)
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.purple, lineWidth: 5))
                }.gesture(
                    TapGesture()
                        .onEnded({
                            self.showsDatePicker.toggle()
                        })
                )
                
                if showsDatePicker {
                    DatePicker("Pick date", selection: $curDate, in: ...Date(), displayedComponents: .date)
                        //.labelsHidden()
                        .frame(height: 80, alignment: .center)
                        .compositingGroup()
                        .clipped()
                        .gesture(
                            TapGesture()
                                .onEnded({
                                    self.showsDatePicker.toggle()
                                })
                        )
                }
                HStack{
                    Text("Select \(self.recordTypeName):")
                    Text("\(self.recordTypes[selectedRecordIndex].name)")                        .font(.subheadline)
                        .foregroundColor(Color.orange)
                        .padding(10)
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.purple, lineWidth: 5))

                }.gesture(
                    TapGesture()
                        .onEnded({
                            self.showsPicker.toggle()
                        })
                )
                if showsPicker{
                    Picker(selection: $selectedRecordIndex, label: Text("")) {
                        ForEach(0 ..< self.recordTypes.count) {
                            Text("\(self.recordTypes[$0].name)")
                        }
                    }
                }
                Section {
                    VStack {
                        Text("Select \(self.genericRecordModel.scoreName):")
                        HStack(spacing: 3) {
                            Spacer()
                            Spacer()
                            ForEach(0..<8) { index in
                                let pressedFeelingLocal = self.genericRecordModel.scoreTypes[index].name
                                Text(ModelMappings.instance.feelingTypeToEmoji[pressedFeelingLocal]!)
                                    .frame(width: 35, height:35)
                                    .font(.largeTitle)
                                    .scaleEffect(self.isPressed[index] ? 1.0 : 0.7)
                                    .padding(0)
                                    .animation(.easeInOut)
                                    .gesture(
                                        TapGesture()
                                            .onEnded({
                                                for index in 0..<isPressed.count {
                                                    isPressed[index] = false
                                                }
                                                isPressed[index] = true
                                                self.pressedFeeling = pressedFeelingLocal
                                            })
                                    )
                            }
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        Text("\(self.pressedFeeling)")
                            .padding(10)
                            .foregroundColor(Color.orange)
                            .cornerRadius(40)
                            .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.purple, lineWidth: 5))

                    }
                }
            }
        }.navigationBarTitle("Create Record")
    }
}

