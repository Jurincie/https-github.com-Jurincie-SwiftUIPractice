//
//  FormView.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/19/23.
//

import SwiftUI

struct FormView: View {
    enum Status {
        case passwordError
        case userNameError
        case noError
        case emailError
        case unknownError
    }
    
    enum Field: Hashable {
        case username
        case password
        case emailAddress
     }

    @FocusState private var focusedField: Field?
    @State private var submitButtonAnimating = false
    @State private var showPassword = false
    @State private var userName = ""
    @State private var password = ""
    @State private var emailAddress = ""
    @State private var showSuccessAlert = false
    @State private var showFailureAlert = false
    @State private var status = Status.noError
    
    struct PulseButtonScaleStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label.scaleEffect(configuration .isPressed ? 2.0 : 1.0)
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Label(
                    title: { Text("REGISTRATION") },
                    icon: { Image(systemName: "pencil.circle") }
                )
                Image(systemName: "pencil.circle")
            }
            Form() {
                Section("USER NAME") {
                    TextField("Enter UserName",
                              text: $userName)
                    .focused($focusedField, equals: .username)
                    .keyboardType(.asciiCapable)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                }
                Section("PASSWORD") {
                    SecureField("Enter a password", text: $password)
                        .focused($focusedField, equals: .password)
                        .keyboardType(.asciiCapable)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .overlay(alignment: .trailing) {
                            Button(role: .cancel) {
                                showPassword.toggle()
                            }
                        label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                        }
                    }
                }
                Section("EMAIL") {
                    TextField("Enter Email",
                              text: $emailAddress)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .frame(height: 350)
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(title: Text("Registration Succeeded."),
                  message: Text("CONGRATULATIONS!"))
        }
        .alert(isPresented: $showFailureAlert) {
            Alert(title: Text("Registration Failed."),
                  message: Text("Unknown Error"))
        }
        
        Button("SUBMIT") {
            submitButtonAnimating = true
            var success = false
            Task {
                if areAllFieldsFormattedCorrectly(username: userName, 
                                                  password: password,
                                                  emailAddress: emailAddress) {
                    success = await sendRegistrationInfo(userName,
                                                         password,
                                                         emailAddress)
                }
                if success {
                    showSuccessAlert = true
                } else {
                    showFailureAlert = true
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
              self.focusedField = .username
            }
          }
        .frame(width: 200,
               height: 50)
        .background(Color.blue)
        .foregroundColor(.white)
        .buttonStyle(PulseButtonScaleStyle())
        .cornerRadius(12)
        .padding()
        
        Button("CANCEL") {
            
        }
        .frame(width: 200,
               height: 50)
        .background(Color.red)
        .foregroundColor(.white)
        .buttonStyle(PulseButtonScaleStyle())
        .cornerRadius(12)
        .padding()
    }
    
    func areAllFieldsFormattedCorrectly(username: String,
                                        password: String,
                                        emailAddress: String) -> Bool {
        if !isUsernameFormattedCorrectly(username) {
            self.userName = ""
            showFailureAlert = true
            focusedField = .username
            return false
        } else if !isPasswordFormattedCorrectly(password) {
            self.password = ""
            showFailureAlert = true
            focusedField = .password
            return false
        } else if !isEmailAddressFormattedCorrectly(emailAddress) {
            self.emailAddress = ""
            showFailureAlert = true
            focusedField = .emailAddress
            return false
        }
        
        return true
    }
    
    func isPasswordFormattedCorrectly(_ password: String) -> Bool {
        // USE Regex to check password for:
        // length >= 8
        // at least one Capital letter
        // at least one number
        // at least one special char
        
        let longEnough = password.count > 7
        let containsCapitalLetter = password.contains(/[A-Z]+/)
        let containsNumber = password.contains(/[1-9]+/)
        let containsSpecialChar = password.contains(/[@,#,$<%,&,*]+/)
        
        return containsCapitalLetter && longEnough && containsNumber && containsSpecialChar
    }
    
    func isEmailAddressFormattedCorrectly(_ emailAddress: String) -> Bool {
        // use Regex to test emailAddress
        
        let regex = /\w+@\w+\.[a-z]{3}/
        return (emailAddress.firstMatch(of: regex) != nil)
    }
    
    func isUsernameFormattedCorrectly(_ username: String) -> Bool {
        return username.count > 4
    }
    
    func sendRegistrationInfo(_ userName: String, _ password: String, _ email: String) async -> Bool {
        submitButtonAnimating = false
        return true
    }
}

#Preview {
    FormView()
}
