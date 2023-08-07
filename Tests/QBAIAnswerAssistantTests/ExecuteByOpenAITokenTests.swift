//
//  ExecuteByOpenAITokenTests.swift
//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import XCTest
@testable import QBAIAnswerAssistant

final class ExecuteByOpenAITokenTests: XCTestCase {
    func testTokenNotEmptyAndMessagesNotEmpty_executeByOpenAIToken_noErrors() async throws {
        let tokenizer = TockenizerMock()
        let restSource = RestSourceMock()
        
        let dependency = Dependency(tokenizer: tokenizer, restSource: restSource)
        
        QBAIAnswerAssistant.dependency = dependency
        _ = try await QBAIAnswerAssistant.openAIAnswer(to: Test.messages,
                                                       secret: Test.token)
        
        XCTAssertEqual(restSource.requestOpenAIAnswerCallsCount, 1)
        XCTAssertEqual(tokenizer.extractMessagesCallsCount, 1)
    }
    
    func testEmptyToken_executeByOpenAIToken_throwException() async {
        do {
            _ = try await QBAIAnswerAssistant.openAIAnswer(to: Test.messages,
                                                                     secret: "")
            XCTFail("Expected an error to be thrown")
        } catch {
            if let exception = error as? QBAIAnswerAssistantException {
                XCTAssertEqual(exception, QBAIAnswerAssistantException.incorrectToken)
            } else {
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
    
    func testEmptyMessages_executeByOpenAIToken_throwException() async {
        do {
            _ = try await QBAIAnswerAssistant.openAIAnswer(to: [],
                                                           secret: Test.token)
            XCTFail("Expected an error to be thrown")
        } catch {
            if let exception = error as? QBAIAnswerAssistantException {
                XCTAssertEqual(exception, QBAIAnswerAssistantException.incorrectMessageCount)
            } else {
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
    
}

class RestSourceMock: RestSource {
    var requestOpenAIAnswerCallsCount = 0
    
    override func requestOpenAIAnswer(to messages: [Message],
                                      key: String,
                                      apply settings: OpenAISettings)
    async throws -> String {
        requestOpenAIAnswerCallsCount += 1
        return Test.answers
    }
}

class TockenizerMock: Tokenizer {
    var extractMessagesCallsCount = 0
    
    override func extract(messages: [Message],
                          byTokenLimit maxCount: Int = 3500) -> [Message] {
        extractMessagesCallsCount += 1
        return Test.messages
    }
}
