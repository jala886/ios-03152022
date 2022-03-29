//
//  ViewController.swift
//  DownloadImage
//
//  Created by jianli on 3/29/22.
//

import UIKit

class ViewController: UIViewController {
    let size = UIScreen.main.bounds
    
    let  imageView:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints=false
        //iv.backgroundColor = .lightGray
        return iv
    }()
    let  downloadButton:UIButton = {
        let db = UIButton()
        //db.backgroundColor = .red
        db.setTitleColor(UIColor.blue, for: .normal)
        db.setTitle("Load a new Image", for: .normal)
        db.translatesAutoresizingMaskIntoConstraints = false
        db.addTarget(self, action: #selector(downloadImage), for: .touchUpInside)
        db.backgroundColor = .orange
        db.contentEdgeInsets=UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        db.layer.cornerRadius=5
        return db
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI(){
        view.addSubview(imageView)
        view.addSubview(downloadButton)
        let saftArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            downloadButton.bottomAnchor.constraint(equalTo: saftArea.bottomAnchor),
            downloadButton.centerXAnchor.constraint(equalTo: saftArea.centerXAnchor),
            //downloadButton.leadingAnchor.constraint(equalTo: saftArea.leadingAnchor),
            //downloadButton.trailingAnchor.constraint(equalTo: saftArea.trailingAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: downloadButton.topAnchor,constant: -5),
            imageView.topAnchor.constraint(equalTo: saftArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: saftArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: saftArea.trailingAnchor)
        ])
    }

    @objc func downloadImage(){
        print(self.view.frame)
        let urlStr = "https://picsum.photos/\(String(format:"%.0f",size.width))/\(String(format:"%.0f",size.height))"
        print(urlStr)
        guard let url = URL(string:urlStr) else{return}
        do{
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            imageView.image = image
            
        }catch(let e){
            print(e.localizedDescription)
        }
    }
}

