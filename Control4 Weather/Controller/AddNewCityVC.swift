//
//  AddNewCityVC.swift
//  Control4 Weather
//
//  Created by Tim on 8/30/20.
//  Copyright © 2020 Tim. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol newCityAddedDelegate {
    func addNewCity(city: String)
}

class AddNewCityVC: UIViewController {

    // MARK: - Properties
    var delegate: newCityAddedDelegate?
    // MARK: - Outlets
    @IBOutlet weak var cityTextField: UITextField!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: - Actions
    
    @IBAction func newCityButton(_ sender: Any) {
        guard let city = cityTextField.text else { return }
        self.delegate?.addNewCity(city: city)
        dismiss(animated: true, completion: nil)
    }
    
}
