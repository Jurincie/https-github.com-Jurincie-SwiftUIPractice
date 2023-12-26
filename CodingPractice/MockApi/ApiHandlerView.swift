//
//  ApiHandlerView.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/25/23.
//

import SwiftUI

struct ApiHandlerView: View {
    @State private var showBadApiCallAlert = false
    @State private var genderString: String = ""
    @State private var apiViewModel = ApiHandlerViewModel.shared
    
    let apiRouter = ApiRouter.shared
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 15)
            Text("Enter Name")
                .font(.largeTitle)
            TextField("Name", text: $genderString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled()
                
            Spacer()
        }
        .alert(isPresented: $showBadApiCallAlert) {
            Alert(title: Text("Bad Api Call"),
                  message: Text(""))
        }
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
