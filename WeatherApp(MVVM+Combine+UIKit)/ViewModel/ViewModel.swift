//
//  ViewModel.swift
//  WeatherApp(MVVM+Combine+UIKit)
//
//  Created by Руслан Осмаев on 25.01.2022.
//

import Foundation
import Combine

final class ViewModel : ObservableObject {
	@Published var city = "Moscow"
	@Published var weather = WeatherModel.placeholder
	
	private var cancelableSet: Set<AnyCancellable> = []
	
	init() {
		$city
			.debounce(for: 0.3, scheduler: RunLoop.main, options: nil)
			.removeDuplicates()
			.flatMap {
				(city: String) -> AnyPublisher<WeatherModel, Never> in
				WeatherAPI.shared.getWeather(city: city)
				print("Call")
			}
			.assign(to: \.weather, on: self)
			.store(in: &cancelableSet)
	}
}
