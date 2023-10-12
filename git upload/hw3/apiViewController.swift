//
//  apiViewController.swift
//  hw3
//
//  Created by Izzy Lapidus on 10/11/23.
//

import UIKit

class apiViewController: UIViewController {
    
    @IBOutlet weak var boxLabel: UIImageView!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var districtNumberLabel: UILabel!
    @IBOutlet weak var districtImage: UIImageView!
    @IBOutlet weak var numberOfStudentsLabel: UILabel!
    @IBOutlet weak var numberOfCSStudentsLabel: UILabel!
    @IBOutlet weak var percentLearningCSLabel: UILabel!
    
    var district: String = ""
    var districtNumber: String = ""
    var image: UIImage? = nil
    var numberOfStudents: String = ""
    var numberOfCSStudents: String = ""
    var percentLearningCS: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set info
//        self.districtLabel.text = district
//        self.districtNumberLabel.text = districtNumber
//        self.districtImage.image = image
//        self.numberOfStudentsLabel.text = numberOfStudents
//        self.numberOfCSStudentsLabel.text = numberOfCSStudents
//        self.percentLearningCSLabel.text = percentLearningCS
        self.districtLabel.text = district
        self.districtNumberLabel.text = districtNumber
        self.numberOfStudentsLabel.text = numberOfStudents
        self.numberOfCSStudentsLabel.text = numberOfCSStudents
        self.percentLearningCSLabel.text = percentLearningCS
        
        //temporary until i learn map stuff
        self.districtImage.image = UIImage(named: "rainbow")
    
        
//        // Make pretty...
        self.percentLearningCSLabel.layer.cornerRadius = 10.0
        self.percentLearningCSLabel.layer.masksToBounds = true
        self.boxLabel.layer.cornerRadius = 10.0
        self.percentLearningCSLabel.layer.masksToBounds = true

        
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
