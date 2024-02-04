import UIKit
import CoreData
import FirebaseFirestore


class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var TimerLabel: UILabel! //Label for the timer
    
    @IBOutlet weak var calorieLabel: UILabel! //label for calories
    @IBOutlet weak var ex1Label: UILabel!
    @IBOutlet weak var ex2Label: UILabel!
    @IBOutlet weak var ex3Label: UILabel!
    @IBOutlet weak var ex4Label: UILabel!
    @IBOutlet weak var ex5Label: UILabel!
    @IBOutlet weak var ex6Label: UILabel! // these outlets connect the labels to the code so that i can change the text in the labels depending on what workout the user selects
    
    @IBOutlet weak var sets1: UITextField!
    @IBOutlet weak var reps1: UITextField!
    @IBOutlet weak var weight1: UITextField!
    
    
    @IBOutlet weak var sets2: UITextField!
    @IBOutlet weak var reps2: UITextField!
    @IBOutlet weak var weight2: UITextField!
    
    
    @IBOutlet weak var sets3: UITextField!
    @IBOutlet weak var reps3: UITextField!
    @IBOutlet weak var weight3: UITextField!
    
    @IBOutlet weak var sets4: UITextField!
    @IBOutlet weak var reps4: UITextField!
    @IBOutlet weak var weight4: UITextField!
    
    @IBOutlet weak var sets5: UITextField!
    @IBOutlet weak var reps5: UITextField!
    @IBOutlet weak var weight5: UITextField!
    
    @IBOutlet weak var sets6: UITextField!
    @IBOutlet weak var reps6: UITextField!
    @IBOutlet weak var weight6: UITextField!  //Thes are all of the text input box outlets which will later be assigned to a variable
    var ex1: String?
    var ex2: String?
    var ex3: String?
    var ex4: String?
    var ex5: String?
    var ex6: String? // This sets up the variables
    
    
    
    //creating variables needed for timer
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sets1.keyboardType = .numberPad
        reps1.keyboardType = .numberPad
        weight1.keyboardType = .numberPad
        
        sets2.keyboardType = .numberPad
        reps2.keyboardType = .numberPad
        weight2.keyboardType = .numberPad
        
        sets3.keyboardType = .numberPad
        reps3.keyboardType = .numberPad
        weight3.keyboardType = .numberPad
        
        sets4.keyboardType = .numberPad
        reps4.keyboardType = .numberPad
        weight4.keyboardType = .numberPad
        
        sets5.keyboardType = .numberPad
        reps5.keyboardType = .numberPad
        weight5.keyboardType = .numberPad
        
        sets6.keyboardType = .numberPad
        reps6.keyboardType = .numberPad
        weight6.keyboardType = .numberPad
        
        ex1Label.text = ex1
        ex2Label.text = ex2
        ex3Label.text = ex3
        ex4Label.text = ex4
        ex5Label.text = ex5
        ex6Label.text = ex6 // This changes text in label to exercise variables
        
        
        //Starting the timer
        if timerCounting == true{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
            
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) { // this will run when the save button on workout page is pressed
        let name = UserDefaults.standard.string(forKey: "name")//Gets the users name from user defaults and creates variable
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd-MM-yyyy-HH-mm-ss" //this will set the formatt of the date
        let currentDate = dateFormatter.string(from: Date())//this gets the current date
        
        
        let db = Firestore.firestore() //opens the firestore database by creating a variable with the firestore function
        db.collection("Workouts").addDocument(data: [ //This function sets data to the workouts collection and it will create a new document with a random ID
            "name": name, // sets the name field to name
            "date": currentDate, // sets date fields to current date
            
            "ex1": ex1, //sets the exercise title to the ex1 variable
            "sets1": sets1.text,
            "reps1": reps1.text,
            "weight1": weight1.text, //sets weight1 field to the text in weight1 input box
            
            "ex2": ex2,
            "sets2": sets2.text,
            "reps2": reps2.text,
            "weight2": weight2.text,
            
            "ex3": ex3,
            "sets3": sets3.text,
            "reps3": reps3.text,
            "weight3": weight3.text,
            
            "ex4": ex4,
            "sets4": sets4.text,
            "reps4": reps4.text,
            "weight4": weight4.text,
            
            "ex5": ex5,
            "sets5": sets5.text,
            "reps5": reps5.text,
            "weight5": weight5.text,
            
            "ex6": ex6,
            "sets6": sets6.text,
            "reps6": reps6.text,
            "weight6": weight6.text,
            
            "time": TimerLabel.text, // gets value of timer and sets it to time field
            "calories": calorieLabel.text, // gets value of calories and sets it to time field
    
        ]) { (error:Error?) in
            if let error = error{
                print("\(error.localizedDescription)")//If there is an error it will print a description of the error
            }else {
                print("yes") //If there is no error it will print yes so i know it has been saved
            }
            }
        
        
        let calories = UserDefaults.standard.float(forKey: "Calories") //gets reference to user defaults value in key calories
        let workoutCalories = UserDefaults.standard.float(forKey: "workoutCalories") //Gets workout calories at end of workout
        let newCalories = calories + workoutCalories // adds workout calories to calories
        UserDefaults.standard.set(newCalories, forKey: "Calories")//saves new value for calories
        
        let sets1 = (sets1.text ?? "0") //Gets sets value from text field
        let reps1 = (reps1.text ?? "0")//Gets reps value from text field
        let weight1 = (weight1.text ?? "0")//Gets weight value from text field
       
        
        let sets2 = (sets2.text ?? "0")
        let reps2 = (reps2.text ?? "0")
        let weight2 = (weight2.text ?? "0")
     
        
        let sets3 = (sets3.text ?? "0")
        let reps3 = (reps3.text ?? "0")
        let weight3 = (weight3.text ?? "0")
        
        
        let sets4 = (sets4.text ?? "0")
        let reps4 = (reps4.text ?? "0")
        let weight4 = (weight4.text ?? "0")
        
        
        let sets5 = (sets5.text ?? "0")
        let reps5 = (reps5.text ?? "0")
        let weight5 = (weight5.text ?? "0")
        
        let sets6 = (sets6.text ?? "0")
        let reps6 = (reps6.text ?? "0")
        let weight6 = (weight6.text ?? "0")
        
        
        let ex1Array: NSArray = [ex1, sets1, reps1, weight1]
        let ex2Array: NSArray = [ex2, sets2, reps2, weight2]
        let ex3Array: NSArray = [ex3, sets3, reps3, weight3]
        let ex4Array: NSArray = [ex4, sets4, reps4, weight4]
        let ex5Array: NSArray = [ex5, sets5, reps5, weight5]
        let ex6Array: NSArray = [ex6, sets6, reps6, weight6]
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate   //Gets a reference to the app delegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext //Gets a reference to the context in order to set the data to save
        let entity = NSEntityDescription.entity(forEntityName: "Workouts", in: context) //Gets a reference to the database entity
        
        let newNote = Workouts(entity: entity!, insertInto: context) //Creates a new item which will be inserted into the contect before being saved
        newNote.ex1 = ex1Array //gives the database fields data
        newNote.ex2 = ex2Array
        newNote.ex3 = ex3Array
        newNote.ex4 = ex4Array
        newNote.ex5 = ex5Array
        newNote.ex6 = ex6Array
        do{
            try context.save() //Saves the contect
            noteList1.append(newNote)
            
        }
        catch{
            print("failed") //Handles any errors
        }
        
        navigationController?.popViewController(animated: true) //This will go back to the previous screen after the data is saved to the firestore database
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func timerCounter() -> Void
        {
            count = count + 1
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            TimerLabel.text = timeString
            let userWeight = UserDefaults.standard.float(forKey: "weight") //Gets the users wight out of user defaults
            let workoutCalories = userWeight * 0.0014 * Float(count) // calories equation
        
            self.calorieLabel.text = "\(Int(workoutCalories)) Calories"//sets label to current calories used in workout
            UserDefaults.standard.set(workoutCalories, forKey: "workoutCalories")//saves value for workout calories
        }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    
}
