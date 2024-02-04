import UIKit
import CoreData

var noteList2 = [Exercise]()

class ExerciseTableView: UITableViewController {
    
    
    var firstLoad = true
    
 
    override func viewDidLoad() {
        
        let firstLoad = UserDefaults.standard.string(forKey: "firstLoad")
        
        if firstLoad == "yes"{
            UserDefaults.standard.set("no", forKey: "firstLoad")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
            do{
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Exercise
                    noteList2.insert(note, at: 0)
                    
                    
                }
            }
            catch{
                print("fetch failed")
            }
            
                                                               
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "exerciseCellID", for: indexPath) as! ExerciseCell
        
        let thisNote2: Exercise!
        thisNote2 = noteList2[indexPath.section]
        
        let calories = Float(thisNote2.calories ?? 0)
        noteCell.caloriesLabel.text = "\(calories)"
        
        
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

