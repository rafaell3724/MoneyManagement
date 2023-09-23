//
//  GraphView.swift
//  CPSC362_test
//
//  Created by csuftitan on 9/15/23.
//

import SwiftUI
import Charts

struct GraphView: View {
    @ObservedObject var data:DataViewModel
    @State private var averageIsShown = false
    
    var body: some View {
        NavigationView{
            VStack{
                Chart{
                    ForEach(types,id:\.description){ type in
                        BarMark(x: .value("Type", type),
                                y: .value("Money Spent", data.categories[type]!))
                        .opacity(1)
                    }
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
            .navigationTitle("Graphs")
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(data:DataViewModel())
    }
}
