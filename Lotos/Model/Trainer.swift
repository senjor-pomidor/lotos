//
//  Trainer.swift
//  Lotos
//
//  Created by Andrey Torlopov on 20/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import Foundation


class Trainer {
    let id: Int32
    let name: String
    let photoURL: String
    init(id: Int32, name: String, photoURL: String) {
        self.id = id
        self.name = name
        self.photoURL = photoURL
    }
}

