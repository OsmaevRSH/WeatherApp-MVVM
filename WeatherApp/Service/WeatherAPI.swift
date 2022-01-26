//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Руслан Осмаев on 25.01.2022.
//

import Foundation
import Combine

class WeatherAPI {
	static let shared = WeatherAPI()
	let baseURL = "https://api.openweathermap.org/data/2.5/weather"
	let apiKey = "f79fcc0b3457d2c73dfbb3a5328ce8ff"
	
	private func getResultURL(city: String) -> URL? {
		guard let url = URL(string: baseURL) else { return nil }
		
		let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
		
		let qQuery = URLQueryItem(name: "q", value: city)
		let appidQuery = URLQueryItem(name: "appid", value: apiKey)
		let unitsQuery = URLQueryItem(name: "units", value: "metric")
		
		guard var urlComponents = urlComponents else { return nil }
		
		urlComponents.queryItems = [
			qQuery,
			appidQuery,
			unitsQuery
		]
		
		return urlComponents.url
	}
	
	func getWeather(city: String) -> AnyPublisher<WeatherModel, Never> {
		guard let url = getResultURL(city: city) else {
			return Just(WeatherModel.placeholder).eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: url)
			.map {$0.data}
			.decode(type: WeatherModel.self, decoder: JSONDecoder())
			.catch {error in Just(WeatherModel.placeholder)}
			.receive(on: RunLoop.main, options: nil)
			.eraseToAnyPublisher()
	}
}
