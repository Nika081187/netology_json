//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var showAlertButton: UIButton = {
        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle("Add post", for: .normal)
        showAlertButton.setTitleColor(.red, for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlertPressed), for:.touchUpInside)
        showAlertButton.toAutoLayout()
        return showAlertButton
    }()
    
    private lazy var todoLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var tatooineLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private var todoLabelText: String?
    private var tatooineLabelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(showAlertButton)

        NetworkService.dataTask(config: .todo) { [self] string in
            if let result = string {
                print("todo: \(result)")
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(TodoModel.self, from: result.data(using: .utf8)!)
                    print("object: \(responseObject)")
                    todoLabelText = responseObject.title
                    print("labelText of todo: \(String(describing: self.todoLabelText))")
                } catch {
                    print(error)
                }
            }
        }
        
        NetworkService.dataTask(config: .planet) { [self] string in
            if let result = string {
                print("planet: \(result)")
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(PlanetModel.self, from: result.data(using: .utf8)!)
                    print("object: \(responseObject)")
                    tatooineLabelText = responseObject.orbital_period
                    print("labelText of Tatooine: \(String(describing: self.tatooineLabel))")
                } catch {
                    print(error)
                }
            }
        }
        
        view.addSubview(todoLabel)
        view.addSubview(tatooineLabel)
        NSLayoutConstraint.activate([
            
            showAlertButton.heightAnchor.constraint(equalToConstant: 50),
            showAlertButton.widthAnchor.constraint(equalToConstant: 100),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            todoLabel.heightAnchor.constraint(equalToConstant: 100),
            todoLabel.widthAnchor.constraint(equalToConstant: 300),
            todoLabel.centerYAnchor.constraint(equalTo: showAlertButton.centerYAnchor, constant: -100),
            todoLabel.centerXAnchor.constraint(equalTo: showAlertButton.centerXAnchor),
            
            tatooineLabel.heightAnchor.constraint(equalToConstant: 100),
            tatooineLabel.widthAnchor.constraint(equalToConstant: 300),
            tatooineLabel.centerYAnchor.constraint(equalTo: todoLabel.centerYAnchor, constant: -100),
            tatooineLabel.centerXAnchor.constraint(equalTo: todoLabel.centerXAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let todo = todoLabelText, let tatooine = tatooineLabelText {
            todoLabel.text = "todo title: \(todo)"
            tatooineLabel.text = "orbital period of Tatooine: \(tatooine)"
        }
    }
    
    @objc func showAlertPressed(){
        showAlert()
    }
    
    @IBAction func showAlert() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
