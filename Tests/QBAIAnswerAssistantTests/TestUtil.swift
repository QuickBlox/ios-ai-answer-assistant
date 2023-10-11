//
//  TestUtil.swift
//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation
@testable import QBAIAnswerAssistant

struct Test {
    static var messages: [AIMessage] = [
        AIMessage(role: .me, text: "Hello! How can I assist you today?"),
        AIMessage(role: .other, text: "Hi, I'm looking for a new laptop. Can you recommend one?"),
        AIMessage(role: .me, text: "Of course! What are your requirements and budget for the laptop?"),
        AIMessage(role: .other, text: "I need a laptop for gaming and programming. My budget is around $1500."),
        AIMessage(role: .me, text: "Great! I recommend the XYZ laptop. It has a powerful GPU for gaming and a fast CPU for programming. It's priced at $1499. Would you like more details?")
    ]
    
    static var token: String = "sk-8e9a7bc0-12ab-34cd-56ef-7890gh123i45"
    
    static var answers: String = "Can you clarify please"
}
