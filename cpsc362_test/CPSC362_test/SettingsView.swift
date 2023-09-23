//
//  SettingsView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            List{
                Section("Account"){
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    Button("Log out") {
                        do{
                            try Auth.auth().signOut()
                            print("Log out success")
                        } catch{
                            print("Error signout")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
