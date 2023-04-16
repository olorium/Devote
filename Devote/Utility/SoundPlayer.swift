//
//  SoundPlayer.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 16.04.2023.
//

import Foundation
import AVFoundation

final class Player {
	/// Audio Player.
	private var audioPlayer: AVAudioPlayer?
	
	let shared = Player()
	
	func playSound(sound: String, type: String) {
		if let path = Bundle.main.path(forResource: sound, ofType: type) {
			do {
				audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
				audioPlayer?.play()
			} catch {
				print("Error playing audio file")
			}
		}
	}
}
