//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//
// `QBAIAnswerAssistant` helps generate an answer in a chat based on the history of correspondence. Generation is carried out using the OpenAI model. There are two ways to generate responses: one is direct OpenAI API requests using a key, and the second is proxy requests using a QuickBlox user token. The second method organizes a more secure communication channel by saving the keys from OpenAI on the server and checking through the QuickBlox instance that the request is made by the user and not by an attacker.

import Foundation

/// Represents the settings used for QBAIAnswerAssistant.
public struct Settings {
    /// The minimum number of messages required to generate a response.
    public var minMessageCount: Int = 1
    
    /// The maximum token count allowed for message processing.
    public var maxTokenCount: Int = 3500
    
    /// Settings for OpenAI model usage.
    public var openAI: OpenAISettings = OpenAISettings()
}

/// Represents the settings used for QBAIAnswerAssistant.
public var settings = QBAIAnswerAssistant.Settings()

/// Represents the various exceptions that can be thrown by `QBAIAnswerAssistant`.
public enum QBAIAnswerAssistantException: Error {
    /// Thrown when the provided token has an incorrect value.
    case incorrectToken
    
    /// Thrown when the minimum messages count should be more than the specified minimum.
    case incorrectMessageCount
    
    /// Thrown when the server URL has an incorrect value.
    case incorrectProxyServerUrl
}

/// Extension to provide localized error descriptions for `QBAIAnswerAssistantException`.
extension QBAIAnswerAssistantException: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .incorrectToken: return "The token has incorrect value"
        case .incorrectMessageCount: return "The minimal messages count should be more then \(settings.minMessageCount)"
        case .incorrectProxyServerUrl: return "The serverUrl has incorrect value"
        }
    }
}

/// Extension to provide a utility method to check if a string is not correct by removing whitespaces and newlines from both ends and checking if the resulting string is empty.
extension String {
    var isNotCorrect: Bool {
        // Remove whitespaces and newlines from both ends of the string
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check if the resulting string is empty
        return trimmedString.isEmpty
    }
}

public var dependency: DependencyProtocol = Dependency()
    
    /**
     Generates an answer using the OpenAI API by making direct requests with the provided API key.
     
     - Parameters:
        - messages: An array of `Message` objects representing the chat history.
        - apiKey: The API key to be used for making the request to OpenAI.
     
     - Returns: The generated answer as a String.
     
     - Throws: A `QBAIAnswerAssistantException` if an error occurs during the request or validation.
     */
public func openAIAnswer(to messages: [Message],
                                    secret apiKey: String) async throws -> String {
        if apiKey.isNotCorrect {
            throw QBAIAnswerAssistantException.incorrectToken
        }
        
        let filtered = filter(messages: messages)
    if filtered.count < settings.minMessageCount {
            throw QBAIAnswerAssistantException.incorrectMessageCount
        }
        
        let answer =
        try await dependency.restSource.requestOpenAIAnswer(to: messages,
                                                            key: apiKey,
                                                            apply: settings.openAI)
        
        return answer
    }
    
    
    /// Generates an answer using the OpenAI API by making requests through a QuickBlox user token and proxy URL.
    ///
    /// Using a proxy server like the [QuickBlox AI Assistant Proxy Server](https:github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:
    ///
    /// Enhanced Security:
    /// - When making direct requests to the OpenAI API from the client-side, sensitive information like API keys may be exposed. By using a proxy server, the API keys are securely stored on the server-side, reducing the risk of unauthorized access or potential breaches.
    /// - The proxy server can implement access control mechanisms, ensuring that only authenticated and authorized users with valid QuickBlox user tokens can access the OpenAI API. This adds an extra layer of security to the communication.
    ///
    /// Protection of API Keys:
    ///  - Exposing API keys on the client-side could lead to misuse, abuse, or accidental exposure. A proxy server hides these keys from the client, mitigating the risk of API key exposure.
    ///  - Even if an attacker gains access to the client-side code, they cannot directly obtain the API keys, as they are kept confidential on the server.
    ///
    ///  Rate Limiting and Throttling:
    ///  - The proxy server can enforce rate limiting and throttling to control the number of requests made to the OpenAI API. This helps in complying with API usage policies and prevents excessive usage that might lead to temporary or permanent suspension of API access.
    ///
    ///  Request Logging and Monitoring:
    ///  - By using a proxy server, requests to the OpenAI API can be logged and monitored for auditing and debugging purposes. This provides insights into API usage patterns and helps detect any suspicious activities.
    ///
    ///  Flexibility and Customization:
    ///  - The proxy server acts as an intermediary, allowing developers to introduce custom functionalities, such as response caching, request modification, or adding custom headers. These customizations can be implemented without affecting the client-side code.
    ///
    ///  SSL/TLS Encryption:
    ///  - The proxy server can enforce SSL/TLS encryption for data transmission between the client and the server. This ensures that data remains encrypted and secure during communication.
    ///
    /// - Parameters:
    ///   - messages: An array of `Message` objects representing the chat history.
    ///   - qbToken: The QuickBlox user token used for proxy communication.
    ///   - urlPath: The proxy URL to be used for making the request to OpenAI.
    ///
    /// - Throws: A `QBAIAnswerAssistantException` if an error occurs during the request or validation.
    ///
    /// - Returns: The generated answer as a String.
    ///
public func openAIAnswer(to messages: [Message],
                                    qbToken: String,
                                    proxy urlPath: String) async throws -> String {
        if qbToken.isNotCorrect {
            throw QBAIAnswerAssistantException.incorrectToken
        }
        
        if ServerUrlValidator.isNotCorrect(urlPath) {
            throw QBAIAnswerAssistantException.incorrectProxyServerUrl
        }
        
        let filtered = filter(messages: messages)
        if filtered.count < settings.minMessageCount {
            throw QBAIAnswerAssistantException.incorrectMessageCount
        }
        
        let answer =
        try await dependency.restSource.requestOpenAIAnswer(to: messages,
                                                            token: qbToken,
                                                            proxy: urlPath,
                                                            apply: settings.openAI)
        return answer
    }
    
private func filter(messages: [Message]) -> [Message] {
        return dependency.tokenizer.extract(messages: messages,
                                            byTokenLimit: settings.maxTokenCount)
    }
