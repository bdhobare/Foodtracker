//
//  RatingControl.swift
//  FoodTracker
//
//  Created by miles on 19/12/2016.
//  Copyright © 2016 deveint. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
//MARK: Properties
    private var ratingbuttons=[UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var startCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
//MARK: Button Action
    func ratingButtonTapped(button:UIButton){
        guard let index = ratingbuttons.index(of: button) else {
            fatalError("The button,\(button), is not in the ratingButtons array:\(ratingbuttons)")
            
        }
        //calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //If the selected star represents the current rating,reset the rating to 0
            rating = 0
        } else {
            //Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
//MARK: Private methods
    private func setupButtons(){
        // clear any existing buttons
        for button in ratingbuttons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingbuttons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for index in 0..<startCount {
            //create the button
            let button=UIButton()
            //Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints=false
            button.heightAnchor.constraint(equalToConstant:starSize.height).isActive=true
            button.widthAnchor.constraint(equalToConstant:starSize.width).isActive=true
            //Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            
            
            //Set up the button action
            button.addTarget(self,action:#selector(RatingControl.ratingButtonTapped(button:)),for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            //Add the new button to the rating button array
            ratingbuttons.append(button)
        }
        updateButtonSelectionStates()
    }
    private func updateButtonSelectionStates(){
        for (index, button) in ratingbuttons.enumerated(){
            //If the index of a button is less than the rating ,that button should be selected
            button.isSelected = index < rating
            
            //Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            //Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set"
            }
            
            //Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
