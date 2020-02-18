//
//  RatiwgBar.swift
//  Meu primeiro app
//
//  Created by Jonathan on 31/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

@IBDesignable class RatiwgBar: UIStackView {
    
    //MARK: inicialization
    private var ratingButtons = [UIButton]()
    
    var ratiwg = 0 {
    didSet {
    updateButtonSelectionStates()
    }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calcula a classificação do botão selecionado

        let selectedRating = index + 1
        
        if selectedRating == ratiwg {
            // Se a estrela selecionada representa a classificação atual, redefina a classificação para 0.
            ratiwg = 0
        } else {
            // Caso contrário, defina a classificação para a estrela selecionada
            ratiwg = selectedRating
        }
    }
   
    override init(frame: CGRect) {
         super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder : coder)
        setupButtons()
    }
    
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
        
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.accessibilityLabel = "Set \(index + 1) star rating"
        
            button.addTarget(self, action: #selector(RatiwgBar.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // Se o índice de um botão for menor que a classificação, esse botão deverá ser selecionado.
            button.isSelected = index < ratiwg
            
            // / Define a sequência de dicas para a estrela atualmente selecionada
            let hintString: String?
            if ratiwg == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calcular a cadeia de valor
            let valueString: String
            switch (ratiwg) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(ratiwg) stars set."
            }
            
            // Atribua a string de dica e a string de valor
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
    }
}
