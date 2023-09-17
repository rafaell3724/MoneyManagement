//
//  AddTransactionView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/8/23.
//

import SwiftUI

struct AddTransactionView: View{
    @StateObject var viewModel=AddTransactionViewViewModel()
    var body: some View{
        VStack{
            TextField("Item", text: $viewModel.item)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Cost", text: $viewModel.costStr)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Picker("Type", selection: $viewModel.type) {
                ForEach(viewModel.presetTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Button(action: {
                viewModel.addTransaction()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Add Transaction")
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
