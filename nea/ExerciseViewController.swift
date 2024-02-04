import UIKit
import CoreLocation

class ExerciseViewController: UIViewController {
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
   
    @IBOutlet weak var avgSpeedLabel: UILabel!
    
    @IBOutlet weak var speedTimerLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    let locationManager = CLLocationManager() //Gets a reference to core location manager
    
    let timerCounting = true
    var timer:Timer = Timer()
    var timer1:Timer = Timer()
    var count:Int = 0
    var startedTime = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Exercise"
        
        locationManager.delegate = self //sets delegate to location manager to self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //sets the accuracy type to best
        
        stopButton.isHidden = true // hides the stop button
        
    }

    @IBAction func startButton(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "distance")//sets to 0 for new activity
        UserDefaults.standard.set(0, forKey: "startedTime")
        UserDefaults.standard.set(0, forKey: "first") // sets to 0 so that if statement to get first location runs
        UserDefaults.standard.set(0, forKey: "time") // Saves time to user defaults
        UserDefaults.standard.set(0, forKey: "timer")
        avgSpeedLabel.text = "0 Km/H"
        distanceLabel.text = "0 Km"
        retriveCurrentLocation()
        if timerCounting == true{
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(retriveCurrentLocation), userInfo: nil, repeats: true)//runs the retrieveCurrentLocation()
        }
        if timerCounting == true{
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        startButton.isHidden = true // Hides the start button
        stopButton.isHidden = false // Shows the stop button
    }
    

    @IBAction func stopButton(_ sender: UIButton) {
       
        timer.invalidate() //Stops getting location
        timer1.invalidate() // Stops the timer
        
        let time = timerLabel.text
        let finalDistance = distanceLabel.text
        UserDefaults.standard.set(time, forKey: "time") // Saves time to user defaults
        UserDefaults.standard.set(finalDistance, forKey: "finalDistance")
        startButton.isHidden = false // shows the start button
        stopButton.isHidden = true // hides the stop button
    }
    

    @objc func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            return
        }
        
        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            
            locationManager.requestAlwaysAuthorization()
            
            return
        }
        
        
        // request location data for one-off usage
        locationManager.requestLocation()
    }
    @objc func timerCounter() -> Void
        {
            var go = UserDefaults.standard.string(forKey: "timerGo")
            if go == "yes"{
                var count = UserDefaults.standard.integer(forKey: "timer")
                count = count + 1
                let time = secondsToHoursMinutesSeconds(seconds: count)
                let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                timerLabel.text = timeString
                UserDefaults.standard.set(count, forKey: "timer")
            }
            else{
                
            }
            
            
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
extension ExerciseViewController : CLLocationManagerDelegate {
    //Called with the startUpdatingLocation function
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // the last element is the most recent location
        if let location = locations.first {
            
            let first = UserDefaults.standard.integer(forKey: "first")
            if first == 0{
                var firstLat = location.coordinate.latitude
                var firstLong = location.coordinate.longitude  // gets longitude and latitude
                
                UserDefaults.standard.set(firstLat, forKey: "oldLat")
                UserDefaults.standard.set(firstLong, forKey: "oldLong")// sets first lat and long values to user defaults
                
                UserDefaults.standard.set(1, forKey: "first")//changes first to 1 so that this if statement wont run again
            }
            
            
            
            
            var oldLat = UserDefaults.standard.double(forKey: "oldLat")
            var oldLong = UserDefaults.standard.double(forKey: "oldLong") // gets the old coordinates
            
            var secondLat = location.coordinate.latitude
            var secondLong = location.coordinate.longitude // gets new values for coordinates
            
            var secondLocation = CLLocation(latitude: secondLat, longitude: secondLong)
            var oldLocation = CLLocation(latitude: oldLat, longitude: oldLong) // sets up CCLocation variables
            
            let distance = oldLocation.distance(from: secondLocation) // Gets disntance between coordinates
            let distanceFloat = Float(distance)// Puts this in a float datatype
            
            if distanceFloat > 5{
                
                let oldDistance = UserDefaults.standard.float(forKey: "distance") //Gets previous value of distance
                
                let newDistance = oldDistance + distanceFloat //adds to the distance variable
               
                var km = newDistance / 1000
                var roundedKm = round(km * 100) / 100.0 // rounds the distance
                self.distanceLabel.text = "Distance:  \(roundedKm) Km"// displays distance
                UserDefaults.standard.set(newDistance, forKey: "distance")//saves the distance
                
                
                let oldtime = UserDefaults.standard.integer(forKey: "startedTime")
                let startedTime = oldtime + 5 // Counts the time that workout is started
                print(startedTime)
                
                
                
                let kmS = km / Float(startedTime) // does distance over time to get average speed in km/s
                let avgSpeed = kmS * 3600 //converts km/s to km/h
                var roundedAvgSpeed = round(avgSpeed * 100) / 100.0 // rounds the distance
                self.avgSpeedLabel.text = "Avg Speed: \(roundedAvgSpeed) Km/H" //Prints the average speed
                
                UserDefaults.standard.set(avgSpeed, forKey: "avgSpeed")
                UserDefaults.standard.set(startedTime, forKey: "startedTime")
                self.pauseLabel.text = "Started"
                self.pauseLabel.textColor = UIColor.green //sets paused label to green
                var timerGo = "yes"
                UserDefaults.standard.set(timerGo, forKey: "timerGo")
                
                
            }
            else{
                self.pauseLabel.text = "Paused"
                self.pauseLabel.textColor = UIColor.red // sets paused label to red
                var timerGo = "no"
                UserDefaults.standard.set(timerGo, forKey: "timerGo")
            }
            UserDefaults.standard.set(secondLat, forKey: "oldLat")
            UserDefaults.standard.set(secondLong, forKey: "oldLong") //puts new coordinates to old
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")

    }
}
