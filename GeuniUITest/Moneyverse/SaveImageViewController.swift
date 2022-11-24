//
//  SaveImageViewController.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/06/15.
//

import UIKit
import Then

class SaveImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    private let progressView = MoneyverseProgressView()
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
        self.imagePicker.allowsEditing = true // 수정 가능 여부
        self.imagePicker.delegate = self // picker delegate
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func tapImagePicker(_ sender: Any) {
        pickImage()
    }
    
    @IBAction func saveImage(_ sender: Any) {
        if let image = imageView.image {
            _ = saveImage(image: image, name: nameText.text)
        }
    }
    
    @IBAction func loadImage(_ sender: Any) {
        if let text = nameText.text {
            let image = getSavedImage(named: text)
            imageView.image = image
        }
    }
    
    
    @objc func pickImage(){
        self.present(self.imagePicker, animated: true)
    }
    
    func saveImage(image: UIImage, name: String?) -> Bool {
        guard let name = name else {
            return false
        }

        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(name)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

    func parseURLForFileName(url:String) ->String? {
        if let url = URL(string: url) {
            let withoutExt = url.deletingPathExtension()
            let name = withoutExt.lastPathComponent
            return name
        }
        return nil
    }
}

extension SaveImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        // 이미지 이름 추출
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] {
            if let imageName = parseURLForFileName(url: "\(imageURL)") {
                self.nameText.text = imageName
            }
        }
        
        self.imageView.image = newImage // 받아온 이미지를 update
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
    }
}
