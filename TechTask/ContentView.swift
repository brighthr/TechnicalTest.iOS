//  Copyright © 2025 BrightHR. All rights reserved.

import SwiftUI

struct LegacyWeather: Codable {
    let temp: Double
    let wind: Double
    let time: String
}

private struct RawResponse: Codable {
    struct Current: Codable { let temperature: Double; let windspeed: Double; let time: String }
    let current_weather: Current
}

struct ContentView: View {
    @State private var temperature: String = "--"
    @State private var wind: String = "--"
    @State private var lastUpdated: String = "--"
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

   
    @State private var latitude: String = "51.5072"
    @State private var longitude: String = "-0.1276"

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                    TextField("lat", text: $latitude)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    TextField("lon", text: $longitude)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    Button("Refresh") { fetch() }
                        .disabled(isLoading)
                }

                if isLoading { ProgressView().padding(.top) }
                if let msg = errorMessage { Text(msg).foregroundColor(.red) }

                VStack {
                    Text("Temperature: \(temperature)℃")
                    Text("Wind: \(wind) m/s")
                    Text("Updated: \(lastUpdated)")
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("WeatherNow (Legacy)")
            .onAppear {
                if temperature == "--" { fetch() }
            }
        }
    }

    func fetch() {
        errorMessage = nil
        isLoading = true

        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { data, response, err in
            
            Thread.sleep(forTimeInterval: 0.7)

            if let err = err {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = err.localizedDescription
                }
                return
            }

            let http = response as? HTTPURLResponse
            if http?.statusCode != 200 {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Bad status: \(http?.statusCode ?? -1)"
                }
                return
            }

            let raw = try! JSONDecoder().decode(RawResponse.self, from: data!)
            let legacy = LegacyWeather(temp: raw.current_weather.temperature, wind: raw.current_weather.windspeed, time: raw.current_weather.time)

            DispatchQueue.main.async {
                self.temperature = String(format: "%.1f", legacy.temp)
                self.wind = String(format: "%.1f", legacy.wind)
                self.lastUpdated = legacy.time
                self.isLoading = false
            }
        }.resume()
    }
}

