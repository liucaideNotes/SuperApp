//
//  User.swift
//  SuperApp
//
//  Created by 刘才德 on 2016/12/13.
//  Copyright © 2016年 Friends-Home. All rights reserved.
//

import Foundation
struct User: Equatable, CustomDebugStringConvertible {
    
    var firstName: String
    var lastName: String
    var imageURL: String
    
    init(firstName: String, lastName: String, imageURL: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageURL = imageURL
    }
}

extension User {
    var debugDescription: String {
        return firstName + " " + lastName
    }
}

func ==(lhs: User, rhs:User) -> Bool {
    return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.imageURL == rhs.imageURL
}

struct TableViewEditingCommandsViewModel {
    let favoriteUsers: [User]
    let users: [User]
    
    func executeCommand(_ command: TableViewEditingCommand) -> TableViewEditingCommandsViewModel {
        switch command {
        case let .setUsers(users):
            return TableViewEditingCommandsViewModel(favoriteUsers: favoriteUsers, users: users)
        case let .setFavoriteUsers(favoriteUsers):
            return TableViewEditingCommandsViewModel(favoriteUsers: favoriteUsers, users: users)
        case let .deleteUser(indexPath):
            var all = [self.favoriteUsers, self.users]
            all[indexPath.section].remove(at: indexPath.row)
            return TableViewEditingCommandsViewModel(favoriteUsers: all[0], users: all[1])
        case let .moveUser(from, to):
            var all = [self.favoriteUsers, self.users]
            let user = all[from.section][from.row]
            all[from.section].remove(at: from.row)
            all[to.section].insert(user, at: to.row)
            
            return TableViewEditingCommandsViewModel(favoriteUsers: all[0], users: all[1])
        }
    }
}

enum TableViewEditingCommand {
    case setUsers(users: [User])
    case setFavoriteUsers(favoriteUsers: [User])
    case deleteUser(indexPath: IndexPath)
    case moveUser(from: IndexPath, to: IndexPath)
}
