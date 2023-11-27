//
//  HomeVC.swift
//  AN Convertor
//
//  Created by Naga Lakshmi on 11/21/23.
//

import UIKit
import SoundAnalysis
import AVFoundation
import AnimatedGradientView
class HomeVC: UIViewController {

    
    var audioPlayer: AVAudioPlayer?
    
    
    @IBOutlet weak var Play: UIButton!
    
    
    @IBOutlet weak var pview: UIPickerView!
    
    @IBOutlet weak var imageIV: UIImageView!
    
    let testlist = ["king","queen","bishop","elephant","sippoi"]
    var inputfile = "background"
    var imageColl:[String] = []
    var result:String = ""
    var player:AVAudioPlayer!
    var audioFileURL = Bundle.main.url(forResource: "king", withExtension: "mp3")!
    var observer:ResultsObserver = ResultsObserver(result: "Helloworld")
    
    
    @IBOutlet weak var Transform: UIButton!
    
    @IBAction func TransformAction(_ sender: UIButton) {
        
        fileToLoad()
        classifySound()
        //var imgArr:[UIImage] = []
        print(observer.classificationResult)
        print(observer.imageColl)
        
        let images = observer.imageColl.compactMap { UIImage(named: $0) }

               // Function to combine images horizontally
               let compositeImage = combineImagesHorizontally(images: images)

               // Set the composite image to the UIImageView
               imageIV.image = compositeImage
        
        if(inputfile.elementsEqual("background")){
            let alert = UIAlertController(title: "Missing Selection", message: "Please select any one of the below mentioned input file", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert,animated: true)
        }
        observer.imageColl.removeAll()
    }
    
    func fileToLoad(){
        switch(inputfile){
            
        case "king":
             audioFileURL = Bundle.main.url(forResource: "king", withExtension: "mp3")!
            
        case "queen":
             audioFileURL = Bundle.main.url(forResource: "queen", withExtension: "mp3")!
            
        case "bishop":
             audioFileURL = Bundle.main.url(forResource: "bishop", withExtension: "mp3")!
        case "elephant":
             audioFileURL = Bundle.main.url(forResource: "elephant", withExtension: "mp3")!
        case "sippoi":
             audioFileURL = Bundle.main.url(forResource: "sippoi", withExtension: "mp3")!
        default:
             audioFileURL = Bundle.main.url(forResource: "background", withExtension: "mp3")!
            break
        }
    }
    
    @IBAction func TunePlay(_ sender: UIButton) {
        fileToLoad()
        
        do{
            audioPlayer = try! AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer?.play()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem
        pview.delegate=self
        pview.dataSource=self
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
        

        // Do any additional setup after loading the view.
    }
    
    
    func classifySound(){
        
       let fileAnalyzer = try! SNAudioFileAnalyzer(url: audioFileURL)

        let request = try! SNClassifySoundRequest(mlModel: MusicNote().model)
        do{
            try? fileAnalyzer.add(request, withObserver: observer)
            
            try fileAnalyzer.analyze()
            
            
        }
    }
    
    
    func combineImagesHorizontally(images: [UIImage]) -> UIImage {
         let imageSize = CGSize(width: images.reduce(0) { $0 + $1.size.width }, height: images[0].size.height)
         UIGraphicsBeginImageContext(imageSize)

         var xPosition: CGFloat = 0

         for image in images {
             image.draw(at: CGPoint(x: xPosition, y: 0))
             xPosition += image.size.width
         }

         let compositeImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return compositeImage!
     }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return testlist.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return testlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        inputfile = testlist[row]
    }
    
    
}

class ResultsObserver: NSObject, SNResultsObserving {
    
    var classificationResult:String
    var imageColl:[String] = []
    
    init(result: String){
        classificationResult = result
    }
    
    /// Notifies the observer when a request generates a prediction.
    func request(_ request: SNRequest, didProduce result: SNResult) {
        // Downcast the result to a classification result.
        guard let result = result as? SNClassificationResult else  { return }


        // Get the prediction with the highest confidence.
        guard let classification = result.classifications.first else { return }


        // Get the starting time.
        let timeInSeconds = result.timeRange.start.seconds


        // Convert the time to a human-readable string.
        let formattedTime = String(format: "%.2f", timeInSeconds)
        print("Analysis result for audio at time: \(formattedTime)")


        // Convert the confidence to a percentage string.
        let percent = classification.confidence * 100.0
        let percentString = String(format: "%.2f%%", percent)


        // Print the classification's name (label) with its confidence.
        print("\(classification.identifier): \(percentString) confidence.\n")
        classificationResult += "The output of audio at the time: \(formattedTime) \(classification.identifier): \(percentString) confidence.\n"
        
        if(Int(percent) > 70){
            imageColl.append(classification.identifier)
        }
    }




    /// Notifies the observer when a request generates an error.
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The analysis failed: \(error.localizedDescription)")
    }


    /// Notifies the observer when a request is complete.
    func requestDidComplete(_ request: SNRequest) {
        print("The request completed successfully!")
        //imageColl.removeAll()
    }
}
