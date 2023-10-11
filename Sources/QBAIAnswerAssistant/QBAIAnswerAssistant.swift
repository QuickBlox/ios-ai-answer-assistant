//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//
// `QBAIAnswerAssistant` helps generate an answer in a chat based on the history of correspondence. Generation is carried out using the OpenAI model. There are two ways to generate responses: one is direct OpenAI API requests using a key, and the second is proxy requests using a QuickBlox user token. The second method organizes a more secure communication channel by saving the keys from OpenAI on the server and checking through the QuickBlox instance that the request is made by the user and not by an attacker.

import Foundation

/// The dependency protocol that allows for dependency injection in the module.
public var dependency: DependencyProtocol = Dependency()

/// Generates an answer.
///
/// Using `Settings.serverPath` a proxy server  like the [QuickBlox AI Assistant Proxy Server](https:github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:
///
/// - Parameters:
///  - history: An array of `Message` objects representing the chat history.
///  - settings: The settings conforming to the `Settings` protocol, including tone, API key, user token, and server path.
///
/// - Returns: The generated answer as a String.
///
public func createAnswer<M, S>(to history: [M],
                           using settings: S) async throws -> String
where M: Message, S: Settings {
    guard let lastMessage = history.last else {
        throw QBAIException.wrongContent
    }
    
    let textTokens = dependency.tokenizer.parseTokensCount(from: lastMessage.text)
    if textTokens > settings.maxRequestTokens {
        throw QBAIException.incorrectTokensCount
    }
    
    let tokens = settings.maxRequestTokens - textTokens
    let filteredMessages = dependency.tokenizer.extract(messages: history,
                                                        byTokenLimit: tokens)
    
    
    return try await dependency.restSource.requestAnswer(to: lastMessage.text,
                                                         history: filteredMessages,
                                                         using: settings)
}
