//
//  RecordChart.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 09/10/2020.
//

import Foundation
import SwiftUI

public struct GradientColor {
    public let start: Color
    public let end: Color
    
    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

struct PrecipitationChart: View {
    @State private var celsius: Double = 0
    var index: Int = 100
    var touchLocation: CGFloat = -1
    @State var scaleValue: Int = 0
    var delayAnim: Double = 0.2
    var lowest_val: Int = -8
    var feelingTypeToAttributes: [Int: (Color, Int, String)] = [0: (Color.purple, 4, "blissful"),
    1: (Color.green, 2, "happy"),
    2: (Color.pink, 2, "excited"),
    3: (Color.white, 0, "neutral"),
    4: (Color.blue, -2, "anxious"),
    5: (Color.orange, 4, "stressed"),
    6: (Color.red, -8, "angry"),
    7: (Color.red, -8, "depressed")]
    
    var gradient: GradientColor?

    func sumPrecipitation(_ month: Int) -> Double {
        return 0.0
        
    }

    func monthAbbreviationFromInt(_ month: Int) -> String {
      let ma = Calendar.current.shortMonthSymbols
      return ma[month]
    }

    func colorFromInt(_ feelingType: Int) -> (Color, Int, String) {
        return feelingTypeToAttributes[feelingType] ?? (Color.white, 0, "neutral")
    }
    
    func createPrecipitationData() -> [(String, Double)]{
        var precipitation_data: [(String, Double)]
        let month_list_int = 0..<12
        precipitation_data = []
        for month in month_list_int{
            precipitation_data.append((monthAbbreviationFromInt(month), self.sumPrecipitation(month)))
        }
        return precipitation_data
    }

    var body: some View {
        //LineView(data: createPrecipitationData(), title: "Line chart", legend: "Full //screen") // legend is optional, use optional .padding()
        //BarChartView(data: ChartData(values: createPrecipitationData()), title: //"Precipitation", legend: "Monthly", form: ChartForm.medium) // legend is //optional
        VStack {
            Slider(value: $celsius, in: -100...100, step: 0.1)
            Text("\(celsius) Celsius is \(celsius * 9 / 5 + 32) Fahrenheit")
        }

        ZStack{
        // 1
        RoundedRectangle(cornerRadius: 20).fill(Color.black)
        .shadow(color: Color.gray, radius: 8)
        HStack {
          // 2
          ForEach(0..<8) { feeling in
            // 3
            VStack {
              // 4
              Spacer()
              // 5
              Image(colorFromInt(feeling).2)
              .scaleEffect(CGSize(width: 2, height: self.scaleValue), anchor: .bottom)
              .onAppear(){
                    self.scaleValue = 2
                }
                .animation(Animation.spring().delay(self.delayAnim))
              RoundedRectangle(cornerRadius: 4).fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: colorFromInt(feeling).0, end: colorFromInt(feeling).0).getGradient(), startPoint: .bottom, endPoint: .top))
                .frame(width: 10, height: (CGFloat(colorFromInt(feeling).1)-CGFloat(self.lowest_val)) * 5.0)
                .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
                .onAppear(){
                    self.scaleValue = 2
                }
                .animation(Animation.spring().delay(self.delayAnim))
              // 6
                Text("\(self.colorFromInt(feeling).2)")
                .rotationEffect(.degrees(-90))
                .foregroundColor(Color.white)
                //.font(.footnote)
                .frame(height: 120)
            }
          }
        }
      }
    }
}

