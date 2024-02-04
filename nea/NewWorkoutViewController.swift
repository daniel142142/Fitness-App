import UIKit


class NewWorkoutViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func backAndChest(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Workoutpage") as! WorkoutViewController // this sets a variable to the workout view controller
        vc.ex1 = "Bench press:"
        vc.ex2 = "Barbell row:"
        vc.ex3 = "Chest flys:"
        vc.ex4 = "Pullups:"
        vc.ex5 = "Pushups:"
        vc.ex6 = "Lat pulldowns:" //These change the variables in workout view controller
        
        self.navigationController?.pushViewController(vc, animated: true)// This displays the workout view controller
    }
    
    @IBAction func arms(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Workoutpage") as! WorkoutViewController // this sets a variable to the workout view controller
        vc.ex1 = "Bicep curls:"
        vc.ex2 = "Tricep extensions:"
        vc.ex3 = "Cable curls:"
        vc.ex4 = "Tricep pushdowns:"
        vc.ex5 = "Hammer curls:"
        vc.ex6 = "Close grip bench press:" //These change the variables in workout view controller
        
        self.navigationController?.pushViewController(vc, animated: true)// This displays the workout view controller
    }
    
    @IBAction func Legs(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Workoutpage") as! WorkoutViewController // this sets a variable to the workout view controller
        vc.ex1 = "Squats:"
        vc.ex2 = "Deadlifts:"
        vc.ex3 = "Leg exensions:"
        vc.ex4 = "Hamstring curls:"
        vc.ex5 = "single leg squat:"
        vc.ex6 = "Straight leg deadlift:" //These change the variables in workout view controller
        
        self.navigationController?.pushViewController(vc, animated: true)// This displays the workout view controller
    }
    
}
