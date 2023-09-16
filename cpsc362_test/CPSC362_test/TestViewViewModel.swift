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

class TestViewViewModel: ObservableObject{
    @Published var testVar:String
    var testBool:Bool=false
    var testMsg:String=""
    @Published var listItems:[Transaction]=[]
    
    
    init(_ param:String = "default"){
        testVar=param
    }
    func testFunc(param:String){
        testBool = testVar != param
        let temp=testVar
        testVar=param
        testMsg="changed from '\(temp)' to '\(testVar)'"
        do {
            try Auth.auth().signOut()
            print("sign out success")
            // User successfully signed out
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    func getTransactions(){
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
                            let listItem=try doc.data(as: Transaction.self)
                            print("xxx \(doc.data())")
                            self.listItems.append(listItem)
                        } catch {
                            print(error)
                        }
                    }
                    print("GET document success")
                }
            }
        }
        else {
            print("no one is logged in???")
        }
    }
}
