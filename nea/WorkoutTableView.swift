import UIKit
import CoreData

var noteList1 = [Workouts]()

class WorkoutTableView: UITableViewController {
    override func viewDidLoad() {
            navigationItem.title = "Workouts"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
            do{
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Workouts
                    noteList1.insert(note, at: 0)
  
                }
            }
            catch{
                print("fetch failed")
            }
            
                                                               
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "workoutCellID", for: indexPath) as! WorkoutCell
        
        let thisNote1: Workouts!
        thisNote1 = noteList1[indexPath.section]
        
        let ex1Array = thisNote1.ex1
        noteCell.exerciseLabel.text = "\(ex1Array[0])"
        
        let ex2Array = thisNote1.ex2
        noteCell.ex2Label.text = "\(ex2Array[0])"
        
        let ex3Array = thisNote1.ex3
        noteCell.ex3Label.text = "\(ex3Array[0])"
        
        let ex4Array = thisNote1.ex4
        noteCell.ex4Label.text = "\(ex4Array[0])"
        
        let ex5Array = thisNote1.ex5
        noteCell.ex5Label.text = "\(ex5Array[0])"
        
        let ex6Array = thisNote1.ex6
        noteCell.ex6Label.text = "\(ex6Array[0])"
        
        
        
        
        return noteCell
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return noteList1.count
    }
}

