//
//  home.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-19.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Tab("Menu", image: "house") {
                Menu()
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
