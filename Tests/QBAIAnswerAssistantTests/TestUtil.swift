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
    static var messages: [Message] = [
        OwnerMessage(content: "Hi. let me check..."),
        OpponentMessage(content: "Can we have a call today evening?"),
        OpponentMessage(content: "I've a question about your job"),
        OpponentMessage(content: "How are you?"),
        OpponentMessage(content: "Hello"),
    ]
    
    static var token: String = "sk-8e9a7bc0-12ab-34cd-56ef-7890gh123i45"
    
    static var answers: String = "Can you clarify please"
}
