//
//  PropertyWrapperView.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/21/23.
//

import SwiftUI

struct PropertyWrapperView: View {
    @State private var title: String = "Starting Title"
    
    var body: some View {
        VStack(spacing: 40) {
            Text(title).font(.largeTitle)
            
            Button("Click me 1") {
                setTitle(newValue: "title 1")
            }
            
            Button("Click me 2") {
                setTitle(newValue: "title 2")
            }
        }
        .onAppear {
            do {
                let savedValue = try String(contentsOf: path,
                                            encoding: .utf8)
                title = savedValue
                print("SUCCESFUL READ")
            } catch {
                print("ERROR READ: \(error)")
            }
        }
    }
    
    private func setTitle(newValue: String) {
        title = newValue.uppercased()
        save(newValue: title)
    }
    
    private var path: URL {
        FileManager.default
            .urls(for: .documentDirectory,
                  in: .userDomainMask)
            .first!
            .appending(path: "custom_title.txt")
    }
    
    private func save(newValue: String) {
        do {
            try newValue.write(to: path,
                               atomically: false,
                               encoding: .utf8)
        } catch {
            debugPrint("ERROR SAVING: \(error)")
        }
    }
}

#Preview {
    PropertyWrapperView()
}
