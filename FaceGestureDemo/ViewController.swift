//
//  ViewController.swift
//  FaceGestureDemo
//
//  Created by Amit Palo on 07/06/20.
//  Copyright © 2020 Amit Palo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: FacialGestureCameraView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addCameraViewDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGestureDetection()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopGestureDetection()
    }
    
}

extension ViewController {
    
    func addCameraViewDelegate() {
        cameraView.delegate = self
    }
    
    func startGestureDetection() {
        cameraView.beginSession()
    }
    
    func stopGestureDetection() {
        cameraView.stopSession()
    }
    
}

extension ViewController: FacialGestureCameraViewDelegate {
   
    func doubleEyeBlinkDetected() {
        print("Double Eye Blink Detected")
    }

    func smileDetected() {
        print("Smile Detected")
    }

    func nodLeftDetected() {
        print("Nod Left Detected")
    }

    func nodRightDetected() {
        print("Nod Right Detected")
    }

    func leftEyeBlinkDetected() {
        print("Left Eye Blink Detected")
    }

    func rightEyeBlinkDetected() {
        print("Right Eye Blink Detected")
    }
    
}

