//
//  WeatherManager.swift
//  wheater
//
//  Created by Hanif Fadillah Amrynudin on 01/09/22.
//

import Foundation
import CoreLocation

class WeatherViewModel : ObservableObject {
    
    @Published var weatherViewModel = [WeatherModel]()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a1faa9b0d55de0551810719a5bca6491&units=metric"
    
    func fetchWeather(CityName: String) {
        let urlString = "\(weatherURL)&q=\(CityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        DispatchQueue.main.async {
            
            if let url = URL(string: urlString) {
                
                //2. Create a URLSession
                let session = URLSession(configuration: .default)
                
                //3. Give the session a task
                let task = session.dataTask(with: url, completionHandler: self.handle(data:response:err:))
                
                // 4. Start the task
                task.resume()
            }
        }
    }
    
    func handle(data: Data?, response: URLResponse?, err: Error?) {
        if err != nil {
            return
        }
        
        if let safeData = data {
            parseJSON(safeData)
        }
    }
    
    func parseJSON(_ wheaterData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: wheaterData)
            
            let name = decodedData.name
            let speedWind = decodedData.wind.speed
            let temp = decodedData.main.temp
            let hum = decodedData.main.humidity
            let id = decodedData.weather[0].id
            let desc = decodedData.weather[0].main
            
            let weather = WeatherModel(conditionId: id, nameCity: name, wind: speedWind, temp: temp, hum: hum, desc: desc)
            
            DispatchQueue.main.async {
                self.weatherViewModel.append(weather)
            }
            
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
}
