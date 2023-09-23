//
//  TestViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct ListItem{
    var transactions:[Transaction]=[]
    var spent:Float=0
    mutating func add(transaction:Transaction){
        self.transactions.append(transaction)
        self.spent+=transaction.cost
    }
}
class TestViewViewModel: ObservableObject{
    @Published var listItems:[String:ListItem]=Dictionary(uniqueKeysWithValues: types.map {($0,ListItem())})
    
    init(){}
    
    func getTransactions(){
        let db=Firestore.firestore()
        let query=db
            .collection("transactions")
            .whereField("uid", isEqualTo: "vLX8IuYanAf2TUg7yjfqG1BR98y1")
        query.getDocuments() { (querySnapshot, error) in
            if let error=error {
                print("Error getDocuments: \(error)")
            }
            else {
                for doc in querySnapshot!.documents {
                    do {
                        let listItem=try doc.data(as: Transaction.self)
                        print("xxx \(doc.data())")
                        if self.listItems.keys.contains(listItem.type){
                            self.listItems[listItem.type]!.add(transaction: listItem)
                        }
                        else {
                            self.listItems["Others"]!.add(transaction: listItem)
                        }
                    } catch {
                        print(error)
                    }
                }
                print("GET document success")
            }
        }
    }
    
    func f(){
        let db=Firestore.firestore()
        let query=db
            .collection("transactions")
            .order(by: "cost")
        query.getDocuments() { (querySnapshot, error) in
            if let error=error {
                print("Error getDocuments: \(error)")
            }
            else {
                for (i,doc) in querySnapshot!.documents.enumerated() {
                    doc.reference.updateData(["datetime":Date()-TimeInterval(1000000*i)])
                }
                print("UPDATE document success")
            }
        }
    }
}
