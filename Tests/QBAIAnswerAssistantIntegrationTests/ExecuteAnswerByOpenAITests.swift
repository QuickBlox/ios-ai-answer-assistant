//
//  ExecuteByOpenAITokenTests.swift
//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import XCTest
@testable import QBAIAnswerAssistant

final class ExecuteAnswerByOpenAITests: XCTestCase {
    
    func testHasMessages_executeByOpenAIToken_returnAnswers() async {
        do {
            let settings = AISettings(apiKey: Config.openAIToken)
            
            let answers = try await
            QBAIAnswerAssistant.createAnswer(to: Test.messages, using: settings)
            print(answers)
            XCTAssertFalse(answers.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // To start this tests we need to have running Proxy server
    // The repository is: https://github.com/QuickBlox/qb-ai-assistant-proxy-server
    func testHasMessages_executeByProxy_returnAnswers() async {
        do {
            let settings = AISettings(token: Config.qbToken,
                                      serverPath: "http://localhost:3000")
            let answers = try await
            QBAIAnswerAssistant.createAnswer(to: Test.messages, using: settings)
            print(answers)
            XCTAssertFalse(answers.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
}
