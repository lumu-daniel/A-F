//
//  ContentViewButton.swift
//  ANF Code Test
//
//  Created by E-Cartale on 08/12/2022.
//

import UIKit

class ContentViewCell: UICollectionViewCell {
    
    static let identifier = "ContentViewButton"
    
    private let contentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints(){
        let contentButtonConstraints = [
            contentButton.widthAnchor.constraint(equalToConstant: frame.width),
            contentButton.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(contentButtonConstraints)
    }
    
    public func configure(with buttonTittle:String){
        contentButton.setTitle(buttonTittle, for: .normal)
    }
    
}
