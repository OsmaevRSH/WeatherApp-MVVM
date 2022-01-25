//
//  ViewController.swift
//  WeatherApp(MVVM+Combine+UIKit)
//
//  Created by Руслан Осмаев on 25.01.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

	private let viewModel = ViewModel()
	
	private var canceleble: Set<AnyCancellable> = []
	
	private let appNameTitle: UILabel = {
		var label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.clipsToBounds = true
		label.text = "Weather App"
		return label
	}()
	
	private lazy var cityTextField: UITextField = {
		var textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.clipsToBounds = true
		textField.placeholder = "City"
		textField.borderStyle = .roundedRect
		textField.text = viewModel.city
		textField.layer.borderColor = UIColor.black.cgColor
		return textField
	}()
	
	private lazy var tumpertureLabel: UILabel = {
		var label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.clipsToBounds = true
		label.text = "Температура ...ºC"
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubviews()
		addConstraints()
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}
	
	private func addSubviews() {
		view.addSubview(appNameTitle)
		view.addSubview(cityTextField)
		view.addSubview(tumpertureLabel)
	}
	
	private func binding() {
		cityTextField
			.textPublisher
			.assign(to: \.city, on: viewModel)
			.store(in: &canceleble)
		
		viewModel
			.$weather
			.sink { [weak self] weatherModel in
				self?.tumpertureLabel.text =
				weatherModel.main?.temp != nil ?
				("Температура \(weatherModel.main?.temp ?? -200) ºC") :
				"Error ...ºC"
			}
			.store(in: &canceleble)
	}
	
	private func addConstraints() {
		NSLayoutConstraint.activate([
			// MARK: - appNameTitle
			appNameTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			appNameTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
			appNameTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
			// MARK: - cityTextField
			cityTextField.topAnchor.constraint(equalTo: appNameTitle.bottomAnchor, constant: 16),
			cityTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
			cityTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
			// MARK: - tumpertureLabel
			tumpertureLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 16),
			tumpertureLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
			tumpertureLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
		])
	}
}

