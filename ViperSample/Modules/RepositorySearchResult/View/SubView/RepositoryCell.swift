//
//  RepositoryCell.swift
//  viper-sample
//
//  Created by hicka04 on 2018/07/27.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell, NibRegistrable {

    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var starCoutLabel: UILabel!
    
    func setRepository(_ repository: RepositoryEntity) {
        repositoryNameLabel.text = repository.fullName
        starCoutLabel.text = "\(repository.starCount)"
    }
}
