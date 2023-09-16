//
//  transactionHistoryView.swift
//  Buddy Buddy 1.0
//
//  Created by Lopez, Rafael on 9/15/23.
//
import SwiftUI
import Charts

struct transactionHistoryView: View {
    @ObservedObject var transactionHistory: TransactionHistory
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
            List(transactionHistory.transactions) { transaction in
                VStack(alignment: .leading) {
                    Text("Type: \(transaction.type)")
                    Text("Name: \(transaction.name)")
                    Text("Amount: \(transaction.amount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Transaction History")
        }
    }
}



struct transactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        transactionHistoryView(transactionHistory: TransactionHistory())
    }
}

