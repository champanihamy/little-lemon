//
//  onboarding.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-17.
//

import SwiftUI

let kFirstName = "first_name"
let kLastName = "last_name"
let kEmail = "email"

struct onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    var body: some View {
        VStack{
            TextField("First Name", text: $firstName)
            
            TextField("Last Name", text: $lastName)
            
            TextField("Email", text: $email)
            Spacer()
            Button("Register") {
                if(firstName.isEmpty && lastName.isEmpty && email.isEmpty ){
                    print("User inputs can not be empty")
                }
                else{
                    if(email.isValidEmail() == true){
                        print("Email is valid")
                        UserDefaults.standard.setValue(firstName, forKey: kFirstName)
                        UserDefaults.standard.setValue(lastName, forKey: kLastName)
                        UserDefaults.standard.setValue(email, forKey: kEmail)
                        
                    }
                    
                }
                print("Registered")
            }
        }.padding(40).frame(maxHeight: 300)
    }
}


extension String {
    func isValidEmail() -> Bool {
        // A commonly used, robust regex pattern for general email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

#Preview {
    onboarding()
}
