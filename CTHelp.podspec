#
# Be sure to run `pod lib lint CTHelp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
    spec.name         = 'CTHelp'
    spec.version      = '0.1.0'
    spec.summary      = 'A help system for iOS/Swift'
    spec.authors      = { 'StewartLynch' => 'slynch@createchsol.com' }
    spec.license      = 'MIT'
    spec.platform = :ios, '10.0'
    spec.homepage = 'https://github.com/StewartLynch/CTHelp.git'
    spec.source = { git: 'https://github.com/StewartLynch/CTHelp.git', :tag => spec.version.to_s}
    
    spec.module_name = 'CTHelp'
    
    spec.source_files = 'CTHelp/**/*.{h,m,swift}'
    spec.resources = 'CTHelp/Resources/*.*','CTHelp/Views/.{xib,storyboard}'
    
    spec.static_framework = true
    spec.swift_version = "4.2"
    spec.frameworks = 'UIKit'
    
end
