
import UIKit

// create global variables to manage data

var allNotes: NSMutableArray = []
// current index will save which note we're editing
var currentNoteIndex: Int = -1
// third variable will reference the table of notes
// no access to this till application launches and view loads.  For this reason, the tableView will need to be declared as an optional.
var noteTable:UITableView?

// create constant to make a string literal to use for storing the data persistently. 
let kAllNotes:String = "notes" // key

class Note: NSObject {
    
    
    var date:String
    var note:String
    
    // for variables that you can't declare right off the bat, you need to declare that they're optional.
    
    override init() {
        date = NSDate().description // description property is used to turn this into a string. 
        note = "" // initialized into an empty string
    }
    
    func dictionary() -> NSDictionary {
        return ["note":note,"date": date] // *the string key values match perfectly the property values.
    }
    
    // this function will convert all the notes into dictionaries and save that array of dictionaries to persistent storage.
    class func saveNotes() {
        
        // an array of type NSDictionary, instantiated to an empty array
        var aDictionaries:NSMutableArray = []
        for var i:Int = 0; i < allNotes.count; i++ {
            
        // for loop to convert all items in the aDictionary array into dictionary items.
            aDictionaries.addObject(allNotes[i].dictionary())
        }
        
        
        // for saving notes to file: 
        // Use the built-in method for NSMutableArray:
        aDictionaries.writeToFile(filePath(), atomically: true)
    }
    
    // New class method for loading the notes
    class func loadNotes() {
      
        //var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        // grab data from UserDefaults:
       // var savedData:[NSDictionary]? = defaults.objectForKey(kAllNotes) as? [NSDictionary]// "?" Incase value returns a null.
        var savedData:NSArray? = NSArray(contentsOfFile: filePath())
        if let data:NSArray = savedData {
            for var i:Int = 0; i < data.count; i++ {
                var n:Note = Note()
                n.setValuesForKeysWithDictionary(data[i] as! NSDictionary as [NSObject : AnyObject])
                allNotes.addObject(n)
            }
        }
    }
    
    // method for saving data to a file
    class func filePath() -> String {
        // start by creating a directory
        var d:[String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        if let directories:[String] = d {
            var docsDirectory:String = directories[0]
            var path:String = docsDirectory.stringByAppendingPathComponent("\(kAllNotes).notes")
            return path;
        }
        return ""
    }
    
    
    
    
}
