//
//  budget_app_pracApp.swift
//  budget_app_prac
//
//  Created by gabe on 8/29/23.
//

import SwiftUI

@main
struct budget_app_pracApp: App {
    // Create an instance of BudgetTracker
    @StateObject var budgetTracker = BudgetTracker()
    
    var body: some Scene {
        WindowGroup {
            // Pass the budgetTracker instance to ContentView
            ContentView(budgetTracker: budgetTracker)
        }
    }
}
