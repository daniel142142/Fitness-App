import UIKit



class WorkoutPopUp: UIViewController{
    
    @IBOutlet weak var ex1TF: UITextField!
    @IBOutlet weak var ex2TF: UITextField!
    @IBOutlet weak var ex3TF: UITextField!
    @IBOutlet weak var ex4TF: UITextField!
    @IBOutlet weak var ex5TF: UITextField!
    @IBOutlet weak var ex6TF: UITextField!
    
   
    
    let exercises = Foundation.UserDefaults.standard.stringArray(forKey: "exercises")
    
    
    
    var ex1PickerView = UIPickerView() //This sets up the picker view
    var ex2PickerView = UIPickerView()
    var ex3PickerView = UIPickerView()
    var ex4PickerView = UIPickerView()
    var ex5PickerView = UIPickerView()
    var ex6PickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ex1TF.inputView = ex1PickerView //sets text field to type picker view
        ex2TF.inputView = ex2PickerView
        ex3TF.inputView = ex3PickerView
        ex4TF.inputView = ex4PickerView
        ex5TF.inputView = ex5PickerView
        ex6TF.inputView = ex6PickerView
        
        ex1PickerView.delegate = self
        ex1PickerView.dataSource = self //This sets the data for the text field
        ex2PickerView.delegate = self
        ex2PickerView.dataSource = self
        ex3PickerView.delegate = self
        ex3PickerView.dataSource = self
        ex4PickerView.delegate = self
        ex4PickerView.dataSource = self
        ex5PickerView.delegate = self
        ex5PickerView.dataSource = self
        ex6PickerView.delegate = self
        ex6PickerView.dataSource = self
        
        ex1PickerView.tag = 1
        ex2PickerView.tag = 2
        ex3PickerView.tag = 3
        ex4PickerView.tag = 4
        ex5PickerView.tag = 5
        ex6PickerView.tag = 6 // creats a unique tag for each picker view
        
        
        
        
        let firstUse = UserDefaults.standard.integer(forKey: "firstUse")
        if firstUse != 1{
            let exercises = ["Squat:", "Leg press:", "Deadlift:", "Leg extension:", "Hamstring curl:", "Single leg squat:", "Straight legged deadlift:", "Standing calf raise:", "Seated calf raise:", "Bench press:", "Close grip bench press:", "Chest flys:", "Push ups:", "Lateral raises:", "Front raises:", "Bicep curls:", "Lat pulldowns:", "Bicep curls", "Tricep extensions:"] // Items in this array will be used in picker view
            UserDefaults.standard.set(exercises, forKey: "exercises")
            UserDefaults.standard.set(1, forKey: "firstUse")
            
        }
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        var exercise1 = ex1TF.text
        var exercise2 = ex2TF.text
        var exercise3 = ex3TF.text
        var exercise4 = ex4TF.text
        var exercise5 = ex5TF.text
        var exercise6 = ex6TF.text //This creates variables for each exercise the user selects in the text fields
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Workoutpage") as! WorkoutViewController // this sets a variable to the workout view controller
        vc.ex1 = exercise1
        vc.ex2 = exercise2
        vc.ex3 = exercise3
        vc.ex4 = exercise4
        vc.ex5 = exercise5
        vc.ex6 = exercise6 //These change the variables in workout view controller to the exercise variables
        
        self.navigationController?.pushViewController(vc, animated: true)// This displays the workout view controller
    }
}
extension WorkoutPopUp: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercises?.count ?? 0 //This counts how many objects there are in the array
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercises?[row]  //this returns the object of the array
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 1 :  //This sets up the different cases for each text field
            ex1TF.text = exercises?[row]
            ex1TF.resignFirstResponder()
        case 2:
            ex2TF.text = exercises?[row]
            ex2TF.resignFirstResponder()
        case 3:
            ex3TF.text = exercises?[row]
            ex3TF.resignFirstResponder()
        case 4:
            ex4TF.text = exercises?[row]
            ex4TF.resignFirstResponder()
        case 5:
            ex5TF.text = exercises?[row]
            ex5TF.resignFirstResponder()
        case 6:
            ex6TF.text = exercises?[row]
            ex6TF.resignFirstResponder()
        default:
            return         }// This function sets the text in the text field
    }
}
