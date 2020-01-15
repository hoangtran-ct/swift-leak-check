//
//  LeakDetection.swift
//  SwiftLeakCheck
//
//  Copyright 2020 Grabtaxi Holdings PTE LTE (GRAB), All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be found in the LICENSE file
//
//  Created by Hoang Le Pham on 27/10/2019.
//

import Foundation
import SwiftSyntax

open class Leak: CustomStringConvertible, Encodable {
  public let node: IdentifierExprSyntax
  public let capturedNode: ExprSyntax?
  
  open var line: Int {
    return node.positionAfterSkippingLeadingTrivia.line
  }
  
  public init(node: IdentifierExprSyntax, capturedNode: ExprSyntax?) {
    self.node = node
    self.capturedNode = capturedNode
  }
  
  private enum CodingKeys: CodingKey {
    case line
    case column
    case reason
  }
  
  open func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(node.positionAfterSkippingLeadingTrivia.line, forKey: .line)
    try container.encode(node.positionAfterSkippingLeadingTrivia.column, forKey: .column)
    
    let reason: String = {
      return "`self` is strongly captured here, from a potentially escaped closure."
    }()
    try container.encode(reason, forKey: .reason)
  }
  
  open var description: String {
    return """
      `self` is strongly captured at \(node.positionAfterSkippingLeadingTrivia.prettyDescription),
      from a potentially escaped closure.
    """
  }
}
