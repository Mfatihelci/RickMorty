//
//  RickMortyViewController.swift
//  RickMortySwift
//
//  Created by fatih on 29.05.2023.
//

import UIKit
import SnapKit

protocol RickMortyOutPut{
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickMortyViewController: UIViewController {
    
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        drawDesing()
        makeLabel()
        makeTableView()
        makeIndicator()
    }
    
    private func drawDesing(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 175
        DispatchQueue.main.async {
            self.view.backgroundColor = .yellow
            self.labelTitle.text = "Rick Morty"
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.indicator.color = .red
        }
        
        self.indicator.startAnimating()
    }
}

extension RickMortyViewController: RickMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
}

extension RickMortyViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
}

extension RickMortyViewController {
    private func makeLabel(){
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeIndicator(){
        indicator.snp.makeConstraints { make in
            make.top.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-10)
            make.height.equalTo(labelTitle)
        }
    }
    
    private func makeTableView(){
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.equalTo(labelTitle)
            make.right.equalTo(view).offset(-10)
        }
    }
}
