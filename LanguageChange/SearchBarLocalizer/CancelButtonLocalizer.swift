//
//  CancelButtonLocalizer.swift
//  LanguageChange
//
//  Created by Vlad on 22/6/25.
//

import SwiftUI
import Combine

/// ViewModifier that dynamically localizes the "Cancel" button of a UISearchController.
struct CancelButtonLocalizer: ViewModifier {
    @StateObject private var localizer = CancelButtonLocalizerController()

    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    if let nav = viewController as? UINavigationController,
                       let search = nav.topViewController?.navigationItem.searchController {
                        localizer.setSearchController(search)
                    } else if let search = viewController.navigationItem.searchController {
                        localizer.setSearchController(search)
                    }
                }
                .frame(width: 0, height: 0)
            )
    }
}

/// Controller responsible for updating the "Cancel" button based on language changes.
final class CancelButtonLocalizerController: ObservableObject {
    @AppStorage("MyLanguages") private var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"

    private weak var searchController: UISearchController?
    private var cancellables = Set<AnyCancellable>()

    init() {
        // React to language changes via LanguageManager
        LanguageManager.shared.$selectedLanguage
            .sink { [weak self] _ in
                self?.updateCancelButton()
            }
            .store(in: &cancellables)
    }

    /// Sets the target UISearchController and applies localization immediately.
    func setSearchController(_ searchController: UISearchController) {
        self.searchController = searchController
        updateCancelButton()
    }

    /// Updates the cancel button title using two methods for reliability.
    private func updateCancelButton() {
        guard let searchController = searchController else { return }

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            let localizedText = "cancelation_button".localized(using: self.currentLanguage)

            // Method 1: Set internal value via KVC (affects future displays)
            searchController.searchBar.setValue(localizedText, forKey: "cancelButtonText")

            // Method 2: Locate the actual button in the hierarchy and update it directly
            self.updateVisibleCancelButton(in: searchController.searchBar, with: localizedText)
        }
    }

    /// Attempts to find and update the visible "Cancel" button in the view hierarchy.
    private func updateVisibleCancelButton(in searchBar: UISearchBar, with text: String) {
        if let button = findCancelButton(in: searchBar) {
            applyTitle(text, to: button)
        } else {
            // Retry once after a short delay (helps with animations/presentation timing)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let button = self.findCancelButton(in: searchBar) {
                    self.applyTitle(text, to: button)
                }
            }
        }
    }

    /// Recursively searches the view hierarchy for a UIButton matching "Cancel".
    private func findCancelButton(in view: UIView) -> UIButton? {
        if let button = view as? UIButton {
            let title = button.title(for: .normal)?.lowercased() ?? ""
            let label = button.accessibilityLabel?.lowercased() ?? ""

            let keywords = ["cancel", "отмена"]
            if keywords.contains(where: { title.contains($0) || label.contains($0) }) {
                return button
            }

            if button.buttonType == .system, !title.isEmpty {
                return button
            }
        }

        for subview in view.subviews {
            if let match = findCancelButton(in: subview) {
                return match
            }
        }

        return nil
    }

    /// Applies the localized text to all states of a UIButton.
    private func applyTitle(_ text: String, to button: UIButton) {
        for state in [UIControl.State.normal, .highlighted, .selected, .disabled] {
            button.setTitle(text, for: state)
        }

        button.setNeedsLayout()
        button.layoutIfNeeded()
    }
}
