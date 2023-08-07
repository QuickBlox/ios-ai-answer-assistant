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
            let answers = try await
            QBAIAnswerAssistant.openAIAnswer(to: Test.messages,
                                             secret: Config.openAIToken)
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
            let answers = try await
            QBAIAnswerAssistant.openAIAnswer(to: Test.messages,
                                             qbToken: Config.qbToken,
                                             proxy: "http://localhost:3000")
            print(answers)
            XCTAssertFalse(answers.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
}
