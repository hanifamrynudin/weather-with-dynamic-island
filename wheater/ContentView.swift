//
//  ContentView.swift
//  wheater
//
//  Created by Hanif Fadillah Amrynudin on 31/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = WeatherViewModel()
    
    @State var name: String = ""
    @State var nameSaved: String = ""
    
    
    var body: some View {
        
        
        ZStack{
            BackgroundColor()
            ScrollView {
                VStack{
                    TopBar(nameCity: $name, nameCitySaved: $nameSaved)
                    CityName(nameCity: $nameSaved)
                    WeatherImage()
                    WeatherDetail()
                    Spacer()
                }
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct GlassBackGround: View {
    
    let width: CGFloat
    let height: CGFloat
    let color: Color
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [.clear, color],
                           center: .center,
                           startRadius: 1,
                           endRadius: 100)
            .opacity(0.1)
            Rectangle().foregroundColor(color)
        }
        .opacity(0.2)
        .blur(radius: 2)
        .cornerRadius(25)
        .frame(width: width, height: height)
    }
}

struct BackgroundColor: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
            .edgesIgnoringSafeArea(.all)
    }
}

struct TopBar: View {
    
    @StateObject private var vm = WeatherViewModel()
    
    @Binding var nameCity: String
    @Binding var nameCitySaved: String
    
    
    var body: some View {
        HStack{
            Button(action: {
                saveName()
                nameCity = ""
                UIApplication.shared.endEditing()
            }) {
                Image(systemName: "location.north.circle")
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30.0)
            }
            
            TextField("Search", text: $nameCity)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .frame(height: 30.0)
                .foregroundColor(.gray)
                .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 2)
                )
                .onSubmit {
                    saveName()
                    vm.fetchWeather(CityName: nameCitySaved)
                    nameCity = ""
                }
                .submitLabel(.done)
            Button(action: {
                saveName()
                vm.fetchWeather(CityName: nameCitySaved)
                nameCity = ""
                UIApplication.shared.endEditing()
            }) {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30.0)
            }
        }
        .padding()
        
    }
    
    func saveName() {
        nameCitySaved = nameCity
    }
    
}

struct CityName: View {
    
    @Binding var nameCity: String
    
    
    var body: some View {
        VStack{
            Text("\(nameCity)")
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct WeatherImage: View {
    var body: some View {
        VStack{
            
            Image(systemName: weatherData.weatherImage)
                .renderingMode(.original)
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 160.0, height: 160.0)
            
        }
    }
}

struct WeatherDetail: View {
    
    @StateObject private var vm = WeatherViewModel()
    
    var body: some View {
        
        ZStack{
            GlassBackGround(width: 335.0, height: 300.0, color: .white)
            
            VStack (spacing: -15.0){
                HStack {
                    Text("Today, ")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                    Text(Date.now, format: .dateTime.day().month().year())
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                }
                Text("\(weatherData.temp)°")
                    .font(.system(size: 100, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.top)
                
                Text("Cloudy")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                HStack{
                    Image(systemName: "wind")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.0, height: 24.0)
                    
                    Text("Wind")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("|")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("\(weatherData.wind) Km/h")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                }
                
                HStack{
                    Image(systemName: "humidity")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.0, height: 24.0)
                    
                    Text("Hum")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("|")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("\(weatherData.hum) %     ")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct Weathers {
    let temp: String
    let weatherImage: String
    let main: String
    let wind: String
    let hum: String
}


let weatherData =  Weathers(temp: "28", weatherImage: "cloud.sun.fill", main: "Clouds", wind: "1.3", hum: "82")

