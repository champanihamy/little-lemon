//
//  home.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-19.
//

import SwiftUI
import CoreData

struct Home: View {
    let persistantController = PersistenceController.shared
    
    var body: some View {
        TabView {
            Tab("Menu", image: "house") {
                Menu().environment(\.managedObjectContext, persistantController.container.viewContext)
            }
            Tab("Profile", image: "person") {
                UserProfile()
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    Home()
}
