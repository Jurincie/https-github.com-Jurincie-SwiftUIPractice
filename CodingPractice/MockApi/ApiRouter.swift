//
//  ApiRouter.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/26/23.
//

import Foundation

enum ApiStrings: String {
    case catFact = "https://catfact.ninja/fact"
    case genderByName = "https://api.agify.io?name="
    case nationalityByName = "https://api.nationalize.io?name="
}

class ApiRouter {
    static let shared = ApiRouter()
    var url: URL? = URL(string: ApiStrings.catFact.rawValue)
    
    private init() {}
}
