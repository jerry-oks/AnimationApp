//
//  ViewController.swift
//  AnimationApp
//
//  Created by HOLY NADRUGANTIX on 05.09.2023.
//

import UIKit
import SpringAnimation

final class ViewController: UIViewController {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var animationView: SpringView!
    
    @IBOutlet private var presetNameLabel: UILabel!
    @IBOutlet private var curveNameLabel: UILabel!
    
    @IBOutlet private var forceValueLabel: UILabel!
    @IBOutlet private var delayValueLabel: UILabel!
    @IBOutlet private var durationValueLabel: UILabel!
    
    @IBOutlet private var progressView: UIView!
    @IBOutlet private var durationProgressView: UIView!
    
    @IBOutlet private var delayStatusView: UIView!
    @IBOutlet private var durationStatusView: UIView!
    
    @IBOutlet private var repeatButton: UIButton!
    @IBOutlet private var playNextButton: UIButton!
    
    private var currentAnimation: Animation!
    private var nextAnimation: Animation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
        
        containerView.layer.shadowColor = UIColor.label.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSizeZero
        containerView.layer.shadowRadius = 6
    }
    
    override func viewWillLayoutSubviews() {
        delayStatusView.layer.cornerRadius = delayStatusView.frame.height / 2
        durationStatusView.layer.cornerRadius = durationStatusView.frame.height / 2
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case " Play first":
            repeatButton.isEnabled.toggle()
            nextAnimation = Animation.getRandom()
            fallthrough
        case .some(_):
            currentAnimation = nextAnimation
            nextAnimation = Animation.getRandom()
            playNextButton.setTitle(" Play next (\(nextAnimation.preset))", for: .normal)
            setupInterface()
            fallthrough
        default:
            resetInterface()
            startCoreAnimation()
            startSpringAnimation()
        }
    }
}

private extension ViewController {
    func setupInterface(animated: Bool = true) {
        durationProgressView.frame.origin.x =
        view.frame.maxX
        * currentAnimation.delay
        / (currentAnimation.delay + currentAnimation.duration)
        
        UIView.transition(
            with: view,
            duration: animated ? 0.15 : 0,
            options: [.transitionCrossDissolve]) { [unowned self] in
                presetNameLabel.text = currentAnimation.preset
                curveNameLabel.text = currentAnimation.curve
                forceValueLabel.text = currentAnimation.force.string()
                delayValueLabel.text = currentAnimation.delay.string()
                durationValueLabel.text = currentAnimation.duration.string()
            }
    }
    
    func resetInterface() {
        progressView.frame.origin.x = 0
        
        delayStatusView.backgroundColor = .systemFill
        durationStatusView.backgroundColor = .systemFill
    }
    
    func startCoreAnimation() {
        delayStatusView.backgroundColor = .systemYellow
        
        UIView.animate(
            withDuration: currentAnimation.delay + currentAnimation.duration,
            delay: 0,
            options: [.curveLinear]
        ) { [unowned self] in
            progressView.frame.origin.x += view.frame.maxX
        }
        
        UIView.animate(
            withDuration: 0,
            delay: currentAnimation.delay,
            options: []
        ) { [unowned self] in
            delayStatusView.backgroundColor = .systemGreen
        } completion: { [unowned self] _ in
            durationStatusView.backgroundColor = .systemYellow
            
            UIView.animate(
                withDuration: 0,
                delay: currentAnimation.duration,
                options: []
            ) { [unowned self] in
                durationStatusView.backgroundColor = .systemGreen
            }
        }
    }
    
    func startSpringAnimation() {
        animationView.animation = currentAnimation.preset
        animationView.curve = currentAnimation.curve
        animationView.force = currentAnimation.force
        animationView.delay = currentAnimation.delay
        animationView.duration = currentAnimation.duration
        animationView.animate()
    }
}

extension Double {
    func string() -> String {
        String(format: "%.2f", self)
    }
}
