// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length

struct Storyboard {
  enum Heroes: String, StoryboardSceneType {
    static let storyboardName = "Heroes"

    case charactersViewControllerScene = "CharactersViewController"
    static func instantiateCharactersViewController() -> HeroesViewController {
      guard let vc = Storyboard.Heroes.charactersViewControllerScene.viewController() as? HeroesViewController
      else {
        fatalError("ViewController 'CharactersViewController' is not of the expected class HeroesViewController.")
      }
      return vc
    }

    case navCharactersViewControllerScene = "NavCharactersViewController"
    static func instantiateNavCharactersViewController() -> UINavigationController {
      guard let vc = Storyboard.Heroes.navCharactersViewControllerScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'NavCharactersViewController' is not of the expected class UINavigationController.")
      }
      return vc
    }
  }
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Marvel: String, StoryboardSceneType {
    static let storyboardName = "Marvel"

    case marvelViewControllerScene = "MarvelViewController"
    static func instantiateMarvelViewController() -> MarvelViewController {
      guard let vc = Storyboard.Marvel.marvelViewControllerScene.viewController() as? MarvelViewController
      else {
        fatalError("ViewController 'MarvelViewController' is not of the expected class MarvelViewController.")
      }
      return vc
    }

    case navMarvelViewControllerScene = "NavMarvelViewController"
    static func instantiateNavMarvelViewController() -> UINavigationController {
      guard let vc = Storyboard.Marvel.navMarvelViewControllerScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'NavMarvelViewController' is not of the expected class UINavigationController.")
      }
      return vc
    }
  }
  enum Start: StoryboardSceneType {
    static let storyboardName = "Start"

    static func initialViewController() -> UITabBarController {
      guard let vc = storyboard().instantiateInitialViewController() as? UITabBarController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
  enum Villains: String, StoryboardSceneType {
    static let storyboardName = "Villains"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case navViliansViewControllerScene = "NavViliansViewController"
    static func instantiateNavViliansViewController() -> UINavigationController {
      guard let vc = Storyboard.Villains.navViliansViewControllerScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'NavViliansViewController' is not of the expected class UINavigationController.")
      }
      return vc
    }

    case viliansViewControllerScene = "ViliansViewController"
    static func instantiateViliansViewController() -> ViliansViewController {
      guard let vc = Storyboard.Villains.viliansViewControllerScene.viewController() as? ViliansViewController
      else {
        fatalError("ViewController 'ViliansViewController' is not of the expected class ViliansViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
