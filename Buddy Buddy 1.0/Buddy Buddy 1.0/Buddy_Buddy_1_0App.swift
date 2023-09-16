//
//  Buddy_Buddy_1_0App.swift
//  Buddy Buddy 1.0
//
//  Created by Lopez, Rafael on 9/15/23.
//

import SwiftUI

@main
struct Buddy_Buddy_1_0App:  App {
    // Create an instance of BudgetTracker
    @StateObject var budgetTracker = BudgetTracker()
    
    var body: some Scene {
        WindowGroup {
            // Pass the budgetTracker instance to ContentView
            ContentView(budgetTracker: budgetTracker)
        }
    }
}
