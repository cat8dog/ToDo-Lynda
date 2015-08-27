
import UIKit

// create global variables to manage data

var allNotes: [Note] = []
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
        var aDictionaries:[NSDictionary] = []
        for var i:Int = 0; i < allNotes.count; i++ {
            // for loop to convert all items in the aDictionary array into dictionary items.
            aDictionaries.append(allNotes[i].dictionary())
        }
        // save the data to persistent storage
        NSUserDefaults.standardUserDefaults().setObject(aDictionaries, forKey: kAllNotes)
    }
    
    // New class method for loading the notes
    class func loadNotes() {
        // variable created simply to shorten the extended line of code
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        // grab data from UserDefaults:
        var savedData:[NSDictionary]? = defaults.objectForKey(kAllNotes) as? [NSDictionary]// "?" Incase value returns a null.
        //  Doesn't match the return type of objectForKey, so it will need to be type=cast as an array of dictionaries.
        // unwrap the data
        savedData?.count
        
        // if statement that checks to see if the saved data is null. If it's not, we'll assign it to a non-optional value.  
        
        if let data:[NSDictionary] = savedData {  // if saved data is not null, it will be saved to the constant named 'data'. If it IS null, then the code in the curly braces won't even trigger.
            for var i:Int = 0; i < data.count; i++ {
                var n:Note = Note()
                n.setValuesForKeysWithDictionary(data[i] as [NSObject : AnyObject])
                allNotes.append(n)
            }
        }
    }
    
    
    
    
}
