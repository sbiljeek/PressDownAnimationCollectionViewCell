//
//  MyCell.swift
//  PressDownAnimationCollectionViewCell
//
//  Created by Salman Biljeek on 3/12/23.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    let profileImageHeight: CGFloat = 20
    let profilePlaceholderImage = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.label)
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: profilePlaceholderImage)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: profileImageHeight).isActive = true
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: profileImageHeight)
        heightConstraint.priority = UILayoutPriority(990)
        heightConstraint.isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = profileImageHeight / 2
        imageView.layer.borderWidth = 1
        return imageView
    }()
    let usernamelLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    let imageHeight: CGFloat = 70
    let profileImageCornerRadius: CGFloat = 14 //12
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "photo_square_fill_flat")?.withRenderingMode(.alwaysOriginal).withTintColor(.tertiaryLabel)
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = profileImageCornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.accessibilityIgnoresInvertColors = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        heightConstraint.isActive = true
        heightConstraint.priority = UILayoutPriority(990)
        return imageView
    }()
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    var cellBackgroundColor: UIColor = .systemBackground
    let cellCornerRadius: CGFloat = 22
    let cellShadowOpacity: Float = 0.2
    
    var item: [String: String]? {
        didSet {
            if let item = item {
                let text = item["text"] ?? ""
                let username = item["username"] ?? ""
                let timestamp = item["timestamp"] ?? ""
                let profileImageName = item["profileImageName"] ?? ""
                let imageName = item["imageName"] ?? ""
                
                captionLabel.text = text
                usernamelLabel.text = username
                timestampLabel.text = timestamp
                profileImageView.image = UIImage(named: profileImageName)
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                    self.alpha = 0.6
                    self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
                }
            } else {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                    self.alpha = 1
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = self.cellBackgroundColor
        contentView.layer.cornerRadius = self.cellCornerRadius
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = self.cellShadowOpacity
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 10
        
        let usernameStack = UIStackView(arrangedSubviews: [
            usernamelLabel,
            UIView()
        ])
        usernameStack.axis = .horizontal
        usernameStack.spacing = 3
        usernameStack.alignment = .center
        
        let profileImageStack = UIStackView(arrangedSubviews: [
            profileImageView,
            usernameStack
        ])
        profileImageStack.axis = .horizontal
        profileImageStack.spacing = 5
        
        let leftStack = UIStackView(arrangedSubviews: [
            captionLabel,
            UIView(),
            profileImageStack
        ])
        leftStack.axis = .vertical
        leftStack.isLayoutMarginsRelativeArrangement = true
        leftStack.layoutMargins = .init(top: 5, left: 0, bottom: 5, right: 0)
        
        let timestampStack = UIStackView(arrangedSubviews: [
            timestampLabel
        ])
        timestampStack.isLayoutMarginsRelativeArrangement = true
        timestampStack.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 6)
        
        let rightStack = UIStackView(arrangedSubviews: [
            imageView,
            timestampStack
        ])
        rightStack.axis = .vertical
        rightStack.spacing = 5
        
        let mainStack = UIStackView(arrangedSubviews: [
            leftStack,
            UIView(),
            rightStack
        ])
        mainStack.axis = .horizontal
        mainStack.spacing = 6
        let mainStackLeftRightPadding: CGFloat = 12
        let mainStackTopBottomPadding: CGFloat = 10
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = .init(top: mainStackTopBottomPadding, left: mainStackLeftRightPadding, bottom: mainStackTopBottomPadding, right: mainStackLeftRightPadding)
        
        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cellBackgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .secondarySystemBackground : .systemBackground
        self.contentView.backgroundColor = self.cellBackgroundColor
        
        profileImageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
