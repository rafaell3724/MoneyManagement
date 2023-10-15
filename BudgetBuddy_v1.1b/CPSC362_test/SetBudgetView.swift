//
//  SetBudgetView.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/7/23.
//
import SwiftUI

struct SetBudgetView: View {
    @StateObject var viewModel:SetBudgetViewViewModel
    
    init(_ currentBudget:[String:Double],_ refreshBudgetPage:@escaping ()->Void){
        _viewModel=StateObject(wrappedValue: SetBudgetViewViewModel(currentBudget,refreshBudgetPage))
    }
    
    var body: some View {
        ZStack{
            Form {
                ForEach(TYPES, id: \.self) { type in
                    Section(header: Text(type)) {
                        TextField("Enter budget for \(type)", value: Binding(
                            get: { viewModel.budget[type] ?? 0 },
                            set: { newValue in
                                viewModel.budget[type] = Double(newValue)
                            }
                        ), formatter: {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            formatter.minimumFractionDigits = 2
                            return formatter
                        } ())
                        .keyboardType(.decimalPad)
                    }
                }
                Button("Set budget") {
                    viewModel.setBudget()
                }
                .alert(viewModel.alertMessage,isPresented: $viewModel.isAlert){}
            }
            .navigationTitle("Set Budget")
            .scrollContentBackground(.hidden)
            .background(LinearGradient(gradient: Gradient(colors: [.mint, .white]), startPoint: .top, endPoint: .bottom))
        }
    }
}

struct SetBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        SetBudgetView(Dictionary(uniqueKeysWithValues: TYPES.map{($0,0)}),{
            print("refresh")
        })
    }
}
