//
//  Cache.swift
//  Astronomy
//
//  Created by Percy Ngan on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {

	// A place for items to be cached
	private var cache = [Key: Value]() // making an instance of a cache, but it is empty to store something.
	// This is the serial queue so that everyone can use shared resources without using NSLock
	private var queue = DispatchQueue(label: "com.LambdaSchool.Astronomy.ConcurrentOperationStateQueue") // This is a serial queue

	// Have a function to add items to the cache
	func cache(value: Value, key: Key) {
		queue.async {
			self.cache[key] = value
		}
	}

	// Have a fucntion to return items that are cached
	func value(key: Key) -> Value? {
		return queue.sync { // this is done sync because it may need the value to be cached before it can return that value in from the cache. It has to wait for another operation to finish before it can start.
			cache[key]
		}
	}
}
