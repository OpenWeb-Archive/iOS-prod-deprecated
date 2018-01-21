#
# Be sure to run `pod lib lint SpotIM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpotIM'
  s.version          = '1.1.6'
  s.summary          = 'This SDK allows you to integrate SpotIM into your iOS app.'
  s.description      = <<-DESC

## Welcome to the Spot.IM SDK

Spot.IM SDK provides an easy integration with [Spot.IM](http://www.spot.im) into a native iOS app.

Here's a sample app that shows how to use the Spot.IM SDK for iOS.

## Getting started

To use the SDK you will need an active Spot.IM account. If you don't have it, get one [here](http://www.spot.im).
You will need to know your Spot ID (which looks like 'sp_xxxxxxx').
If you don't know your Spot ID, login to the [admin dashboard](https://admin.spot.im) and have a look at the URL.

DESC

  s.homepage        = "http://www.spot.im"
  s.screenshots     = 'https://user-images.githubusercontent.com/607917/35106483-002cf8c8-fc77-11e7-99e1-459c7b9428c1.png', 'https://user-images.githubusercontent.com/607917/35106518-165d4300-fc77-11e7-999d-efde71208596.png'
  s.license         = { :type => 'CUSTOM', :file => 'LICENSE' }
  s.author          = { 'Hernan Arber' => 'hernan@spot.im' }
  s.platform     = :ios
  s.ios.deployment_target = '8.0'

# the Pre-Compiled Framework:
  s.source          = { :http => 'https://github.com/SpotIM/iOS-prod/files/1649912/Spot_IM.framework.zip' }
  s.ios.vendored_frameworks = 'Spot_IM.framework'

#  s.source_files    = 'SpotIM/Spot_IM.framework/Headers/*'
#   s.resource_bundles = {
#     'SpotIM' => ['SpotIM/*.framework']
#   }
# s.public_header_files = 'Headers/*.h'
# s.frameworks = 'UIKit'

end
