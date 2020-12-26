//
//  SoundPlayer.swift
//  Gameathon
//
//  Created by Magy Elias on 12/26/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer{
    
    private static var player = AVAudioPlayer()
    
    static func playSound(soundName: String){
        
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")!
        
        do{
            try player = AVAudioPlayer(contentsOf: url)
        }
        catch let error{
            print(error.localizedDescription)
        }
        player.prepareToPlay()
        player.play()
        
    }
    
}
