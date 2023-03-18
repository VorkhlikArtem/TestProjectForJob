//
//  ProfileViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    var tableView: UITableView!
    var viewModel = ProfileViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableHeaderView = HeaderTableView(image: UIImage(named: "plus")!, name: "Artem")
        
        tableView.backgroundColor = .white
     
        setConstraints()
        
    }
    
    
    private func setConstraints() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),])
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let option = viewModel.options[indexPath.row]
        
        cell.backgroundColor = .yellow
        var content = cell.defaultContentConfiguration()
        
        content.text = option.title
        content.textProperties.color = #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1)
        if let font = UIFont.montserratBold(15) {
            content.textProperties.font = font
        }
        
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9336996675, green: 0.9384759068, blue: 0.9589853883, alpha: 1)
        content.image = UIImage(named: option.image)
        content.imageProperties.cornerRadius = 20
       
        if let detailInfo = option.accessoryInfo {
            let label = UILabel(text: detailInfo, font: .montserratMedium(15), textColor: #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1))
            cell.accessoryView = label
        }
        cell.accessoryType = option.hasDisclosure ? .disclosureIndicator : .none
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return HeaderTableView(image: UIImage(named: "plus")!, name: "Artem")
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    
}
