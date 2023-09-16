//
//  TransactionItemView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//

import SwiftUI

struct TransactionItemView: View {
    var transaction:Transaction
    var body: some View {
        HStack(alignment: .center){
            Text(transaction.item)
            Spacer()
            VStack(alignment: .trailing, spacing: 10){
                Text(String(format:"$%.2f",transaction.cost))
                Text(transaction.type)
            }
        }
        .padding()
    }
}

struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(
            transaction:Transaction(
                item:"Burger",
                cost:9.99,
                type:"food",
                uid: ""
            )
        )
    }
}
