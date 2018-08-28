//
//  ViewController.swift
//  Sunset
//
//  Created by Kevin Lima on 26-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let sun = Sun()
	
    @IBOutlet weak var sunLabel: UILabel!
    
    override func viewDidLoad() {
		super.viewDidLoad()
        
        // Double tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        self.spinSunLabel()
	}
    func spinSunLabel(){
        UIView.animate(withDuration: 1) {
            self.sunLabel.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1)
        }
    }
    
    @IBAction func infoButton(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "InformationViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func doubleTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("doubleTapped"), object: nil)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake{
            print("shaked")
            NotificationCenter.default.post(name: NSNotification.Name("shaked"), object: nil)
        }
    }
}

