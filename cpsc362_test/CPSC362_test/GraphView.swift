//
//  GraphView.swift
//  CPSC362_test
//
//  Created by csuftitan on 9/15/23.
//

import SwiftUI
import Charts

struct GraphView: View {
    @State private var averageIsShown = false
    
    var body: some View {
        VStack{
            Chart{
                BarMark(x: .value("Type", "Groceries"),
                        y: .value("Money Spent", 100))
                .opacity(1)
                
                BarMark(x: .value("Type", "Gas"), y: .value ("Money Spent", 100))
                    .opacity(1)
                BarMark(x:
                        .value("Type", "Extertainment"), y: .value ("Money Spent", 35))
                .opacity(1)
                BarMark(x:
                        .value("Type", "Clothes"), y: .value ("Money Spent", 25))
                .opacity(1)
                BarMark(x: .value("Type", "Subscriptions"), y: .value("Money Spent", 100))
                    .opacity(1)
                
                if averageIsShown{
                    RuleMark(y: .value("Average",70))
                        .foregroundStyle(.white)
                        .annotation(position: .bottom, alignment: .bottomLeading){
                            Text("average: 70")
                        }
                }
            }
            .padding()
            .aspectRatio(2, contentMode: .fit)
            Toggle(averageIsShown ? "show average" : "Hide Average", isOn: $averageIsShown.animation())
            .padding()
            Spacer()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
