//
//  onboarding.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-17.
//

import SwiftUI

struct onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    var body: some View {
        VStack{
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
            Button("Register") {
                print("Registered")
            }
        }.padding()
    }
}

#Preview {
    onboarding()
}
