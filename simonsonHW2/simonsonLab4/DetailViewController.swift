//
//  DetailViewController.swift
//  simonsonLab4
//
//  Created by mjsimons on 2/27/20.
//  Copyright © 2020 mjsimons. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var cityObject: city = city(cn: "", cd: "", ci: UIImage(named: "questionMark.jpg")!)
    var imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = cityObject.cityName
        imageView.image = cityObject.cityImage
        descriptionLabel.text = cityObject.cityDescription
    }
    
    func newImage(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            cityObject.cityImage = image
            imageView.image = image
        }
        
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    
    @IBAction func enableEditing(_ sender: Any) {
        let editAlert = UIAlertController(title: "Edit Info", message: "", preferredStyle: .actionSheet)
        
        //edit photo here
        editAlert.addAction(UIAlertAction(title: "Photo", style: .default, handler: {action in
            self.newImage()
        }))
        
        //edit description here
        editAlert.addAction(UIAlertAction(title: "Description", style: .default, handler: {action in
            
            let descriptionAlert = UIAlertController(title: "Edit Description", message: "", preferredStyle: .alert)
            
            descriptionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            descriptionAlert.addTextField(configurationHandler: {
                textField in
                textField.text = self.cityObject.cityDescription
            })
            
            descriptionAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: {action in
                
                if let desc = descriptionAlert.textFields?.first?.text {
                    print("New description: \(desc)")
                    
                    self.cityObject.cityDescription = desc
                    self.descriptionLabel.text = desc
                }
            }))
            self.present(descriptionAlert, animated: true)
        }))
        
        //cancel button
        editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(editAlert, animated: true)
    }
    
}
