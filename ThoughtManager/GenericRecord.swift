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
    //@State private var enteredRecordAndScoreList: [(RecordType, RecordType)]
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
        //_enteredRecordAndScoreList = State(initialValue: [])
    }
    
    var body: some View {
        //MARK: Form
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
                            ForEach(0..<self.scoreTypes.count) { index in
                                Text(self.scoreTypes[index].desc)
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
                                                self.selectedScoreIndex = index
                                            })
                                    )
                            }
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        Text("\(self.scoreTypes[self.selectedScoreIndex].name)")
                            .padding(10)
                            .foregroundColor(Color.orange)
                            .cornerRadius(40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.purple, lineWidth: 5))
                        
                    }
                }
                Section {
                    VStack{
                        HStack {
                            Text("Add more").onTapGesture{
                                settings.enteredRecordAndScoreList.append((self.recordTypes[selectedRecordIndex], self.scoreTypes[selectedScoreIndex]))
                            }.padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                            Text("Reset").onTapGesture {
                                settings.enteredRecordAndScoreList = []
                            }.padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                        }
                        List(settings.enteredRecordAndScoreList, id:\.0.name) { elem in
                            Text("\(elem.0.name):\(elem.1.desc)")
                        }
                    }
                }
            }
            //MARK: Navigation link
            NavigationLink(destination: OneDayRecord()) {
                Text("Show Record")
            }.padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .navigationBarTitle("Create Record")
        }
    }
}

