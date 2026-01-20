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

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var username = ""
    @State var password = ""
    @State var isLoggedIn = false
    @State var isPasswordVisible = false;
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color(hex: "FDEBD0"), .white]),
                           startPoint: .top,
                           endPoint: .center)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer().frame(height: 80)
                
                // Header
                VStack(spacing: 8) {
                    Text("Sign In")
                        .font(.system(size: 32, weight: .bold))
                    Text("Please provide your details below to\naccess your account")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 20)
                
                // Input Fields
                VStack(spacing: 15) {
                    customTextField(icon: "person", placeholder: "Username", text: $username)
                    
                    customPasswordField(icon: "lock", placeholder: "Password", text: $password, isVisible: $isPasswordVisible)
                }
                
                // Terms Toggle
                HStack {
                    //                    Toggle("", isOn: $agreeToTerms)
                    //                        .toggleStyle(CheckboxStyle())
                    
                    Text("I agree with the ") +
                    Text("Terms and Conditions").foregroundColor(.orange) +
                    Text(" and ") +
                    Text("Privacy Policy").foregroundColor(.orange) +
                    Text(" of TranspoX")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 10)
                
                // Action Button
                Button(action: {
                    // Sign in logic
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .padding(.top, 20)
                
                // Footer
                HStack {
                    Text("Don't have an account?")
                    Button("Sign up") {}
                        .foregroundColor(.orange)
                }
                .font(.subheadline)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.horizontal, 25)
        }
    }
    
    // Custom View Components
    @ViewBuilder
    func customTextField(icon: String, placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon).foregroundColor(.gray)
            TextField(placeholder, text: text)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
    }
    
    @ViewBuilder
    func customPasswordField(icon: String, placeholder: String, text: Binding<String>, isVisible: Binding<Bool>) -> some View {
        HStack {
            Image(systemName: icon).foregroundColor(.gray)
            if isVisible.wrappedValue {
                TextField(placeholder, text: text)
            } else {
                SecureField(placeholder, text: text)
            }
            Button(action: { isVisible.wrappedValue.toggle() }) {
                Image(systemName: isVisible.wrappedValue ? "eye.slash" : "eye").foregroundColor(.gray)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
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

// Hex Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
