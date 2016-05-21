import UIKit

class Constants: NSObject {
    static let userFolder = "Images"
    static let serverURL = "http://198.211.123.168"
    static let townURL =  Constants.serverURL + "/api/v1/towns"
    static let trainersURL = Constants.serverURL + "/api/v1/trainers"
    static let schedulesURL = Constants.serverURL + "/api/v1/schedules"
    
//    static let DataIsLoaded = "DATA_IS_LOADED"
    static let flagTrainersIsLoaded = "TRAINER_IS_LOADED"
    
    //DB Entity names
    static let entityTrainer = "Trainer"
}
