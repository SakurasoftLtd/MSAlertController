//
//  CustomTheme.swift
//  MSAlertController
//
//  Created by Jacob King on 22/02/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import MSAlertController

class CustomTheme: MSAlertControllerTheme {
    
    override init() {
        super.init()
        titleFont = UIFont(name: "Futura-Medium", size: 20)!
        bodyFont = UIFont(name: "Futura-Medium", size: 13)!
        buttonFont = UIFont(name: "Futura-Medium", size: 18)!
        titleTextColor = .black
        titleTextAlignment = .center
        bodyTextAlignment = .center
        bodyTextColor = UIColor(red: 121/255, green: 118/255, blue: 118/255, alpha: 1)
        standardButtonTextColor = UIColor(red: 66/255, green: 134/255, blue: 35/255, alpha: 1)
        alertCornerRadius = 4
    }
}
