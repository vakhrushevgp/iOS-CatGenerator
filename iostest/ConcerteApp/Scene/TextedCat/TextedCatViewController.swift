//
//  File.swift
//  ConcerteApp
//
//  Created by Gordei Vakhrushev on 03.11.2024.
//

import UIKit

class TextedCatViewController: UIViewController {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var CatImage: UIImageView!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var TextInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillHideNotification, object: nil)
        // я не понимаю почему клавиатура не выскакиевает -- делал ровно по туториалу индийского мужчины с ютуба: у него все хорошо, а у меня клавиатуры нет.
    }
    
    private func downloadTextedCat() {
        let message: String = self.TextInput.text ?? ""
        guard let url = URL(string: "https://cataas.com/cat/\(message)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.CatImage.image = UIImage(data: data)
            }
            // тоже не понятно почему тут оно не обновляется вдруг
        }
        
        task.resume()
    }

    @IBAction func tapped(_ sender: Any) {
        downloadTextedCat()
    }
    
    
    var isExpend: Bool = false
    @objc func keyboardApear() {
        if !isExpend {
            self.ScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.ScrollView.frame.height + 250)
            isExpend = true
        }
    }
    @objc func keyboardDispear() {
        if isExpend {
            self.ScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.ScrollView.frame.height - 250)
            isExpend = false
        }
    }
}
