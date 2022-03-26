//
//  FavouriteViewController.swift
//  DisplayAPI
//
//  Created by jianli on 3/25/22.
//

import UIKit

class FavouriteViewController: UIViewController {
    var data:IdStatus?
    var recall:((Bool)->Void)?
    
    private let favorLabel:UILabel = {
        let ul = UILabel()
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.text = "Favorite"
        ul.font = UIFont.systemFont(ofSize: 20)
        return ul
    }()
    
    private let switcher:UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(switchStatus),for: UIControl.Event.valueChanged)
        return sw
    }()
    private let image:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        configure()
    }
    private func setupUI(){
        view.addSubview(favorLabel)
        view.addSubview(switcher)
        view.addSubview(image)
        switcher.isOn = data?.status ?? false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            favorLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant:20),
            favorLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant:20),
            //favorLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant:20),
            favorLabel.heightAnchor.constraint(equalTo: switcher.heightAnchor),
            
            switcher.topAnchor.constraint(equalTo: safeArea.topAnchor, constant:20),
            switcher.leadingAnchor.constraint(equalTo: favorLabel.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: favorLabel.bottomAnchor,constant: 20),
            image.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant:20),
            image.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant:20),
            image.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant:20)
            
            
        ])
    }
    //MARK: - download and setup Image, setup switch
    private func configure(){
        guard let data = self.data, let url=URL(string:data.img_src)
        else{return}
        //TODO:
        DispatchQueue.global().async {[weak self] in
            do{
                let imgData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self?.image.image = UIImage(data:imgData)
                }
            }catch(let e){
                print(e.localizedDescription)
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc private func switchStatus(){
        self.data?.status = switcher.isOn
        print("update: ",self.data?.status)
        self.recall?(self.data?.status ?? false)
    }
}
