//
//  Model.swift
//  WeatherApp
//
//  Created by Руслан Осмаев on 25.01.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherModel = try? newJSONDecoder().decode(WeatherModel.self, from: jsonData)

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
	let coord: Coord?
	let weather: [Weather]?
	let base: String?
	let main: Main?
	let visibility: Int?
	let wind: Wind?
	let clouds: Clouds?
	let dt: Int?
	let sys: Sys?
	let timezone, id: Int?
	let name: String?
	let cod: Int?
	
	static var placeholder: Self {
		return WeatherModel(coord: nil,
							weather: nil,
							base: nil,
							main: nil,
							visibility: nil,
							wind: nil,
							clouds: nil,
							dt: nil,
							sys: nil,
							timezone: nil,
							id: nil,
							name: nil,
							cod: nil)
	}
}

// MARK: - Clouds
struct Clouds: Codable {
	let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
	let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
	let temp, feelsLike, tempMin, tempMax: Double?
	let pressure, humidity: Int?
	
	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure, humidity
	}
}

// MARK: - Sys
struct Sys: Codable {
	let type, id: Int?
	let message: Double?
	let country: String?
	let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
	let id: Int?
	let main, weatherDescription, icon: String?
	
	enum CodingKeys: String, CodingKey {
		case id, main
		case weatherDescription = "description"
		case icon
	}
}

// MARK: - Wind
struct Wind: Codable {
	let speed: Double?
	let deg: Int?
}
