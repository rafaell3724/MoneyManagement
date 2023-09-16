//
//  BudgetTracker.swift
//  Buddy Buddy 1.0
//
//  Created by Lopez, Rafael on 9/15/23.
//

import SwiftUI


class BudgetTracker: ObservableObject {
    @Published var limit: Double = 0.0
        
    func setNewLimit(limit: Double) {
        self.limit = limit
    }
}

struct setBudgetView: View {
    @State private var budgetLimit: Double = 0
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var budgetTracker: BudgetTracker

        var body: some View {
                VStack {
                    Form {
                        Section(header: Text("Set Monthly Budget:")) {
                            TextField("Budget Limit", value: $budgetLimit, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                            }
                    }

                    Button(action: {
                        if budgetLimit > 0 {
                                            budgetTracker.setNewLimit(limit: budgetLimit)
                                                budgetLimit = 0
                            self.presentationMode.wrappedValue.dismiss()
                                            }
                    }) {
                        Text("Set Limit")
                    }
                }
            }
}

struct setBudgetView_Previews: PreviewProvider {
        static var previews: some View {
            setBudgetView(budgetTracker: BudgetTracker())
        }
}
