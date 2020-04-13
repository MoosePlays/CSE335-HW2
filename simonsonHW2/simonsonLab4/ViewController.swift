//
//  ViewController.swift
//  simonsonLab4
//
//  Created by mjsimons on 2/27/20.
//  Copyright © 2020 mjsimons. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //model
    var myCityList:cities = cities()
    
    @IBOutlet weak var cityTable: UITableView!
    
    //set number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return myCityList.sections.count
    }
    
    //set array of available header titles
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return myCityList.sortedFirstLetters
    }
    
    //set title for header in section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return myCityList.sortedFirstLetters[section]
    }
    
    //get number of rows in a particular section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCityList.getRowCount(section: section)
    }
    
    //fill in data for particular cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        
        //calling the model to get the city object in each row
        let cityItem = myCityList.getCityObject(section: indexPath.section, row: indexPath.row)
        
        cell.cityName.text = cityItem.cityName
        cell.cityImage.image = cityItem.cityImage
        
        return cell
    }
    
    // delete table entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // set editing style for rows
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    // once user selects deletion, come here
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //delete the data from the city table
        myCityList.removeCityObject(section: indexPath.section, row: indexPath.row)
        
        self.cityTable.reloadData()
        
    }
    
    // add button functionality
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter name of city here"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            
            if let name = alert.textFields?.first?.text {
                print("City name: \(name)")
                
                self.myCityList.addCityObject(name: name, desc: "Empty description", image: UIImage(named: "questionMark.jpg")!)
                
                self.cityTable.reloadData()
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    //segue to detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        let city = myCityList.getCityObject(section: selectedIndex.section, row: selectedIndex.row)
        cityTable.reloadData()
        
        if(segue.identifier == "detailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController{
                viewController.cityObject = city
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

