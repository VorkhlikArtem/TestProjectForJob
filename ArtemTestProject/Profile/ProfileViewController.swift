//
//  ProfileViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    let localDataManager = LocalDataManager.shared
    
    var tableView: UITableView!
    var viewModel = ProfileViewModel()
    var header: HeaderTableView!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        header = HeaderTableView(image: viewModel.image, name: viewModel.name)
        header.changePhotoPublisher.sink { [weak self] in
            self?.addImageTapped()
        }.store(in: &cancellables)
        
        setupTableView()
        setConstraints()
        setupNavigationBar()
        
    }
    
    // MARK: - setup Table View and Navigation Bar
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseId)
        tableView.tableHeaderView = header
        tableView.separatorStyle = .none
        tableView.backgroundColor = .background
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupNavigationBar() {
        let back = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .done, target: nil, action: nil)
        back.tintColor = .black
        navigationItem.leftBarButtonItem = back
        let title = UILabel(text: "Profile", font: .montserratMedium(15), textColor: .black)
        navigationItem.titleView = title
    }
    
    // MARK: - setup Constraints
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),])
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseId, for: indexPath) as! OptionCell
        let option = viewModel.options[indexPath.row]
        cell.configure(option: option)
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            localDataManager.logoutCurrentUser()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func addImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        header.setImage(image: image)
        viewModel.savePhoto(image)
    }
}
