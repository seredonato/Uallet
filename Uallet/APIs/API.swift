//
//  API.swift
//  Uallet
//
//  Created by Serena Donato on 29/03/2022.
//

import Foundation


enum APIError: Error{
    case UserIncomplete, PasswordIncomplete, EmptyFields, ServerError
}


class API{

    static func logIn(_ user: String, _ password: String, callback: (Bool) -> Void) throws{
        
        guard user.count >= 4 else {
            throw APIError.UserIncomplete
        }
    
        guard password.count >= 4 else {
            throw APIError.PasswordIncomplete
        }
        
        if user == "admin" && password == "123456"{
            callback(true)
        }else{
            callback(false)
        }
    }
}
