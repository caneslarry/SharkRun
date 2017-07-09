

import Foundation





enum BgChoosing: Int {
    case bg1,bg2,bg3,bg4,bg5,bg6,bg7
    
}

enum DiffucultyChoosing: Int {
    case easy,medium,hard
    
}


class Model:NSObject {
    
    
    //public class Model {
        public static let sharedInstance: Model = { Model() }()
    //}
    
   /*
    class var sharedInstance:Model{
        struct Static{
            static var instance:Model?
            static let token = {0}()
        }
        
        _ = Static.token
        
        return Static.instance!
        
    }
    */
    var rateBool = false
    var ShieldAddBool = false
    var bgcount = 0
    
    var totalscore = 0
    var ADCount = 0 
    var score = 0
    var shieldBool = false
    var highcore = 0
    var sound = true
    
}
