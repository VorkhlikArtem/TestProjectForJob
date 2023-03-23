//
//  SearchFieldHeader.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit
import Combine

class SearchFieldHeader: UICollectionReusableView {
    static let reuseId = "SearchFieldHeader"
    
    private let changedSearchTextSubject = PassthroughSubject<String, Never>()
    var changedSearchTextPublisher: AnyPublisher<String, Never> {
        changedSearchTextSubject
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private let textFieldTappedSubject = PassthroughSubject<UITableView, Never>()
    var textFieldTappedPublisher: AnyPublisher<UITableView, Never> {
        textFieldTappedSubject.eraseToAnyPublisher()
    }
    
    var cancellables: Set<AnyCancellable> = []
    
    var prefixWords = [String]() {
        didSet {
            self.promptTable.frame.size.height = prefixWords.count < 5 ? CGFloat(prefixWords.count * 44) : 200
            promptTable.reloadData()
        }
    }
    
    let searchField = SearchTextField()
    
    lazy var promptTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .gray
        tableView.layer.cornerRadius = 10
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        searchField.delegate = self
        setupConstraints()
        setupHelperTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func textChanged(textField: UITextField) {
//        guard !(textField.text ?? "").isEmpty else {
//            self.promptTable.frame.size.height = 0; return
//        }
        changedSearchTextSubject.send(textField.text ?? "")
    }
    
    // MARK: - setup Table View and constraints
    func setupHelperTableView() {
        NotificationCenter.default.publisher(for: .hideFilterTables).sink { [weak self] _ in
            self?.searchField.resignFirstResponder()
            self?.promptTable.removeFromSuperview()
        }.store(in: &cancellables)
    }
    
    func setupConstraints() {
        searchField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            searchField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchFieldHeader: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prefixWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = promptTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        var content = cell.defaultContentConfiguration()
        content.text = prefixWords[indexPath.row]
        content.textProperties.color = .black
        content.textProperties.font = .montserratRegular(10)!
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchField.text = prefixWords[indexPath.row]
        promptTable.removeFromSuperview()
    }
}

extension SearchFieldHeader: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textChanged(textField: searchField)
        textFieldTappedSubject.send(promptTable)
        return true
    }
}
