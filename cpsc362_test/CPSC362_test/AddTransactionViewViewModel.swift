//
//  AddTransactionViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class AddTransactionViewViewModel: ObservableObject{
    @Published var item:String=""
    @Published var costStr:String=""
    @Published var cost:Float=0
    @Published var type:String=""
    
    init(){}
    
    func log(){
        if let temp=Float(costStr) {
            cost=temp
            print("item=\(item), cost=\(cost), type=\(type)")
        }
        else {
            print("invalid float value: cost")
        }
    }
    
    func addTransaction(){
        log()
        if let uid=Auth.auth().currentUser?.uid {
            print("uid: \(uid)")
            let db=Firestore.firestore()
            let colRef=db.collection("transactions")
            let data=[
                "item":item,
                "cost":cost,
                "type":type,
                "uid":uid
            ] as [String : Any]
            colRef.addDocument(data: data)
        }
        else {
            print("no user logged in")
        }
    }
}
