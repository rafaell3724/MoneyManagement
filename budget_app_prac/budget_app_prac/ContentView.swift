//
//  ContentView.swift
//  budget_app_prac
//
//  Created by gabe on 8/29/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var budgetTracker: BudgetTracker
    @ObservedObject var transactionHistory = TransactionHistory()
    var body: some View {
        TabView {
            Text("This Month's Budget: $\(budgetTracker.limit, specifier: "%.2f")")
                .font(.headline)
                .padding()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Budget")
                }
                .tag(0)
            
            setBudgetView(budgetTracker: budgetTracker)
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("New Limit")
                }
                .tag(1)
            
            addTransactionView(transactionHistory: transactionHistory)
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add Transaction")
                }
                .tag(2)
            
            transactionHistoryView(transactionHistory: transactionHistory)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Transaction History")
                }
                .tag(3)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(budgetTracker: BudgetTracker())
    }
}


