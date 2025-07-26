//
//  SoundManager.swift
//  TheMillionaireGame
//
//  Created by Chingiz on 26.07.2025.
//

import AVFoundation
import Combine

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    private init() {
        preloadSounds()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }
    
    private func preloadSounds() {
        let sounds = [
            "clockTicking",
            "correctAnswer",
            "wrongAnswer",
            "acceptedAnswer",
            "millionaire"
        ]
        
        for sound in sounds {
            guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
                print("Sound file not found: \(sound)")
                continue
            }
            
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                audioPlayers[sound] = player
            } catch {
                print("Error loading sound: \(sound) - \(error)")
            }
        }
    }
    
    func playSound(_ name: String, loop: Bool = false) {
        guard let player = audioPlayers[name] else {
            print("Sound not found: \(name)")
            return
        }
        
        if player.isPlaying {
            player.stop()
        }
        
        player.currentTime = 0
        player.numberOfLoops = loop ? -1 : 0
        player.play()
    }
    
    func stopSound(_ name: String) {
        guard let player = audioPlayers[name], player.isPlaying else { return }
        player.stop()
    }
    
    func stopAllSounds() {
        audioPlayers.values.forEach { player in
            if player.isPlaying {
                player.stop()
            }
        }
    }
}
