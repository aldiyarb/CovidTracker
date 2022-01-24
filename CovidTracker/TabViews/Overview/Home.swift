//
//  Home.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 06.12.2020.
//  Copyright © 2020 Aldiyar Bekturganov. All rights reserved.

import SwiftUI
 
let dayTotal = pastData.first!
var data = [
    PieStruct(id: 0, percent: calcPercent(data: dayTotal.recovered, tot: dayTotal.positive), name: "Recovered", color: Color.green),
    PieStruct(id: 1, percent: calcPercent(data: dayTotal.deaths, tot: dayTotal.positive), name: "Deaths", color: Color.red),
    PieStruct(id: 2, percent: calcPercent(data: (dayTotal.positive - dayTotal.deaths - dayTotal.recovered), tot: dayTotal.positive), name: "Active Cases", color: Color.yellow)
]


struct Home: View {
   
    var body: some View {
        ScrollView {
//        NavigationView {
//            GeometryReader {geometry in
//            ZStack(alignment: .leading) {
                    
            VStack {
                let state = allStates.first!
                let dateString = String(state.date)
                let year = String(dateString.dropLast(4))
                let daymonth = String(dateString.dropFirst(4))
                let day = String(daymonth.dropFirst(2))
                let month = String(daymonth.dropLast(2))
                let dayOne = pastData.first
    //            .fill(Color.yellow)
                let articleNo = Int.random(in: 0..<dailyArticles.count)
                
                let articleToDisp = dailyArticles[articleNo]
                
                
                VStack {
                    if dailyArticles.count == 0 {
                        Text("No News Articles Available Today Yet")
                    }
                    else {
                        if articleToDisp.url != "" {
                            Link(destination:
                                URL(string: articleToDisp.url)!) {
                                VStack {
                                    HStack {
                                        Text("Daily Coronavirus Article :\n")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.blue)
                                        
                                    } // End of HStack
                                    Text(articleToDisp.title)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.black)
                                }
                                
                            }
                            .padding(.top, 10)
                        }
                    }
                    Divider()
                    Text("Last Updated: \(month)/\(day)/\(year)")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    Text("Total Tests Conducted: \(dayOne!.totalTestResults)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    Text("Cumulative Positive Cases: \(dayOne!.positive)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.blue)
                    Text("Cumulative Negative Cases: \(dayOne!.negative)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.blue)
                    Text("Currently Hospitalized: \(dayOne!.recovered)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.blue)

                }
                
                GeometryReader {g in
                    ZStack {
                        //Draws a whole pie chart at the center of the view using the DrawShape function below
                        ForEach(0..<data.count) { i in
                            DrawShape(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
                        }
                    }
                }
                .frame(height: 360)
                .padding(.top, 20)
                VStack {
                    Text("Out of Positive Cases: ")
                        .foregroundColor(.black)

                    HStack {
                        Text("Total Recovered Patients: \(dayOne!.recovered)")
                            .foregroundColor(.green)
                            .padding(.top, 20)
                    }
                    HStack {
                        Text("Active cases: \(dayOne!.positive - dayOne!.deaths - dayOne!.recovered)")
                            .foregroundColor(.yellow)
                    }
                    HStack {
                        Text("Total Deaths: \(dayOne!.deaths)")
                            .foregroundColor(.red)
                    }
                    
                }
                .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
            }

    }
    }
//            .navigationBarTitle("Side Menu", displayMode: .inline)

//    }
//
//    }
   
}
struct DrawShape: View {
    var center: CGPoint
    var index: Int
    var body: some View {
        //Draws a piece of the pie chart
        Path { path in
            //Moves the path object to the center of the View
            path.move(to: self.center)
            //Draws an arc which is the part of the pie chart
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.getAngle()), clockwise: false)
        }
        //Fills the piece of the pie chart based on its color
        .fill(data[index].color)
    }
    //Calculates the start angle of a piece of pie chart
    func from() -> Double {
        //Very first element start at zero degrees
        if index == 0 {
            return 0
        }
        //Calculates the starting angle of the pie chart piece based on the angles of previous pieces of the chart.
        else {
            var start: Double = 0
            for i in 0...index - 1 {
                start += Double(data[i].percent / 100) * 360
            }
            return start
        }
    }
    
    //Calculates the ending angle of the pie chart
    func getAngle() -> Double {
        var ang: Double = 0
        for i in 0...index {
            ang += Double(data[i].percent / 100) * 360
        }
            
        return ang
    }
}

//Calculates the percentage for each piece of data: recovered, deaths, active from total confirmed cases.
func calcPercent(data: Int, tot: Int) -> CGFloat {
    let percent = Double(data)/Double(tot) * 100
    let ret = CGFloat(percent)
    return ret
}
 
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


