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
}
