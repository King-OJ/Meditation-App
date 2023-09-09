//
//  ContentView.swift
//  Meditation App
//
//  Created by Clem OJ on 09/09/2023.
//

import SwiftUI

struct ContentView: View {

    @State private var isTimerRunning = false
    @State private var showTime = false
    @State private var remainingTime = TimeInterval(600)
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        ZStack {
            VStack {
                if showTime {
                    Text(timeString(time: remainingTime))
                        .bold()
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                } else {
                    Text("10 Minute Meditation Session")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                }
                    HStack{
                        Button {
                            
                            isTimerRunning = false
                            showTime = false
                            remainingTime = TimeInterval(600)
                        } label: {
                            Circle()
                                .frame(width: 85, height: 85)
                                .foregroundColor(.gray)
                                .overlay {
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.title3)
                                }
                        }
                        
                        Spacer()
                        
                        Button {
                            showTime = true
                            isTimerRunning.toggle()
                        } label: {
                            Circle()
                                .frame(width: 80, height: 80)
                                .foregroundColor( isTimerRunning ? .orange : .green)
                                .overlay {
                                    Text(
                                        showTime ?
                                        isTimerRunning ? "Pause" : "Resume"
                                        : "Start")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.title3)
                                }
                        }
                        

                    }
                    .padding(.horizontal)
            
            }.onReceive(timer){
                _ in
                if isTimerRunning {
                    remainingTime = remainingTime - 1
                    
                    if remainingTime == 0 {
                        showTime = false
                        isTimerRunning = false
                        remainingTime = TimeInterval(600)
                        
                    }
                }
            }
            
        }.padding()
        .frame(maxWidth: 350, maxHeight: 400)
        .overlay{
            Circle()
                .trim(from: 0, to: progressLevel()/100)
                .stroke(.green, lineWidth: 10)
                .rotationEffect(.degrees(-90))
        }
        
       
        
       
    }
    
    func timeString(time:TimeInterval)->String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d",minutes, seconds)
    }
    
    func progressLevel()->Double {
       let progress = Double((remainingTime * 100) / 600)
        return progress
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
