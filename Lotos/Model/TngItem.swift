
import Foundation

class TngItem {
    let date: String
    let disciplite: String
    let hall: Int32
    let time: String
    let townId: Int32
    let townName: String
    let trainerId: Int32
    let weekDay: Int32
    
    
    init(date: String,
         disciplite: String,
         hall: Int32,
         time: String,
         townId: Int32,
         townName: String,
         trainerId: Int32,
         weekDay: Int32) {
        self.date = date
        self.disciplite = disciplite
        self.hall = hall
        self.time = time
        self.townId = townId
        self.townName = townName
        self.trainerId = trainerId
        self.weekDay = weekDay
    }
        
}
