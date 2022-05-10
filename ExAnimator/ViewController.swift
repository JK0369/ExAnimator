//
//  ViewController.swift
//  ExAnimator
//
//  Created by Jake.K on 2022/05/10.
//

import UIKit

class ViewController: UIViewController {
  private let redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let greenView: UIView = {
    let view = UIView()
    view.backgroundColor = .green
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let blueView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let slider: UISlider = {
    let slider = UISlider()
    slider.addTarget(self, action: #selector(didChangeSlide), for: .valueChanged)
    slider.translatesAutoresizingMaskIntoConstraints = false
    return slider
  }()
  
  var animator: UIViewPropertyAnimator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.slider)
    [self.redView, self.greenView, self.blueView]
      .forEach(self.view.addSubview(_:))
    
    NSLayoutConstraint.activate([
      self.slider.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.slider.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.slider.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
      self.slider.heightAnchor.constraint(equalToConstant: 30),
    ])
    NSLayoutConstraint.activate([
      self.redView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
      self.redView.heightAnchor.constraint(equalToConstant: 100),
      self.redView.widthAnchor.constraint(equalToConstant: 100),
      self.redView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    NSLayoutConstraint.activate([
      self.greenView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 320),
      self.greenView.heightAnchor.constraint(equalToConstant: 100),
      self.greenView.widthAnchor.constraint(equalToConstant: 100),
      self.greenView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    NSLayoutConstraint.activate([
      self.blueView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 520),
      self.blueView.heightAnchor.constraint(equalToConstant: 100),
      self.blueView.widthAnchor.constraint(equalToConstant: 100),
      self.blueView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    self.animator = UIViewPropertyAnimator(
      duration: 5,
      timingParameters: UICubicTimingParameters(animationCurve: .easeInOut)
    )
    
    self.animator?.addAnimations {
      UIView.animateKeyframes(
        withDuration: 0,
        delay: 0,
        animations: {
          UIView.addKeyframe(
            withRelativeStartTime: 0,
            relativeDuration: 0.3 / 1.0,
            animations: { self.redView.alpha = 0 }
          )
          UIView.addKeyframe(
            withRelativeStartTime: 0,
            relativeDuration: 0.6 / 1.0,
            animations: { self.greenView.alpha = 0 }
          )
          UIView.addKeyframe(
            withRelativeStartTime: 0.1 / 0.5,
            relativeDuration: 0.9 / 1.0,
            animations: { self.blueView.alpha = 0 }
          )
        }
      )
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.animator?.startAnimation()
  }
  
  @objc private func didChangeSlide() {
    self.animator?.fractionComplete = CGFloat(self.slider.value)
  }
}
