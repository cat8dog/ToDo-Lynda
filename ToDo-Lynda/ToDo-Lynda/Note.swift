
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
    
    
    
}
