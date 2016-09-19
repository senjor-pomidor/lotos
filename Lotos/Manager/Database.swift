//
//  Database.swift
//  Lotos
//
//  Created by Andrey Torlopov on 9/19/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit

class Database: NSObject {
    class func getTrainers() -> [Trainer] {
        var result = [Trainer]()
        result.append(Trainer(id: 1, name: "AAA", photoURL: "url 1"))
        result.append(Trainer(id: 2, name: "CCC", photoURL: "url 2"))
        result.append(Trainer(id: 3, name: "DDD", photoURL: "url 3"))
        return result
    }
    
    class func getSchedule() -> [TngItem] {
        var result = [TngItem]()
        result.append(TngItem(date: "date1", disciplite: "D1", hall: 1, time: "time1", townId: 1, townName: "Ukhta", trainerId: 1, weekDay: 1))
        result.append(TngItem(date: "date2", disciplite: "D2", hall: 2, time: "time2", townId: 2, townName: "Moscow", trainerId: 3, weekDay: 2))
        result.append(TngItem(date: "date3", disciplite: "D3", hall: 3, time: "time3", townId: 3, townName: "S.Peterburg", trainerId: 3, weekDay: 3))
        return result
    }
}
