//
//  WheaterStatus.swift
//  WheaterStatus
//
//  Created by Hanif Fadillah Amrynudin on 20/09/22.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct WheaterStatus: Widget {
    
    @StateObject private var vm = WeatherViewModel()
    @StateObject var locationManager = LocationManager()
    
    var body: some WidgetConfiguration{
        ActivityConfiguration(for: WheaterAttributes.self) {context in
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("Blue").gradient)
                VStack{
                    HStack{
                        Image(systemName: context.state.conditionName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48, height: 48)
                            .padding()
                        VStack{
                            Text(context.state.temperatureString)
                                .font(.system(size: 24, weight: .medium, design: .default))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
    
                            Text(context.state.desc)
                                .font(.system(size: 18, weight: .light, design: .default))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            print("Pressed")
                            locationManager.requestLocation()
                            if let location = locationManager.location {
                                vm.fetchWeather(latitude: location.latitude, longitude: location.longitude)
                            }
                        }) {
                            Image(systemName: "location.north.circle")
                                .resizable()
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30.0, height: 30.0)
                                .padding()
                        }
                    }
                    HStack(alignment: .top, spacing: 0){
                        VStack(alignment: .leading, spacing: 4) {
                            Text(context.state.nameCity)
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(.white)
                            Text(Date.now, format: .dateTime.day().month().year())
                                .font(.system(size: 14, weight: .light, design: .default))
                                .foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            HStack{
                                Image(systemName: "wind")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.0, height: 20.0)

                                Text("Wind")
                                    .font(.system(size: 18, weight: .light, design: .default))
                                    .foregroundColor(.white)

                                Text("|")
                                    .font(.system(size: 18, weight: .light, design: .default))
                                    .foregroundColor(.white)

                                Text(context.state.windString)
                                    .font(.system(size: 18, weight: .light, design: .default))
                                    .foregroundColor(.white)
                            }

                            HStack{
                                Image(systemName: "humidity")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.0, height: 20.0)

                                Text("Hum")
                                    .font(.system(size: 18, weight: .light, design: .default))
                                    .foregroundColor(.white)

                                Text(" |")
                                    .font(.system(size: 18, weight: .light, design: .default))
                                    .foregroundColor(.white)

                                Text(context.state.humidityString)
                                    .font(.system(size: 18, weight: .light, design: .default))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.leading, 15)
                        .padding(.trailing, -10)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottom)
                }
                
                .padding(15)
            }
        }
        dynamicIsland: { context in
            DynamicIsland{
                DynamicIslandExpandedRegion(.leading) {
                    HStack{
                        Image(systemName: context.state.conditionName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48, height: 48)
                            .padding()
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Button(action: {
                        print("Pressed")
                        locationManager.requestLocation()
                        if let location = locationManager.location {
                            vm.fetchWeather(latitude: location.latitude, longitude: location.longitude)
                        }
                    }) {
                        Image(systemName: "location.north.circle")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30.0, height: 30.0)
                            .padding()
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                HStack(alignment: .top, spacing: 0){
                    VStack(alignment: .leading, spacing: 4) {
                        Text(context.state.nameCity)
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        Text(Date.now, format: .dateTime.day().month().year())
                            .font(.system(size: 14, weight: .light, design: .default))
                            .foregroundColor(.white)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        HStack{
                            Image(systemName: "wind")
                                .resizable()
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.0, height: 20.0)

                            Text("Wind")
                                .font(.system(size: 18, weight: .light, design: .default))
                                .foregroundColor(.white)

                            Text("|")
                                .font(.system(size: 18, weight: .light, design: .default))
                                .foregroundColor(.white)

                            Text(context.state.windString)
                                .font(.system(size: 18, weight: .light, design: .default))
                                .foregroundColor(.white)
                        }

                        HStack{
                            Image(systemName: "humidity")
                                .resizable()
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.0, height: 20.0)

                            Text("Hum")
                                .font(.system(size: 18, weight: .light, design: .default))
                                .foregroundColor(.white)

                            Text(" |")
                                .font(.system(size: 18, weight: .light, design: .default))
                                .foregroundColor(.white)

                            Text(context.state.humidityString)
                                .font(.system(size: 18, weight: .light, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 15)
                    .padding(.trailing, -10)
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    VStack{
                        Text(context.state.temperatureString)
                            .font(.system(size: 24, weight: .medium, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)

                        Text(context.state.desc)
                            .font(.system(size: 18, weight: .light, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                    }
                }
                } compactLeading: {
                    Image(systemName: context.state.conditionName)
                        .font(.title3)
                } compactTrailing: {
                    Text(context.state.temperatureString)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                }
                minimal: {
                    Image(systemName: context.state.conditionName)
                        .font(.title3)
            }
        }
    }
}
