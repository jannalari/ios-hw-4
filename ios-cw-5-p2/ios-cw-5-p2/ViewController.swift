//
//  ViewController.swift
//  ios-cw-5-p2
//
//  Created by party time on 6/27/20.
//  Copyright © 2020 jannacoded. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var buttons: [UIButton] = []
    var counter = 0
    var xCounter = 0
    var backgroundMusic: AVAudioPlayer?
    var popSound: AVAudioPlayer?
    var bubbleSound: AVAudioPlayer?
    var haptic = UINotificationFeedbackGenerator()
    var player: AVAudioPlayer = AVAudioPlayer()
    var winCounter = 0
    
    //backgroundmusic
    func playmusic(){
        let path = Bundle.main.path(forResource: "backgroundMusic.m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.play()
        } catch {
            // couldn't load file :(
        }
    }
    //popsound
    func playpopSound(){
        let path = Bundle.main.path(forResource: "popSound.m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            popSound = try AVAudioPlayer(contentsOf: url)
            popSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    //bubble sound
    func playbubbleSound(){
        let path = Bundle.main.path(forResource: "bubbleSound.m4a", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            bubbleSound = try AVAudioPlayer(contentsOf: url)
            bubbleSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playmusic()
        buttons = [b1, b2, b3, b4, b5, b6, b7, b8, b9]
    }
    
    // winning sound :)
    func playWinMusic(musicName: String, type: String, loop: Int = 0)
        {
            let AssortedMusics = URL(fileURLWithPath: Bundle.main.path(forResource: musicName, ofType: type)!)
            player = try! AVAudioPlayer(contentsOf: AssortedMusics)
            player.prepareToPlay()
            player.numberOfLoops = loop
            player.volume = 0.5
            player.play()
            
        }

    
     
    
    
    @IBAction func press(_ sender: UIButton) {
        print("تم الضغط علي")
        haptic.notificationOccurred(.success)
        print(counter)
        if counter % 2 == 0{
            playpopSound()
           sender.setTitle("X", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            turnLabel.text = "O turn"
            
       }
        else{
            playbubbleSound()
            sender.setTitle("O", for: .normal)
             sender.setTitleColor(.blue, for: .normal)
            turnLabel.text = "X turn"
        }
        counter += 1
        sender.isEnabled = false
        winning(winner: "X")
        winning(winner: "O")
     }
    
     
    @IBAction func resetTapped() {
        restartGame()
    }
    
    
    
    func winning(winner: String)
    {
        // winning
        if  (b1.titleLabel?.text == winner && b2.titleLabel?.text == winner && b3.titleLabel?.text == winner) || (b4.titleLabel?.text == winner && b5.titleLabel?.text == winner && b6.titleLabel?.text == winner) ||
            (b7.titleLabel?.text == winner && b8.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b4.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
            (b2.titleLabel?.text == winner && b5.titleLabel?.text == winner && b8.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b6.titleLabel?.text == winner && b7.titleLabel?.text == winner) ||
            (b1.titleLabel?.text == winner && b5.titleLabel?.text == winner && b9.titleLabel?.text == winner) ||
            (b3.titleLabel?.text == winner && b5.titleLabel?.text == winner && b7.titleLabel?.text == winner)
        {
            print("\(winner) الفائز 🎉")
            
            let alertController = UIAlertController(title: "\(winner)🎊🤩 فاز", message: "قم بالضغط على الزر التالي ليتم اعادة اللعب 😊 🤩", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "اعادة اللعب", style: .cancel) { (alert) in
                self.restartGame()
                self.playWinMusic(musicName: "epicWin", type:"m4a" )
            }
            alertController.addAction(restartAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    //  reset game :)
    func restartGame()
    {
        for b in buttons{
            b.setTitle("", for: .normal)
            b.titleLabel?.text = ""
            b.isEnabled = true

        }
        
                
        counter = 0
        turnLabel.text = "X turn"
    }
    
    
    
}



