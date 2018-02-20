# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Marvel' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  plugin 'cocoapods-keys', {
    :project => "Marvel",
    :target => "Marvel",
    :keys => [
      "MarvelApiKey",
      "MarvelPrivateKey"
    ]}

  # Pods for Marvel
   pod 'SwiftGen'
   pod 'CryptoSwift',  :git => "https://github.com/krzyzanowskim/CryptoSwift", :branch => 'develop'
   pod 'Kingfisher'
   pod "Reusable"

   target 'MarvelTests' do
     inherit! :search_paths
     # Pods for testing
     pod "Quick"
     pod "Nimble"
     pod 'Nimble-Snapshots'
   end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.2'
    end
  end
end
