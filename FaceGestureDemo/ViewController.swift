//
//  ViewController.swift
//  FaceGestureDemo
//
//  Created by Amit Palo on 07/06/20.
//  Copyright © 2020 Amit Palo. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: FacialGestureCameraView!
    @IBOutlet weak var containerView: UIView!
    
    private var numberOfPages = 0
    private var currentPage = 0
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    func nextPageControl() {
        if currentPage < numberOfPages {
            currentPage = currentPage + 1
            tutorialPageViewController?.scrollToViewController(index: currentPage)
        }
    }
    
    func previousPageControl() {
        if currentPage > 0 {
            currentPage = currentPage - 1
            tutorialPageViewController?.scrollToViewController(index: currentPage)
        }
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
        showHUD(withText: "😌")
    }
    
    func smileDetected() {
        showHUD(withText: "😃")
    }
    
    func nodLeftDetected() {
        previousPageControl()
    }
    
    func nodRightDetected() {
        nextPageControl()
    }
    
    func leftEyeBlinkDetected() {
        showHUD(withText: "😉")
    }
    
    func rightEyeBlinkDetected() {
        showHUD(withText: "😜")
    }
    
}

extension ViewController {
    
    private func showHUD(withText text: String) {
        let hud = JGProgressHUD(style: .dark)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.font = UIFont.systemFont(ofSize: 100)
        hud.textLabel.text = text
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 0.1)
    }
}

extension ViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        currentPage = index
    }
    
}


