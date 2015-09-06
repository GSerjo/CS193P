//
//  User.swift
//  Autolayout
//
//  Created by Serjo on 06/09/15.
//  Copyright © 2015 Serjo. All rights reserved.
//

import Foundation

struct  User {
    
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        guard let user = database[login] where user.password == password else {
            return nil
        }
        return user
    }
    
    private static let database: [String: User] = {
        var theDatabase = [String: User]()
        for user in [
            User(name: "John Appleseed", company: "Apple", login: "japple", password: "foo"),
            User(name: "Madison Bumgarner", company: "World Chamion San Francisco Giants", login: "madbum", password: "foo"),
            User(name: "John Hennessy", company: "Stanford", login: "hennessy", password: "foo"),
            User(name: "Bad Guy", company: "Criminal, Inc.", login: "baddie", password: "foo")
            ]{
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}