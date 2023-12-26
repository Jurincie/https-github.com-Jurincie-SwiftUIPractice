//
//  ApiHandlerViewModel.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/26/23.
//

import Foundation

class ApiHandlerViewModel {
    static let shared = ApiHandlerViewModel()
    private var input: String = ""
}

public actor Debouncer {
    private let duration: Duration
    private var isPending = false
    
    public init(duration: Duration) {
        self.duration = duration
    }
    
    public func sleep() async -> Bool {
        if isPending { return false }
        isPending = true
        try? await Task.sleep(for: duration)
        isPending = false
        return true
    }
}
