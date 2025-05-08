//
//  ContentView.swift
//  WastedTime
//
//  Created by bazyl on 08/05/2025.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var counter: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text("Wasted Time")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .padding()
            Text("This is the time you wasted on this app")
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding()
            Spacer()
            Text("Time spent:")
                .font(.title)
                .foregroundColor(.accentColor)
                .padding()
            Spacer()
            
            Text(String(format: "%02d:%02d:%02d", counter / 3600, (counter % 3600) / 60, counter % 60))
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .foregroundColor(.accentColor)
                .padding()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    startTimer()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    stopTimer()
                }.onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
            Spacer()
            Button(action: {
                counter = 0
            }) {
                Text("Reset")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .background(.accent)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            Spacer()
            
            
        }
        .padding()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            counter += 1
        }
        UIApplication.shared.isIdleTimerDisabled = true
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ContentView()
}
