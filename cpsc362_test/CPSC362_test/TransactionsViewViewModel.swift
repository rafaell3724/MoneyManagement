//
//  TransactionsViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class TransactionsViewViewModel: ObservableObject {
    @Published var transactions:[Transaction]=[]
    var transactionsDict:[[String:Any]]=[]
    
    init(){
        getTransactions()
    }
    
    func getTransactions(){
        self.transactions.removeAll()
        if let uid=Auth.auth().currentUser?.uid {
            let db=Firestore.firestore()
            let query=db
                .collection("transactions")
                .whereField("uid", isEqualTo: uid)
            query.getDocuments() { (querySnapshot, error) in
                if let error=error {
                    print("Error getDocuments: \(error)")
                }
                else {
                    for doc in querySnapshot!.documents {
                        do {
                            let transaction=try doc.data(as: Transaction.self)
                            print("xxx \(doc.data())")
                            self.transactions.append(transaction)
                        } catch {
                            print(error)
                        }
                    }
                    print("getDocument success")
                }
            }
        }
        else {
            print("no one is logged in???")
        }
    }
}
