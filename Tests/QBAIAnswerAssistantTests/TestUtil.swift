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
        OwnerMessage("Hi. let me check..."),
        OpponentMessage("Can we have a call today evening?"),
        OpponentMessage("I've a question about your job"),
        OpponentMessage("How are you?"),
        OpponentMessage("Hello"),
    ]
    
    static var token: String = "sk-8e9a7bc0-12ab-34cd-56ef-7890gh123i45"
    
    static var answers: String = "Can you clarify please"
}
