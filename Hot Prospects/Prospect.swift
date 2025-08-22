//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Zi on 22/08/2025.
//

import SwiftUI

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isConnected = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init(){
        people = []
    }
}
