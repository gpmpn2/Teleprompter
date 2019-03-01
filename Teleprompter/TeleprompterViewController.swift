//
//  ViewController.swift
//  Teleprompter
//
//  Created by Grant Maloney on 3/1/19.
//  Copyright © 2019 Grant Maloney. All rights reserved.
//

import UIKit

class TeleprompterViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var scrollView: UITextView!
    @IBAction func mirrorTeleprompter(_ sender: Any) {
        flipped = !flipped
        scrollView.transform = CGAffineTransform(scaleX: 1, y: flipped ? -1 : 1)
    }
    @IBAction func startTeleprompter(_ sender: Any) {
        if self.phase == .paused { //Correctly moves from paused to running again
            self.phase = .running
            return
        }
        
        resetOffsets()
        self.phase = .running
        timer?.invalidate() //Reset it so we dont have multiple timers running if we keep pausing and playing
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { timer in
            if self.phase == .paused { return }
            
            self.offset += 0.5
            
            if (self.offset > self.bottomOffset) {
                timer.invalidate()
                return
            }
            
            //This method makes more sense to me than the scrollRangeToVisible...
            self.scrollView.setContentOffset(CGPoint(x: 0, y: self.offset), animated: false)
        })
    }
    @IBAction func pauseTeleprompter(_ sender: Any) {
        self.phase = .paused
    }
    @IBAction func stopTeleprompter(_ sender: Any) {
        timer?.invalidate()
        self.phase = .stopped
        self.resetOffsets()
    }
    
    enum Phase {
        case running
        case paused
        case stopped
    }
    
    var phase: Phase = .stopped
    var offset: CGFloat = 0.0
    var bottomOffset: CGFloat = 0.0
    var timer: Timer?
    var flipped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        scrollView.text = "Welcome to mid morning news with your co anchor jim halpert. Today I am making filler information for a teleprompter so that we can test if it is properly functioning. I take up to twenty classes at once while in school and have no regrets.\n\nIn todays news a cat as flew a plane across the atlantic ocean and is planning to land in Spain. This is international news as this is the first time a cat has done something besides slept on a couch. This cat 'Jeremy' will when a nobel prize for its efforts.\n\nA turtle named george has just discovered the secret behind anti-matter and is attempting to send a space ship to a black hole. Will we ever discover if there is life on Mars, who knows. I only know that the poptart I made this morning has strawberry filling. Donuts are really tasty and my favorite are chocolate ones, those are the best. I went to the zoo and saw a tiger eat a deer the other day, I don't think the zookeepers are doing their jobs very well.\n\nWelcome to mid morning news with your co anchor jim halpert. Today I am making filler information for a teleprompter so that we can test if it is properly functioning. I take up to twenty classes at once while in school and have no regrets.\n\nIn todays news a cat as flew a plane across the atlantic ocean and is planning to land in Spain. This is international news as this is the first time a cat has done something besides slept on a couch. This cat 'Jeremy' will when a nobel prize for its efforts.\n\nA turtle named george has just discovered the secret behind anti-matter and is attempting to send a space ship to a black hole. Will we ever discover if there is life on Mars, who knows. I only know that the poptart I made this morning has strawberry filling. Donuts are really tasty and my favorite are chocolate ones, those are the best. I went to the zoo and saw a tiger eat a deer the other day, I don't think the zookeepers are doing their jobs very well.\n\nWelcome to mid morning news with your co anchor jim halpert. Today I am making filler information for a teleprompter so that we can test if it is properly functioning. I take up to twenty classes at once while in school and have no regrets.\n\nIn todays news a cat as flew a plane across the atlantic ocean and is planning to land in Spain. This is international news as this is the first time a cat has done something besides slept on a couch. This cat 'Jeremy' will when a nobel prize for its efforts.\n\nA turtle named george has just discovered the secret behind anti-matter and is attempting to send a space ship to a black hole. Will we ever discover if there is life on Mars, who knows. I only know that the poptart I made this morning has strawberry filling. Donuts are really tasty and my favorite are chocolate ones, those are the best. I went to the zoo and saw a tiger eat a deer the other day, I don't think the zookeepers are doing their jobs very well."
        
        DispatchQueue.main.async {
            self.resetOffsets()
            self.scrollView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset.y
    }
    
    func resetOffsets() {
        bottomOffset = scrollView.contentSize.height
        let height = scrollView.bounds.height
        offset = (height/2) * -1 //Make it go down to the middle of the screen
        scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
    }

}

