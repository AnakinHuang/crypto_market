//
//  SoundMgr.swift
//  Crypto Market
//
//  Created by Yuesong Huang on 12/12/22.
//

import Foundation
import SwiftUI
import AVFoundation

let filename = "coin_sound"
let type = "mp3"

class SoundManager: ObservableObject {
    @AppStorage("sound") var sound: Bool = true
    
    @Published var audioPlayer: AVAudioPlayer?
    
    func playSound() {
        if sound {
            if let path = Bundle.main.path(forResource: filename, ofType: type) {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.play()
                } catch {
                    print("Error file no found")
                }
            }
        }
    }
}
