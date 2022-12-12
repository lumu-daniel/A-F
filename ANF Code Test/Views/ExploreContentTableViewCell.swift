//
//  ExploreContentTableViewCell.swift
//  ANF Code Test
//
//  Created by E-Cartale on 07/12/2022.
//

import UIKit

class ExploreContentTableViewCell: UITableViewCell {
    
    static let identifier = "ExploreContentTableViewCell"
    
    private var contentList:[Content] = [Content]()

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tag = 1
        return imageView
    }()
    
    
    private let topDescription: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.tag = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.tag = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let promoMessage: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 11)
        label.textColor = .black
        label.tag = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.tag = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 70)
        layout.scrollDirection = .vertical
        layout.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        uiCollectionView.register(UINib(nibName: ContentViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ContentViewCell.identifier)
        uiCollectionView.register(ContentViewCell.self, forCellWithReuseIdentifier: ContentViewCell.identifier)
        return uiCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(topDescription)
        contentView.addSubview(title)
        contentView.addSubview(promoMessage)
        contentView.addSubview(bottomDescription)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        applyConstraints()
         
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints(){
        
        let backgroundImageConstraints = [
            backgroundImage.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width ),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundImage.bottomAnchor.constraint(equalTo: topDescription.topAnchor, constant: -10),
            backgroundImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        let topDescriptionConstraints = [
            topDescription.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width ),
            topDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topDescription.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -5)
        ]
        
        let titleConstraints = [
            title.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: promoMessage.topAnchor, constant: -5)
        ]
        
        let promoMessageConstraints = [
            promoMessage.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width ),
            promoMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            promoMessage.bottomAnchor.constraint(equalTo: bottomDescription.topAnchor, constant: -5)
        ]
        
        let bottomDescriptionConstraints = [
            bottomDescription.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width ),
            bottomDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(backgroundImageConstraints)
        NSLayoutConstraint.activate(topDescriptionConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(promoMessageConstraints)
        NSLayoutConstraint.activate(bottomDescriptionConstraints)

    }
    
    public func configureContent(with contentData: [Content]){
        self.contentList.removeAll()
        self.contentList.append(contentsOf: contentData)
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension ExploreContentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentViewCell.identifier, for: indexPath) as? ContentViewCell else {return UICollectionViewCell()}
        let content = contentList[indexPath.row]
        cell.configure(with: content)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.count
    }
    
}
