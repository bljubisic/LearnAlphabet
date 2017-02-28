//
//  ViewControllerProtocol.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/15/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation

protocol ViewControllerProtocol: class {
    
    var viewModel: ProfileViewModelProtocol? { get }
    
    func bindTo(viewModel localViewModel: ViewModelProtocol)
    
}
