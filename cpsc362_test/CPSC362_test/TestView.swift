//
//  TestView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import SwiftUI
import Charts

struct CategoryItemView: View {
    var name:String
    var systemImage:String
    var body: some View {
        HStack{
            Label(name, systemImage: systemImage)
            Spacer()
            
        }
    }
}
struct TestItemView: View {
    var transaction:Transaction
    var dateFormat:DateFormatter=DateFormatter()
    
    init(transaction:Transaction){
        self.transaction=transaction
        dateFormat.dateFormat="MM/dd/yyyy"
    }
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading, spacing: 5){
                Text(transaction.item)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5){
                Text(String(format:"$%.2f",transaction.cost))
                Text(dateFormat.string(from: transaction.datetime))
            }
        }
        .padding(.horizontal)
    }
}
struct TestView: View {
    @StateObject var viewModel=TestViewViewModel()
    var body: some View {
        NavigationView{
            List(types,id:\.description){ type in
                NavigationLink {
                    List(viewModel.listItems[type]!.transactions){
                        TestItemView(transaction: $0)
                    }
                    .navigationTitle(type)
                } label: {
                    HStack{
                        Text(type)
                        Spacer()
                        Text(String(format:"$%.2f",viewModel.listItems[type]!.spent))
                    }
                }
            }
            .navigationTitle("Categories")
            .refreshable {
                viewModel.getTransactions()
            }
        }
    }
}
struct dataItem:Identifiable{
    var id=UUID()
    var x:Float
    var value:Float
}
struct MyChartView: View {
    var data:[dataItem]=[5,4,3,2,1]
        .enumerated()
        .map{ (i,v) in
            dataItem(x:Float(i),value:v)
        }
    func getCumulative()->[dataItem]{
        var result:[dataItem]=[]
        var sum:Float=0
        for (i,x) in data.enumerated() {
            sum+=x.value
            result.append(dataItem(x: Float(i), value: sum))
        }
        return result
    }
    var body: some View {
        // try line chart
        Chart{
            LineMark(
                x: .value("x", 1),
                y: .value("y", 4)
            )
            LineMark(
                x: .value("x", 2),
                y: .value("y", 2)
            )
            LineMark(
                x: .value("x", 2),
                y: .value("y", 2)
            )
            LineMark(
                x: .value("x", 3),
                y: .value("y", 2)
            )
            //ForEach(getCumulative()) {
            //    LineMark(x: .value("x", $0.x), y: .value("y", $0.value))
            //}
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CategoryItemView(name: "test", systemImage: "person.fill")
            TestView()
            TestItemView(transaction: Transaction(item: "Burger", cost: 8.99, type: "Food", datetime: Date(), uid: "12312"))
            MyChartView()
        }
    }
}
