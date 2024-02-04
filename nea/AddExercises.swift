import UIKit



class AddExercise: UIViewController {

    @IBOutlet weak var exercisesLabel: UILabel!
    

    @IBOutlet weak var exerciseTF: UITextField!
    
    
    
    override func viewDidLoad() {
        var exercises = UserDefaults.standard.stringArray(forKey: "exercises") //Gets the exercise list array from user defaults
        let concatenatedString = exercises!.joined(separator: "\n")  //creates a string from the values in array putting each item on a new line

        exercisesLabel.text = concatenatedString
        exercisesLabel.lineBreakMode = .byWordWrapping
        exercisesLabel.numberOfLines = 0     // handles the format of string in text field
        
        
    }
    
    @IBAction func saveExercises(_ sender: Any) {
        var exercises = UserDefaults.standard.stringArray(forKey: "exercises") // gets a reference to the exercises array
        var exercise = exerciseTF.text ?? ""   //Gets the string from the exercise text field
        exercises?.append(String(exercise))  // adds the new exercise to exercises variable
        UserDefaults.standard.set(exercises, forKey: "exercises")  //saves the new array to user defaults
      
    
        let concatenatedString = exercises!.joined(separator: "\n")
        
        exercisesLabel.text = concatenatedString
        exercisesLabel.lineBreakMode = .byWordWrapping
        exercisesLabel.numberOfLines = 0  //
    }
}
