import UIKit
import CoreData
import CoreMotion //this imports a library to track motion of phone
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    @IBOutlet weak var exerciseLabel: UILabel!
    
    @IBOutlet weak var exCaloriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!  //this is the function to get steps and activity
    
    let pedometer = CMPedometer()
    let activityManager = CMMotionActivityManager ()
    
   
    var bmr: Float?
    var firstLoad = true
   
    let timerCounting = true
    var timer:Timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("yes", forKey: "firstLoad")
        
        let recentGo = UserDefaults.standard.integer(forKey: "recentGo")
        if recentGo != 1{
            UserDefaults.standard.set("", forKey: "finalDistance")
            UserDefaults.standard.set("", forKey: "exerciseCalories")
            UserDefaults.standard.set("", forKey: "exercise")
            UserDefaults.standard.set(1, forKey: "recentGo")
        }
        let distance = UserDefaults.standard.string(forKey: "finalDistance")
        let exerciseCalories = UserDefaults.standard.string(forKey: "exerciseCalories")
        let exercise = UserDefaults.standard.string(forKey: "exercise")
        
        self.exerciseLabel.text = exercise
        self.exCaloriesLabel.text = exerciseCalories
        self.distanceLabel.text = distance
 
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())//this gets the current date
        
        let date = UserDefaults.standard.string(forKey: "date") //gets date that has perviously been saved to user defaults
        
        
        let calories = UserDefaults.standard.float(forKey: "Calories")
        let bmr = UserDefaults.standard.float(forKey: "bmr")
        calorieLabel.text = "\(calories + bmr)"
        
        if currentDate != date{
            
            // Retrieve the managed object context.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            // Create a new instance of the History managed object.
            let entity = NSEntityDescription.entity(forEntityName: "History", in: context)
            let newNote = History(entity: entity!, insertInto: context)

            // Set the properties of the newNote object.
            let steps = UserDefaults.standard.integer(forKey: "steps")
            newNote.steps = Int32(steps)

            let databaseCalories = calories + bmr
            newNote.calories = Int32(databaseCalories)

            newNote.date = date

            // Save the changes to the context and append the newNote object to noteList.
            do {
                try context.save()
                noteList.append(newNote)
            } catch {
                print("Failed to save changes to the context.")
            }
        
            
            UserDefaults.standard.set(currentDate, forKey: "date")
            UserDefaults.standard.set(0, forKey: "steps")
            let calories = 0
            UserDefaults.standard.set(calories, forKey: "Calories")    //This resets calories to bmr and steps to 0 when its a new day
            
        }
        
        
        
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "name")
        navigationItem.title = "Welcome " + (name ?? "") //this sets the title of the view
       
        let target = 10000
            let steps = UserDefaults.standard.integer(forKey: "steps")
            stepsLabel.text = "\(steps) / \(target)" //this sets steps to the value of steps when the pp was closed
       
        
        
        let fSteps = Float(steps)
        let percent = fSteps / Float(target)
        let progress = percent
        self.progressView.progress = progress //This sets it to previous step count when app opens
        
        
        
        
        
        
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates (to: OperationQueue.main) { (data) in
                DispatchQueue.main.async{
                    if let activity = data {
                        if activity.running == true {
                            print ("Running")
                            self.activityLabel.text =  "Running"
                            var go = 1
                            UserDefaults.standard.set(go, forKey: "go")
                        }else if activity.walking == true {
                            print ("Walking")
                            self.activityLabel.text =  "Walking"
                            var go = 1
                            UserDefaults.standard.set(go, forKey: "go")
                        }else if activity.automotive == true {
                            print ("Automative")
                            self.activityLabel.text =  "AUTOMOTIVE"
                            var go = 0
                            UserDefaults.standard.set(go, forKey: "go")
                            
                        }else{
                            self.activityLabel.text = "Not Moving"
                            var go = 1
                            UserDefaults.standard.set(go, forKey: "go")//This sets the label on home screen to the activity sent by the funtion
                        }
                        
                    }
                }
            }
            
        }
        
        if CMPedometer.isStepCountingAvailable(){
            self.pedometer.startUpdates (from: Date()) { (data, error) in
                if error == nil{
                    if let response = data {
                        DispatchQueue.main.async {
                            
                            let go = defaults.integer(forKey: "go") //sets the variable go from user defaults
                            if go == 1{  // This will make it run if go is 1
                                let newSteps = Int(truncating: response.numberOfSteps) //this gets the number of steps
                                let totalSteps = steps + newSteps  //adds new steps to previous value of steps
                                let target = 10000 //sets target
                                self.stepsLabel.text =  "\(totalSteps) / \(target) Steps"//prints number of steps
                                UserDefaults.standard.set(totalSteps, forKey: "steps") //saves steps to user defaults
                                
                                
                                
                                
                                let fTotalSteps = Float(totalSteps)
                                let percent = fTotalSteps / Float(target)
                                let progress = percent
                                self.progressView.progress = progress
                                
                                let calories = Float(totalSteps) * 0.04
                                
                                let bmr = UserDefaults.standard.float(forKey: "bmr")
                                self.calorieLabel.text  = "\(Float(calories) + bmr)"
                                UserDefaults.standard.set(calories, forKey: "Calories")
                                
                                
                                let db = Firestore.firestore()
                                db.collection("Steps").document(name ?? "").setData([
                                    "Calories": calories + bmr,
                                    "Stps": "\(totalSteps) / \(target) Steps"
                                    
                                ]) { (error:Error?) in
                                    if let error = error{
                                        print("\(error.localizedDescription)")
                                    }else {
                                        print("yes")
                                    }
                                    }
                                let dateFormatter = DateFormatter();
                                dateFormatter.dateFormat = "yyy-MM-dd"
                                let currentDate = dateFormatter.string(from: Date())//this gets the current date
                                
                                let date = UserDefaults.standard.string(forKey: "date")
                               
                                self.calorieLabel.text = "\(calories + bmr)"
                                
                                if currentDate != date{
                                    
                                    
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                                    let entity = NSEntityDescription.entity(forEntityName: "History", in: context)
                                    
                                    let newNote = History(entity: entity!, insertInto: context)
                                    
                                    let steps = UserDefaults.standard.integer(forKey: "steps")
                                    newNote.steps = Int32(steps)
                                    
                                    
                                    let databaseCalories = calories + bmr
                                    newNote.calories = Int32(databaseCalories)
                                    
                                    newNote.date = date
                                    
                                    
                                    
                                    do{
                                        try context.save()
                                        noteList.append(newNote)
                                        
                                    }
                                    catch{
                                        print("failed")
                                    }
                                
                                    
                                    UserDefaults.standard.set(currentDate, forKey: "date")
                                    UserDefaults.standard.set(0, forKey: "steps")
                                    let calories = 0
                                    UserDefaults.standard.set(calories, forKey: "Calories")    //This resets calories to bmr and steps to 0 when its a new day
                                    
                                }
                                
                            }
                            
                            
                            
                            
                        }
                    }
                }
            }
        }
        
        if timerCounting == true{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        }
       
        }
    @objc func updateLabel() -> Void
        {
            
            let calories = UserDefaults.standard.float(forKey: "Calories") //Gets the users calories
            let bmr = UserDefaults.standard.float(forKey: "bmr") //Gets the users calories
            let total = Int(calories + bmr)
            calorieLabel.text = "\(total)"
           
            let recentGo = UserDefaults.standard.integer(forKey: "recentGo")
            if recentGo != 1{
                UserDefaults.standard.set("", forKey: "finalDistance")
                UserDefaults.standard.set("", forKey: "exerciseCalories")
                UserDefaults.standard.set("", forKey: "exercise")
                UserDefaults.standard.set(1, forKey: "recentGo")
            }
            let distance = UserDefaults.standard.string(forKey: "finalDistance")
            let exerciseCalories = UserDefaults.standard.string(forKey: "exerciseCalories")
            let exercise = UserDefaults.standard.string(forKey: "exercise")
            
            self.exerciseLabel.text = exercise
            self.exCaloriesLabel.text = exerciseCalories
            self.distanceLabel.text = distance
            
        }
}
