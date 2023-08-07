//
//  SnapKitMakeConstraintsRule.swift
//  SwiftLeakCheck
//
//  Copyright 2020 Grabtaxi Holdings PTE LTE (GRAB), All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be found in the LICENSE file
//
//  Created by Dimo Abdelaziz on 07/08/2023.
//

import Foundation
import SwiftSyntax


import SwiftSyntax

/// Rule to check if the closure used in SnapKit's `makeConstraints` is non-escapin

open class SnapKitMakeConstraintsRule: BaseNonEscapeRule {
    let signature = FunctionSignature(name: "makeConstraints", params: [
        FunctionParam(name: "closure", isClosure: true)
    ])

    open override func isNonEscape(arg: FunctionCallArgumentSyntax?,
                                   funcCallExpr: FunctionCallExprSyntax,
                                   graph: Graph) -> Bool {

        // Check if base is `UIView`, if not we can end early without checking any of the signatures
        guard funcCallExpr.match(.funcCall(namePredicate: { _ in true }, base: .name("ConstraintAttributesDSL"))) else {
            return false
        }

        // Now we can check each signature and ignore the base (already checked)
        if funcCallExpr.match(.funcCall(signature: signature, base: .any)) {
            return true
        }

        return false
    }
}
