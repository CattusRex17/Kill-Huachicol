//
//  Singleton.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 5/29/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//


import Foundation

class Singleton {
    
    static let shared = Singleton()
    var userToken: String?
    var userRole: String?
    var emailUser: String?

    public static func getInstance() -> Singleton {return shared}
}

