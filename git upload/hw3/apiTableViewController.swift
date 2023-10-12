//
//  apiTableViewController.swift
//  hw3
//
//  Created by Izzy Lapidus on 10/10/23.
//

import UIKit

class myCustomCell: UITableViewCell {

    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var districtNumberLabel: UILabel!
    @IBOutlet weak var districtImage: UIImageView!
    @IBOutlet weak var numberOfStudentsLabel: UILabel!
    @IBOutlet weak var numberOfCSStudentsLabel: UILabel!
    @IBOutlet weak var percentLearningCSLabel: UILabel!
    
}

class apiTableViewController: UITableViewController {
    
    // Data Model
    struct DataItem: Decodable {
        let district: String?
        let districtNumber: String?
        let numberOfStudents: String?
        let numberOfCSStudents: String?
        let percentLearningCS: String?
        
        enum CodingKeys: String, CodingKey {
            case district = "category_type"
            case districtNumber = "category_values"
            case numberOfStudents = "of_students_all_grades"
            case numberOfCSStudents = "students_taking_cs_all_grades"
            case percentLearningCS = "students_taking_cs_citywide"
        }
    }
    
    // Data Storage
    var allDataItems:[DataItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch data when the view loads
        getAllData()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows equals the number of todo items
        return allDataItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCustomCell
        
        //Get the data item for the current index path
        let thisItem = allDataItems[indexPath.row]
        
        //Configure the cell...
        cell.districtLabel.text = thisItem.district ?? "N/A"
        cell.districtNumberLabel.text = thisItem.districtNumber ?? "N/A"
        cell.numberOfStudentsLabel.text = "\(thisItem.numberOfStudents ?? "N/A") students"
        cell.numberOfCSStudentsLabel.text = "\(thisItem.numberOfCSStudents ?? "N/A") CS students"
        cell.percentLearningCSLabel.text = "\(thisItem.percentLearningCS ?? "N/A")% of students in District \(thisItem.districtNumber ?? "district") learning CS"
        //add temporary image reference before i implement real district map next hw
        cell.districtImage.image = UIImage(named:"star")
        
        // Make pretty...
        cell.percentLearningCSLabel.layer.cornerRadius = 10.0
        cell.percentLearningCSLabel.layer.masksToBounds = true
        return cell
    }
    
    // Fetch data from API
    func getAllData() {
        
        let url = URL(string: "https://data.cityofnewyork.us/resource/gnum-kz6r.json?$limit=33")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Error handling
            guard error == nil else {
                print("Error: \(error!)")
                
                // Handle specific errors
                if let urlError = error as? URLError {
                    var errorMessage = ""
                    
                    switch urlError.code {
                    case .notConnectedToInternet:
                        errorMessage = "No internet connection!"
                    case .timedOut:
                        errorMessage = "The request timed out!"
                    case .cannotFindHost, .cannotConnectToHost:
                        errorMessage = "Cannot connect to the server!"
                    default:
                        errorMessage = "An unknown error occurred ;("
                    }
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                print("No data received!")
                return
            }
            
            // Decode JSON data
            do {
                self.allDataItems = try JSONDecoder().decode([DataItem].self, from: data)
                
                // Reload table view on main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON decoding error: \(error)")
            }
        }
        
        task.resume() // Start data task
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destVC = segue.destination as? apiViewController,
           let selectedRow = tableView.indexPathForSelectedRow?.row {
            
            // Get selected data item
            let selectedItem = allDataItems[selectedRow]
            
            // Pass data to destination view controller
            destVC.district = selectedItem.district ?? "N/A"
            destVC.districtNumber = selectedItem.districtNumber ?? "N/A"
            destVC.numberOfStudents = "\(selectedItem.numberOfStudents ?? "N/A") students"
            destVC.numberOfCSStudents = "\(selectedItem.numberOfCSStudents ?? "N/A") CS students"
            destVC.percentLearningCS = "\(selectedItem.percentLearningCS ?? "N/A")% of students learning CS"
        }
    }
    
}
