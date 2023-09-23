//
//  TransactionsView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import Charts

struct TransactionsView: View {
    @ObservedObject var viewModel:DataViewModel
    @State private var type:String="All"
    @State private var graphType:String="Category"
    var body: some View {
        NavigationView(){
            VStack{
                List {
                    Picker("Graph", selection: $graphType) {
                        Text("Category").tag("Category")
                        Text("Time").tag("Time")
                        Text("Day").tag("Day")
                        Text("Month").tag("Month")
                        Text("Year").tag("Year")
                    }
                    .pickerStyle(.segmented)
                    
                    if graphType=="Category" {
                        Chart(viewModel.transactions){
                            BarMark(
                                x: .value("Type", $0.type),
                                y: .value("cost", $0.cost)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }
                    
                    if graphType=="Time" {
                        Chart(viewModel.getCumulativeArray(),id:\.0){
                            LineMark(
                                x: .value("Date", $0.0),
                                y: .value("cost", $0.1)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }
                    
                    if graphType=="Day" {
                        Chart(viewModel.getTransactionGroupedByTime(dateComponents: [.day,.month,.year]),id:\.0){ (date,cost) in
                            LineMark(
                                x: .value("Date", date),
                                y: .value("cost", cost)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }

                    if graphType=="Month" {
                        Chart(viewModel.getTransactionGroupedByTime(dateComponents: [.month,.year]),id:\.0){ (date,cost) in
                            LineMark(
                                x: .value("Date", date),
                                y: .value("cost", cost)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }

                    if graphType=="Year" {
                        Chart(viewModel.transactions){
                            let dateComponent=Calendar.current.dateComponents([.year], from: $0.datetime)
                            let calendar = Calendar(identifier: .gregorian)
                            let date=calendar.date(from: dateComponent)
                            BarMark(
                                x: .value("Date", date!),
                                y: .value("cost", $0.cost)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }
                        
                    Section("Filter"){
                        Picker("Category", selection: $type) {
                            Text("All").tag("All")
                            ForEach(types,id: \.description){
                                Text($0).tag($0)
                            }
                        }
                    }
                    
                    Section("Transactions"){
                        ForEach(viewModel.transactions){
                            if(type=="All") {
                                TransactionItemView(transaction: $0)
                            } else {
                                if($0.type==type) {
                                    TransactionItemView(transaction: $0)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    viewModel.getData()
                }
            }
            .navigationTitle("Transactions")
            .toolbar{
                NavigationLink( destination: AddTransactionView()){
                    Text("add transaction")
                }
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: DataViewModel())
    }
}
