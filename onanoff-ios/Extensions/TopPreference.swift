//
//  TopPreference.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 08/08/2023.
//

import Foundation

import SwiftUI

enum DizygoticEnum : String {
    case None,Dizygotic,MonoDizygotic
}

struct TopPreference {
	let id: UUID
	let parent: Node?
	let top: Anchor<CGPoint>
    let dizygotic: DizygoticEnum
}

struct TopPreferenceKey: PreferenceKey {
	typealias Value = [TopPreference]
	
	static var defaultValue: Value = []
	
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value.append(contentsOf: nextValue())
	}
}


struct BottomPreference {
	let id: UUID
	let parent: Node?
	let top: Anchor<CGPoint>
}


struct BottomPreferenceKey: PreferenceKey {
	typealias Value = [BottomPreference]
	
	static var defaultValue: Value = []
	
	static func reduce(value: inout Value, nextValue: () -> Value) {
		value.append(contentsOf: nextValue())
	}
}
