//
//  WeatherDetailVC.swift
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cityChosenLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var hiTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var chanceOfPrecipitationLabel: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    // MARK: - Properties
    let cities = ["San Francisco", "New York", "Salt Lake City"]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFeedRequest()
    }
    
    // MARK: - Functions
    func makeFeedRequest() {
        guard let cityChosen = self.cityChosenLabel.text else { return }
        let cityChosenShortened = cityChosen.replacingOccurrences(of: " ", with: "%20")
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityChosenShortened)&appid=da65fafb6cb9242168b7724fb5ab75e7"
        let endPoint = URL(string: baseURL)
        guard let url = endPoint else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                debugPrint("Server error")
                return
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let weatherInfo = try decoder.decode(Root.self, from: data)
                
                let myIconURL = "http://openweathermap.org/img/w/\(weatherInfo.weather[0].icon).png"
                let url = URL(string: myIconURL)
                self.getImageData(from: url!) { (data, response, error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        debugPrint("Server error")
                        return
                    }
                    
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.weatherIcon.image = UIImage(data: data)
                    }
                }
                DispatchQueue.main.async {
                    self.temperatureLabel.text = self.convertIntoFahrenheit(temp: weatherInfo.main.temp)
                    self.hiTemperatureLabel.text = self.convertIntoFahrenheit(temp: weatherInfo.main.tempMax)
                    self.lowTemperatureLabel.text = self.convertIntoFahrenheit(temp: weatherInfo.main.tempMin)
                    self.chanceOfPrecipitationLabel.text = weatherInfo.weather[0].description
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func convertIntoFahrenheit(temp: Float) -> String {
        return String(format: "%.0f", (temp - 273.15) * 1.8 + 32) + "\u{00B0}"
    }
}


extension WeatherDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Picker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cityChosenLabel.text = self.cities[row]
        makeFeedRequest()
    }
}
