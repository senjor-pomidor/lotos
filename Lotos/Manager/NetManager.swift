import UIKit
import Alamofire


// get data from internet

typealias NetManagerComplition = (success: NSArray?, failure:NSError?)->Void

class NetManager: NSObject {
    
    class func getJSONData(dataSourceURL: String,  complition: NetManagerComplition) {
        Alamofire.request(.GET,
            dataSourceURL,
            parameters: nil,
            encoding: .URL,
            headers: nil).responseJSON { response -> Void in
                if response.result.error != nil
                {
                    complition(success: nil, failure: response.result.error!)
                    return
                }
                let data = response.result.value as! NSArray
                complition(success: data , failure: nil)
                return
        }
    }
    
    
}
