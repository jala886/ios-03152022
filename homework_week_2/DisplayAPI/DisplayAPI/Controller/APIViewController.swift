//
//  APIViewController.swift
//  DisplayAPI
//
//  Created by jianli on 3/25/22.
//

import UIKit

class APIViewController: UIViewController {
    
    private var currentRow:Int?
    
    private var data:[IdStatus] = [IdStatus]()
    
    private lazy var tabView:UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.register(APITableViewCell.self, forCellReuseIdentifier: APITableViewCell.identifier)
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    override func viewWillDisappear(_ animated: Bool) {
        saveData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        //MARK: - download data from website
        if self.data.isEmpty{
            var stillEmptyData = true
            let data = UserDefaults.standard.data(forKey: "data")
            if let data = data,let decodeData = try? JSONDecoder().decode([IdStatus].self, from: data){
                self.data = decodeData
                stillEmptyData = false
            }
            
            if stillEmptyData{
                downloadAPI{[weak self] res in
                    switch res{
                    case .failure(let e):
                        print(e.localizedDescription)
                    case .sucess(let data):
                        DispatchQueue.main.async {
                            self?.data = data
                            self?.tabView.reloadData()
                        }
                    }
                }
            }
            
        }
    }
    
    private func setupUI(){
        
        view.addSubview(tabView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tabView.topAnchor.constraint(equalTo:safeArea.topAnchor),
            tabView.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor),
            tabView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor),
            ])
    }
    // TODO:
    private func saveData(){
        if let cr = self.currentRow{print("save data: ",self.data[cr].status)}
        let encodeData = try! JSONEncoder().encode(self.data)
        UserDefaults.standard.set(encodeData, forKey: "data")
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

extension APIViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APITableViewCell.identifier, for: indexPath) as! APITableViewCell
        let row = indexPath.row
        let data = self.data[row]
        if data.status == true{
            cell.idLabel.textColor = .green
        }
        cell.configure(id:data.id,status:data.status ?? false)
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselect")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        let row = indexPath.row
        currentRow = row
        //passData = self.data[row]
        performSegue(withIdentifier: "detail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let destination = segue.destination as! FavouriteViewController
            guard let currentRow = self.currentRow else{return}
            destination.data = self.data[currentRow]
            destination.recall = {[weak self] status in
                self?.data[currentRow].status = status
                self?.tabView.reloadData()
                //self?.saveData()
            }
        }
    }
    @IBAction func unwind(segue:UIStoryboardSegue){
        
    }
    
    
    
}
