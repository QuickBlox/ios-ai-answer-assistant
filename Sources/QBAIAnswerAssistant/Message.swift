//
//  Message.swift
//  QBAIAnswerAssistant
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation

/// Represents the role of a message (owner or opponent).
public enum Role {
    case owner
    case opponent
}

/// Represents a message in the chat with its role (owner or opponent) and content.
public protocol Message {
    var role: Role { get }
    var content: String { get }
}

/// Represents a message from the owner in the chat.
public struct OwnerMessage: Message {
    private (set) public var role: Role = .owner
    
    public let content: String
    
}

/// Represents a message from the opponent in the chat.
public struct OpponentMessage: Message {
    private (set) public var role: Role = .opponent
    
    public let content: String
}
