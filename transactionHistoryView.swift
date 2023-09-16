//
//  transactionHistory.swift
//  budget_app_prac
//
//  Created by gabe on 9/15/23.
//

import SwiftUI

struct transactionHistoryView: View {
    @ObservedObject var transactionHistory: TransactionHistory

    var body: some View {
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



struct transactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        transactionHistoryView(transactionHistory: TransactionHistory())
    }
}
