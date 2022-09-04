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
                    Screen(nameCity: $name, nameCitySaved: $nameSaved)
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

struct Screen: View {
    
    @StateObject private var vm = WeatherViewModel()
    @StateObject var locationManager = LocationManager()
    
    @Binding var nameCity: String
    @Binding var nameCitySaved: String
    
    
    var body: some View {
        HStack{
            Button(action: {
                saveName()
                if let location = locationManager.location {
                    vm.fetchWeather(latitude: location.latitude, longitude: location.longitude)
                }
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
        
        VStack{
            Text(vm.weatherViewModel.last?.nameCity ?? "City")
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
        
        VStack{
            
            Image(systemName: vm.weatherViewModel.last?.conditionName ??  "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 160.0, height: 160.0)
                .padding()
            
        }
        
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
                Text(vm.weatherViewModel.last?.temperatureString ?? "28")
                    .font(.system(size: 100, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.top)
                
                Text(vm.weatherViewModel.last?.desc ?? "Cloudy")
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
                    
                    Text(vm.weatherViewModel.last?.windString ?? "10.8")
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
                    
                    Text(" |")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text(vm.weatherViewModel.last?.humidityString ?? "60")
                        .font(.system(size: 18, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
        }
        .onAppear{
            if let location = locationManager.location {
                vm.fetchWeather(latitude: location.latitude, longitude: location.longitude)
            }
        }
    }
    
    func saveName() {
        nameCitySaved = nameCity
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
