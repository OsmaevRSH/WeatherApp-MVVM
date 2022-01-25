//
//  TextFieldExtention.swift
//  WeatherApp(MVVM+Combine+UIKit)
//
//  Created by Руслан Осмаев on 25.01.2022.
//

import Foundation
import UIKit
import Combine

extension UITextField {
	var textPublisher: AnyPublisher<String, Never> {
		NotificationCenter
			.default
			.publisher(for: UITextField.textDidChangeNotification, object: self)
			.compactMap {$0.object as? UITextField}
			.map {$0.text ?? ""}
			.eraseToAnyPublisher()
	}
}
