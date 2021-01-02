//
//  HistoricalGraph.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//
import SwiftUI

class DateVars: ObservableObject{
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
}

enum DateVarType: String {
    case startDate, endDate
}


struct Legend: Hashable {
    let color: Color
    let label: String
}

struct Bar: Identifiable {
    let id: UUID
    let value: Float
    let label: String
    let date: Date
    let legend: Legend
}

struct BarsView: View {
    let bars: [Bar]
    let max: Float

    init(bars: [Bar]) {
        self.bars = bars
        self.max = self.bars.map { $0.value }.max() ?? 0
    }

    var body: some View {
        VStack{
            GeometryReader { geometry in
                HStack(alignment: .bottom, spacing: 2) {
                    ForEach(self.bars.indices) { i in
                        let bar = self.bars[i]
                        Capsule()
                            .fill(bar.legend.color)
                            .frame(width: 10, height: CGFloat(bar.value) / CGFloat(self.max) * geometry.size.height)
                             //.overlay(Rectangle().stroke(Color.white))
                            .accessibility(label: Text(bar.label))
                            .accessibility(value: Text(bar.legend.label))
                    }
                }
            }
            HStack(alignment: .top, spacing: 2) {
                ForEach(self.bars.indices) { i in
                    let bar = self.bars[i]
                    if (i % 4 == 0){
                        Text(stringFromDate(bar.date, format: "MMM-dd"))
                            .frame(width: 10*4, height: 25)
                            .font(.custom("Helvetica Neue", size: 10))
                            //.accessibility(label: Text(bar.label))
                            //.accessibility(value: Text(bar.legend.label))
                    }
                }
            }
        }
    }
}

struct LegendView: View {
    private let legends: [Legend]

    init(bars: [Bar]) {
        legends = Array(Set(bars.map { $0.legend }))
    }

    var body: some View {
        HStack(alignment: .center) {
            ForEach(legends, id: \.self) { legend in
                VStack(alignment: .center) {
                    Circle()
                        .fill(legend.color)
                        .frame(width: 16, height: 16)

                    Text(legend.label)
                        .font(.subheadline)
                        .lineLimit(nil)
                }
            }
        }
    }
}
struct HistoricalGraphTab: View {
        
    @EnvironmentObject var dateVars: DateVars
    @EnvironmentObject var summaryData: SummaryData
    @State var userPatternType: String = UserPatternType.Activity.rawValue
    @State var isPressed: [Bool]
    @State var bars: [Bar] = []
    let recordList: [GenericRecordModel] = GenericRecordModelList().recordModelList
    var legendMap: [String: Legend] = [:]
    
    func getDates() -> [Date]{
        let calendar = Calendar.current
        var curDate = dateVars.startDate
        var dateList = [curDate]
        while curDate <= dateVars.endDate {
            let components = calendar.dateComponents(
                [.hour],
                from: curDate)
            curDate = calendar.nextDate(
                after: curDate,
                matching: components,
                matchingPolicy: .nextTime)!
            dateList.append(curDate)
        }
        return dateList
    }
        
    init(){
        _isPressed = State(initialValue: [Bool](repeating: false, count: 2))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        for elem in ModelMappings.instance.feelingList{
            self.legendMap[elem] = Legend(color: ModelMappings.instance.feelingMap[elem]!.3, label: elem)
            }
    }
    
    func createBars() -> [Bar]{
        var bars: [Bar] = []
        let dateList = getDates()
        for date in dateList {
            let dailyRecordList = self.summaryData.userPatternData(recordTypeName: self.userPatternType, date: date)
            var specificRec = dailyRecordList.first(where: {$0.0.name == "office_work"})
            if specificRec != nil{
                bars.append(Bar(id: UUID(),
                                value: specificRec!.1.value,
                                label: specificRec!.1.name,
                                date: date,
                                legend: self.legendMap[specificRec!.1.name]!))
            }
        }
        return bars
    }

    
    var body: some View {
        Section{
            VStack{
                Form {
                    TDateView(dateVarType: DateVarType.startDate)
                    TDateView(dateVarType: DateVarType.endDate)
                    VStack {
                        Text("Activity/Thought:")
                        Spacer()
                        VStack(spacing: 3) {
                            ForEach(0..<recordList.count) { index in
                                Text(self.recordList[index].name)
                                    .frame(width: 200, height:40)
                                    .background(self.isPressed[index] ? Color.yellow : Color.gray)
                                    .padding(0)
                                    .animation(.easeInOut)
                                    .gesture(
                                        TapGesture()
                                            .onEnded({
                                                for index in 0..<isPressed.count {
                                                    isPressed[index] = false
                                                }
                                                isPressed[index] = true
                                                self.userPatternType = self.recordList[index].name
                                            })
                                    )
                            }

                    Text("Show").frame(width: 200, height: 25).textButtonStyle()
                        .onTapGesture(){
                            self.summaryData.retrieveData(startDate: self.dateVars.startDate,
                                                  endDate: self.dateVars.endDate,
                                                  recordTypeName: self.userPatternType)
                            self.bars = createBars()
                            }
                        }
                    }
                }
            }
        }
        Section{
            GeometryReader { geometry in
                Group {
                    if self.bars.isEmpty {
                        Text("There is no data to display chart...")
                    }
                    else {
                        ScrollView(.horizontal)
                            {
                            VStack
                                {
                                BarsView(bars: bars)
                                LegendView(bars: bars)
                                    .padding(5)
                                    .accessibility(hidden: true)
                                }.frame(width: geometry.size.width)
                            }.frame(minHeight: geometry.size.height)
                        }
                    }
                }
        }
    }
}



struct TDateView: View{
    
    @EnvironmentObject var dateVars: DateVars
    
    var dateVarType: DateVarType
    @State private var showsDatePicker: Bool = false
    
    init(dateVarType: DateVarType){
        self.dateVarType = dateVarType
    }
        
    var body: some View{
        HStack{
            Text(self.dateVarType.rawValue).frame(width: 125, height: 40)
            Text("\((self.dateVarType == DateVarType.startDate) ? self.dateVars.startDate : self.dateVars.endDate, formatter: Helper.app.dateFormatter)").frame(width: 175, height: 40)
            .textButtonStyle()
        }.gesture(
            TapGesture()
                .onEnded({
                    self.showsDatePicker.toggle()
                }))
        
        if self.showsDatePicker {
            DatePicker("Pick \(self.dateVarType.rawValue)",
                       selection: (self.dateVarType == DateVarType.startDate) ? $dateVars.startDate : $dateVars.endDate,
                       in: ...Date(),
                       displayedComponents: .date)
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
    }
}
