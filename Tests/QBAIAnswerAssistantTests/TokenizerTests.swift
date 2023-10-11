//
//  TokenizerTests.swift
//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import XCTest
@testable import QBAIAnswerAssistant

final class TokenizerTests: XCTestCase {
    
    func testContentWith3Tokens_parseTokensCountFrom_return3() {
        let tokensCount = Tokenizer().parseTokensCount(from: "Hello my friend!")
        XCTAssertEqual(tokensCount, 3)
    }
    
    func testEmptyContent_parseTokensCountFrom_return0() {
        let tokensCount = Tokenizer().parseTokensCount(from: "")
        XCTAssertEqual(tokensCount, 0)
    }
    
    func testHas5messages_extractMessagesByTokenLimit_received5Messages() {
        let extractedMessages = Tokenizer().extract(messages: Test.messages, byTokenLimit: 3000)
        XCTAssertEqual(extractedMessages.count, 5)
    }
    
    func testHas5Messages_extractMessagesByTokenLimitWithTokensMaxCount5_received2Messages() {
        let extractedMessages = Tokenizer().extract(messages: Test.messages,
                                                    byTokenLimit: 30)
        XCTAssertEqual(extractedMessages.count, 1)
    }
}
