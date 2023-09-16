//
//  TestView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import SwiftUI

struct TestView: View {
    @StateObject var viewModel=TestViewViewModel()
    var body: some View {
        VStack{
            List(viewModel.listItems,id:\.id){
                Text($0.item)
            }
            if viewModel.testBool{
                Text(viewModel.testMsg)
                    .foregroundColor(.red)
            }
            TextField("text?",text: $viewModel.testVar)
            Text(viewModel.testVar)
                .foregroundColor(.green)
            Button("xyz"){
                viewModel.testFunc(param: "dd")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
