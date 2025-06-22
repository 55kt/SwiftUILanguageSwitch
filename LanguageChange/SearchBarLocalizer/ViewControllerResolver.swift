//
//  ViewControllerResolver.swift
//  LanguageChange
//
//  Created by Vlad on 22/6/25.
//

import SwiftUI

/// A SwiftUI wrapper that allows resolving the underlying `UIViewController`.
struct ViewControllerResolver: UIViewControllerRepresentable {
    /// Callback triggered when the view controller is resolved.
    let onResolve: (UIViewController) -> Void
    
    func makeUIViewController(context: Context) -> ParentResolverViewController {
        // Create and return the custom UIViewController that performs the resolution.
        ParentResolverViewController(onResolve: onResolve)
    }
    
    func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context) {
        // No update logic required.
    }
}

/// A UIViewController that attempts to find the most relevant parent UIViewController
/// (e.g., a top view controller in a UINavigationController).
class ParentResolverViewController: UIViewController {
    /// Closure to call once the target UIViewController is resolved.
    let onResolve: (UIViewController) -> Void
    
    /// Prevents multiple resolutions.
    private var isResolved = false
    
    /// Designated initializer accepting a resolution closure.
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Required initializer when decoding from a storyboard or XIB (not used in practice).
    required init?(coder: NSCoder) {
        self.onResolve = { _ in }
        super.init(coder: coder)
    }
    
    /// Called when the view controller has been added to a parent.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard !isResolved, let parent = parent else { return }
        
        // Traverse the view controller hierarchy to find a top-level view controller,
        // preferring a visible one inside a UINavigationController if available.
        var current: UIViewController? = parent
        while current != nil {
            if let navController = current as? UINavigationController,
               let topViewController = navController.topViewController {
                onResolve(topViewController)
                isResolved = true
                break
            }
            current = current?.parent
        }
        
        // Fallback to the immediate parent if no UINavigationController was found.
        if !isResolved {
            onResolve(parent)
            isResolved = true
        }
    }
}
