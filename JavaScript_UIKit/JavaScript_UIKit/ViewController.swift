//
//  ViewController.swift
//  JavaScript_UIKit
//
//  Created by woosub kim  on 1/8/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    let button = UIButton(type: .system)
    let label = UILabel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
        setAttributes()
    }

    private func setAttributes() {
        button.setTitle("Button", for: .normal)
    button.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)

        label.text = "Label"
        label.font = UIFont.systemFont(ofSize: 20)
    }

    private func setContraints() {
        [button, label].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40),
        ])
    }

    // MARK: - Selectors
    @objc
    private func handleButton(_ sender: UIButton) {
        let vc = KakaoZipCodeVC()
        present(vc, animated: true)
    }
}


