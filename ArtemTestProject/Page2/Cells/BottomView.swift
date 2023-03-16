//
//  BottomView.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit

class BottomView: UIView {
    
    let quantityLabel = UILabel(text: "Quantity: 1", font: .montserratRegular(12), textColor: #colorLiteral(red: 0.5019204021, green: 0.5019834638, blue: 0.501899004, alpha: 1))
    let minusButton = UIButton(image: "minus", imageColor: .white, buttonColor: #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1))
    let plusButton = UIButton(image: "plus", imageColor: .white, buttonColor: #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1))
    
    let addToCartButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        let fontAttribute = [NSAttributedString.Key.font: UIFont.montserratBold(8) as Any]
        let nsString = NSAttributedString(string: "ADD TO CART", attributes: fontAttribute)
        button.configuration?.attributedTitle = AttributedString.init(nsString)
        button.configuration?.baseBackgroundColor = #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1)
        button.configuration?.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 20)
        button.contentHorizontalAlignment = .trailing
        
        return button
    }()
    
    let priceLabel = UILabel(font: .montserratMedium(10), textColor: #colorLiteral(red: 0.6564316011, green: 0.6818900268, blue: 1, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.09456076473, green: 0.08869554847, blue: 0.1493608952, alpha: 1)
        minusButton.layer.cornerRadius = 10
        plusButton.layer.cornerRadius = 10
        addToCartButton.clipsToBounds = true
        addToCartButton.layer.cornerRadius = 20
        setupConstraints()
    }
    
    func configure(with price: Double) {
        priceLabel.text = "$ \(price.formattedWithSeparator)"
    }
    
    func setupConstraints() {
        let stepperStack = UIStackView(arrangedSubviews: [minusButton, plusButton])
        stepperStack.axis = .horizontal
        stepperStack.spacing = 25
        stepperStack.distribution = .fill
        
        let vStack = UIStackView(arrangedSubviews: [quantityLabel, stepperStack])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 20
        
        let hStack = UIStackView(arrangedSubviews: [vStack, addToCartButton])
        hStack.distribution = .fillEqually
        hStack.axis = .horizontal
        hStack.spacing = 20
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.addSubview(priceLabel)
        priceLabel.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 20),
        ])
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            minusButton.widthAnchor.constraint(equalToConstant: 45),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - SwiftUI
import SwiftUI
struct DetailProvider2: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = UINavigationController(rootViewController: DetailViewController())
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
}
