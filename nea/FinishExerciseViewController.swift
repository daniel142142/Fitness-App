import UIKit
import FirebaseFirestore
import CoreData

class FinishExerciseViewController: UIViewController {

    @IBOutlet weak var exerciseTF: UITextField!
    @IBOutlet weak var caloriesLabel: UILabel!
    let exercises = ["Running", "Cycling", "Rowing"]
    var exercisePickerView = UIPickerView()
    
    var metDict = ["Running": 9,
                   "Cycling": 7.5,
                   "Rowing": 11,
                   "nil":0] //Dictionary for met values
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        exerciseTF.inputView = exercisePickerView //sets text field to type picker view
        
        
        exercisePickerView.delegate = self
        exercisePickerView.dataSource = self //This sets the data for the text field
        
        
        exercisePickerView.tag = 1
        
    }

    @IBAction func saveButton(_ sender: Any) {
        let activeTime = UserDefaults.standard.double(forKey: "startedTime") // Gets active timer from user defaults
        let exercise = exerciseTF.text ?? "nil" //Gets exercise from exercise picker view
        let metValue = metDict[exercise] ?? 0 //Gets the met value from the dictionary
        let weight = UserDefaults.standard.double(forKey: "weight") //Gets weight from user defaults
        let calc1 = metValue * 3.5 * weight
        let caloriesMinute = calc1 / 200
        let caloriesSecond = caloriesMinute / 60 //Calculations to get calories burned per second
       
        let exerciseCalories = caloriesSecond * activeTime //Working out total calories
        caloriesLabel.text = "\(exerciseCalories)" //Prints total calories
        let calories = UserDefaults.standard.double(forKey: "Calories") //gets reference to user defaults value in key calories
       
        let newCalories = calories + exerciseCalories // adds workout calories to calories
        UserDefaults.standard.set(newCalories, forKey: "Calories")//saves new value for calories
        
        let name = UserDefaults.standard.string(forKey: "name")
        let time = UserDefaults.standard.string(forKey: "time")
        let distance = UserDefaults.standard.string(forKey: "finalDistance")
        let avgSpeed = UserDefaults.standard.string(forKey: "avgSpeed") //Getting all information from user defaults
        UserDefaults.standard.set(exerciseCalories, forKey: "exerciseCalories")
        UserDefaults.standard.set(exercise, forKey: "exercise")
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd-MM-yyyy-HH-mm-ss" //this will set the formatt of the date
        let currentDate = dateFormatter.string(from: Date())//this gets the current date
        
        let db = Firestore.firestore() //opens the firestore database by creating a variable with the firestore function
        db.collection("Exercise").addDocument(data: [ //This function sets data to the workouts collection and it will create a new document with a random ID
            "name": name, // sets the name field to name
            
            "exercise": exercise,
            "time": time, // gets value of timer and sets it to time field
            "calories": exerciseCalories, // gets value of calories and sets it to time field
            "distance": distance,
            "speed": avgSpeed,
            "date": currentDate
        ]) { (error:Error?) in
            if let error = error{
                print("\(error.localizedDescription)")//If there is an error it will print a description of the error
            }else {
                print("yes") //If there is no error it will print yes so i know it has been saved
            }
            }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate   //Gets a reference to the app delegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext //Gets a reference to the context in order to set the data to save
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context) //Gets a reference to the database entity
        
        let newNote = Exercise(entity: entity!, insertInto: context) //Creates a new item which will be inserted into the contect before being saved
        newNote.calories = Float(exerciseCalories)  //gives the database fields data
        do{
            try context.save() //Saves the contect
            noteList2.append(newNote)
            
        }
        catch{
            print("failed") //Handles any errors
        }
    }
    
}

extension FinishExerciseViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercises.count //This counts how many objects there are in the array
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercises[row]  //this returns the object of the array
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 1 :  //This sets up the different cases for each text field
            exerciseTF.text = exercises[row]
            exerciseTF.resignFirstResponder()
        
        default:
            return         }// This function sets the text in the text field
    }
}

