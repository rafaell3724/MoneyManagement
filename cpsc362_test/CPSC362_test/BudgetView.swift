//
//  BudgetView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct BudgetView: View {
    @ObservedObject var data:DataViewModel
    var budget:[String:Float]=Dictionary(uniqueKeysWithValues: types.map{($0,0)})
    var body: some View {
        NavigationView {
            List(types,id: \.description){ type in
                Section(type) {
                    Text(String(format: "spent: $%.2f", data.categories[type]!))
                    Text(String(format: "budget: $%.2f", budget[type]!))
                }
            }
            .navigationTitle("Budget")
            .toolbar{
                NavigationLink( destination: SetBudgetView(budget: budget)){
                    Text("Set budget")
                }
            }
        }
    }
}
struct SetBudgetView: View {
    @State var budget:[String:Float]
    var body: some View {
        Form{
            ForEach(types,id: \.description) { type in
                Section(type){
                    TextField(type, value: $budget[type], formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
            }
        }
        .navigationTitle("Set budget")
        Button("Set budget") {
            guard let uid=Auth.auth().currentUser?.uid else {
                print("set budget fail")
                return
            }
            let db=Firestore.firestore()
            let colRef=db.collection("budget")
            var data:[String:Any]=budget
            data["uid"]=uid
            colRef.addDocument(data:budget)
            print("set document done")
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SetBudgetView(budget: [
                "Food":0,
                "Entertainment":0,
                "Education":0,
                "Transportation":0,
                "Others":0
            ])
            BudgetView(data: DataViewModel())
        }
    }
}
