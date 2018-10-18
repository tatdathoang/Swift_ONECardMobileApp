//
//  VCPhoto.swift
//  ONECard
//
//  Created by Dat Hoang on 16-06-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class VCPhoto: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //////////////////////////////////////
    //Property
    //////////////////////////////////////
    
    
    //////////////////////////////////////
    //UI element - Outlet
    //////////////////////////////////////
    @IBOutlet weak var IVPhoto: UIImageView!
    @IBOutlet weak var IVSeparateLine: UIImageView!
    
    
    //////////////////////////////////////
    //UI element - Action
    //////////////////////////////////////
    @IBAction func ChooseNewPhoto(_ sender: UIButton) {
        let imagePickerControler = UIImagePickerController()
        imagePickerControler.delegate = self
        
        let actionSheet = UIAlertController(title: "", message: "Chose a source of your ONCECard photo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerControler.sourceType = .camera
                self.present(imagePickerControler,animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerControler.sourceType = .photoLibrary
            self.present(imagePickerControler,animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet,animated: true, completion: nil)
    }
    
    //////////////////////////////////////
    //Helper
    ////////////////////////////////////// 
    //Load curent photo
    func LoadPhoto(){
        let currentPictureURL = URL(string: "https://goo.gl/Uuwg2s")!
        
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let downloadCurrentPictureSession = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadCurrentPictureTask = downloadCurrentPictureSession.dataTask(with: currentPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)!
                        // Do something with your image.
                        DispatchQueue.main.async {self.IVPhoto.image = image}
                        
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadCurrentPictureTask.resume()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        IVPhoto.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //////////////////////////////////////
    //Auto generate function
    //////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        //Design LBLSeparateLine
        self.IVSeparateLine.layer.masksToBounds = false
        self.IVSeparateLine.layer.shadowColor = UIColor.lightGray.cgColor
        self.IVSeparateLine.layer.shadowOpacity = 0.8
        self.IVSeparateLine.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.IVSeparateLine.layer.shadowRadius = 2
        
        self.LoadPhoto()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//////////////////////////////////////
//Extension
//////////////////////////////////////

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
