//
//  ViewController.swift
//  AudioPlayerChallenge
//
//  Created by Ahmed T Khalil on 1/22/17.
//  Copyright © 2017 kalikans. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //instantiate player object
    var player = AVAudioPlayer()
    //instantiate timer object
    var timer = Timer()
    
    //volume level from second slider
    @IBOutlet var volumeLevel: UISlider!
    //audio playback point from first slider
    @IBOutlet var audioPlaybackPoint: UISlider!
    
    //play button
    @IBAction func play(_ sender: Any) {
        player.play()
    }
   
    //pause button
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
   
    //stop button
    @IBAction func stop(_ sender: Any) {
        player.pause()
        player.currentTime = 0
    }
    
    //change the volume
    @IBAction func volumeChanger(_ sender: Any) {
        player.volume = volumeLevel.value
    }
    
    //control playback point
    @IBAction func audioProgress(_ sender: Any) {
        //make the current playback point equal to a fraction of the total playback point (fraction is determined by slider value)
        player.currentTime = Double(audioPlaybackPoint.value)*player.duration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //slider is set to 0 when view loads
        audioPlaybackPoint.value = 0
        //create a scheduled timer
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateAudio), userInfo: nil, repeats: true)
        
        //audio file path
        let audioPath = Bundle.main.path(forResource: "ILikeBadHouseVersion", ofType: "mp3")
        
        //create a player for the audio file
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }catch{
            
        }
    }
    
    func updateAudio(){
        //so long as the slider value is less than 1 (song not finished), continually update the slider value by taking the fraction of song finisehd
        if audioPlaybackPoint.value < 1 {
            audioPlaybackPoint.value = Float(player.currentTime)/Float(player.duration)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

