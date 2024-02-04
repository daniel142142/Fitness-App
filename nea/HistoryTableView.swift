import UIKit
import CoreData

var noteList = [History]()

class HistoryTableView: UITableViewController {
    
    
    var firstLoad = true
    
 
    override func viewDidLoad() {
        
        let firstLoad = UserDefaults.standard.string(forKey: "firstLoad")
        
        if firstLoad == "yes"{
            UserDefaults.standard.set("no", forKey: "firstLoad")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
            do{
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! History
                    noteList.insert(note, at: 0)
                    
                    
                }
            }
            catch{
                print("fetch failed")
            }
            
                                                               
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! HistoryCell
        
        let thisNote: History!
        thisNote = noteList[indexPath.section]
        
        let step = String(thisNote.steps)
        noteCell.stepsLabel.text = step + " Steps"
        
        let calories = String(thisNote.calories)
        noteCell.calorieLabel.text = calories + " Calories"
        
        let date = thisNote.date
        noteCell.dateLabel.text = date
        
        
        return noteCell
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return noteList.count
    }
}

