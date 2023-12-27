//
//  ApiHandlerView.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/25/23.
//

import SwiftUI

enum ApiError: Error {
    case noInputError
    case badUrlError
    case decodingError
}

struct ApiHandlerView: View {
    @State private var showBadApiCallAlert = false
    @State private var input: String = ""
    @State private var output: String = ""
    @State private var apiViewModel = ApiHandlerViewModel.shared
    
    let apiRouter = ApiRouter.shared
    var body: some View {
        VStack {
            Text("Enter Name")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
            TextField("Name", text: $input) {
            }
            .textFieldStyle(CustomTextFieldStyle())
            .padding(.horizontal)
            .keyboardType(.asciiCapable)
            .autocorrectionDisabled()
            
            Spacer()
                .frame(height: 20)
            
            VStack {
                // Gender Button
                Button(action: {
                    Task {
                        do{
                            output = try await getGenderPrediction(input)
                              input = ""
                        } catch {
                            throw ApiError.noInputError
                        }
                    }
                }, label: {
                    Text("Get Gender Prediction")
                        .frame(maxWidth: .infinity)
                })

                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
                .disabled(input.count > 0 ? false : true)
                
                Spacer()
                    .frame(height: 10)
                
                // Nationality Button
                Button(action: {
                    Task {
                        do{
                            output = try await getNatioinalityPrediction(input)
                              input = ""
                        } catch {
                            
                        }
                    }
                    
                }, label: {
                    Text("Get Nationality Prediction")
                    .frame(maxWidth: .infinity)
                })
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
                .disabled(input.count > 0 ? false : true)
            }
            
            Spacer()
                .frame(height: 15)
            
            Text(output)
            Spacer()
        }
        .alert(isPresented: $showBadApiCallAlert) {
            Alert(title: Text("Bad Api Call"),
                  message: Text(""))
        }
    }
    
    func getGenderPrediction(_ input: String) async throws -> String {
        return input + " is likely a boy!"
    }
    
    func getNatioinalityPrediction(_ input: String) async throws -> String {
        guard input.count > 0 else {
            // thow error instead
            return ""
        }
        return input + " is likely from Germany"
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
       configuration
        .keyboardType(.asciiCapable)
        .autocorrectionDisabled()
           .padding()
           .overlay {
               RoundedRectangle(cornerRadius: 8, style: .continuous)
                   .stroke(Color(UIColor.systemGray4), lineWidth: 2)
           }
    }
}

#Preview {
    ApiHandlerView()
}
