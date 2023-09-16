//
//  addTransactionView.swift
//  Buddy Buddy 1.0
//
//  Created by Lopez, Rafael on 9/15/23.
//

import SwiftUI

struct Transaction: Identifiable {
        let id = UUID()
        let type: String
        let name: String
        let amount: Double
    }

class TransactionHistory: ObservableObject {
        @Published var transactions: [Transaction] = []
        
        func addTransaction(type: String, name: String, amount: Double) {
            let transaction = Transaction(type: type, name: name, amount: amount)
            transactions.append(transaction)
        }
    }

struct addTransactionView: View {
        @State private var transactionType = ""
        @State private var transactionName = ""
        @State private var transactionAmount = ""
        
    @ObservedObject var transactionHistory: TransactionHistory
        
        var body: some View {
                VStack {
                    Form {
                        Section(header: Text("New Transaction:")) {
                            TextField("Name", text: $transactionName)
                            TextField("Amount", text: $transactionAmount)
                            TextField("Type", text: $transactionType)
                                .keyboardType(.decimalPad)
                        }
                    }
                        
                        Button(action: {
                            if let amount = Double(transactionAmount) {
                                transactionHistory.addTransaction(type: transactionType, name: transactionName, amount: amount)
                                
                                transactionType = ""
                                transactionName = ""
                                transactionAmount = ""
                            }
                        }) {
                            Text("log transaction")
                                
                    }
                }
                .navigationBarTitle("")
            }
        }

struct addTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let defaultHistory = TransactionHistory()
        return addTransactionView(transactionHistory: defaultHistory)
    }
}
