//
//  RickMortyTableViewCell.swift
//  RickMortySwift
//
//  Created by fatih on 29.05.2023.
//

import UIKit
import AlamofireImage

class RickMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "mfe10"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        drawDesing()
    }
    
    private func drawDesing() {
        title.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .italicSystemFont(ofSize: 13)
        makeCustomImage()
        makeTitle()
        makeCustomDescription()
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string: model.image ?? randomImage) ?? URL(string: randomImage)!)
    }
}

extension RickMortyTableViewCell {
    private func makeCustomImage() {
        customImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(120)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func makeTitle() {
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(5)
            make.left.right.equalTo(customImage)
            make.width.height.equalTo(20)
        }
    }
    
    private func makeCustomDescription() {
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.equalTo(customImage)
        }
    }
}
