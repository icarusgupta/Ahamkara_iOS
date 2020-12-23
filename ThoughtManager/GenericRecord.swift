//
//  Record.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//

import SwiftUI

struct GenericRecord: View {
    
    //MARK: States
    @State private var curDate = Date()
    @State private var selectedRecordIndex = 0
    @State private var selectedScoreIndex = 0
    @State private var showsDatePicker: Bool = false
    @State private var showsPicker: Bool = false
    @State private var isPressed: [Bool]
    
    @EnvironmentObject var settings: UserSettings
    
    //MARK: properties
    var genericRecordModel: GenericRecordModel
    var recordTypes: [RecordType]
    var scoreTypes: [RecordType]
    var recordTypeName: String
    
    //MARK: constructor
    init(genericRecordModel: GenericRecordModel){
        self.genericRecordModel = genericRecordModel
        self.recordTypes = self.genericRecordModel.recordTypes
        self.scoreTypes = self.genericRecordModel.scoreTypes
        self.recordTypeName = genericRecordModel.name
        _isPressed = State(initialValue: [Bool](repeating: false, count: genericRecordModel.scoreTypes.count))
    }
    
    var body: some View {
        //MARK: Form
        Form {
            Section {
                HStack {
                    Text("Select Date:").frame(width: 125, height: 25)
                    Text("\(curDate, formatter: Helper.app.dateFormatter)").frame(width: 175, height: 25)
                        .textButtonStyle()
                }.gesture(
                    TapGesture()
                        .onEnded({
                            self.showsDatePicker.toggle()
                        })
                )
                
                if showsDatePicker {
                    DatePicker("Pick date", selection: $curDate, in: ...Date(), displayedComponents: .date)
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
                    Text("Select \(self.recordTypeName):").frame(width: 125, height: 25)
                    Text("\(self.recordTypes[selectedRecordIndex].name)").frame(width: 175, height: 25)
                        .textButtonStyle()
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
                        Spacer()
                        HStack(spacing: 3) {
                            Spacer()
                            Spacer()
                            ForEach(0..<self.scoreTypes.count) { index in
                                Text(self.scoreTypes[index].desc)
                                    .frame(width: 35, height:35)
                                    .font(.largeTitle)
                                    .scaleEffect(self.isPressed[index] ? 1.3 : 0.7)
                                    .padding(0)
                                    .animation(.easeInOut)
                                    .gesture(
                                        TapGesture()
                                            .onEnded({
                                                for index in 0..<isPressed.count {
                                                    isPressed[index] = false
                                                }
                                                isPressed[index] = true
                                                self.selectedScoreIndex = index
                                                //createTask()
                                            })
                                    )
                            }
                            Spacer()
                            Spacer()
                        }
                        //Spacer()
                        Text("\(self.scoreTypes[self.selectedScoreIndex].name)")
                            .textInfoStyle()
                    }
                }
                Section {
                    VStack{
                        HStack {
                            Spacer()
                            Text("Add").onTapGesture{
                                if settings.userPatternData(
                                    recordTypeName: self.recordTypeName,
                                    date: self.curDate).contains(where: { $0.0.name == self.recordTypes[selectedRecordIndex].name }) {
                                    let matched_index = settings.userPatternData(recordTypeName: self.recordTypeName, date: self.curDate).firstIndex(where: { $0.0.name == self.recordTypes[selectedRecordIndex].name})
                                    settings.setValueUserPatternData(
                                        recordTypeName: self.recordTypeName,
                                        date: self.curDate,
                                        index: matched_index!,
                                        value: (self.recordTypes[selectedRecordIndex], self.scoreTypes[selectedScoreIndex]))
                                }
                                else{
                                    settings.appendUserPatternData(recordTypeName: self.recordTypeName,
                                                                   date: self.curDate,
                                                                   value: (self.recordTypes[selectedRecordIndex], self.scoreTypes[selectedScoreIndex]))
                                }
                                
                            }.frame(width: 100, height: 25).textButtonStyle()
                            Text("Reset").onTapGesture {
                                settings.resetUserPatternData(recordTypeName: self.recordTypeName, date: self.curDate)
                            }.frame(width: 100, height: 25).textButtonStyle()
                            Spacer()
                        }.frame(width: 300, height: 50)
                        Spacer()
                        List(settings.userPatternData(recordTypeName: self.recordTypeName, date: self.curDate), id:\.0.name) { elem in
                            HStack {
                                Text("\(elem.0.name)").frame(width: 200, height: 25).textInfoStyle()
                                Text("\(elem.1.desc)").frame(width: 50, height: 25).textInfoStyle()
                            }
                        }
                    }
                }
            }
            //MARK: Navigation link
            NavigationLink(destination: OneDayRecord(recordTypeName: self.recordTypeName, curDate: self.curDate)) {
                Text("Show Record").frame(width: 200, height: 25).textButtonStyle()
            }
            .navigationBarTitle("Create Record").frame(height: 50)
        }
    }
}

