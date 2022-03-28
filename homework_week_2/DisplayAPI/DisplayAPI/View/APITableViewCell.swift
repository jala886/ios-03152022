//
//  APITableViewCell.swift
//  DisplayAPI
//
//  Created by jianli on 3/25/22.
//

import UIKit

class APITableViewCell: UITableViewCell {
    static var identifier = "APITableViewCell"
    
     let idLabel:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .blue
        return lb
    }()
    private let statusLabel:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .black
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    private func setupUI(){
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(statusLabel)
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            idLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            idLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(id:Int,status:Bool){
        idLabel.text = "ID:\(id)"
        statusLabel.text = "\(status)"
    }

}
