Pod::Spec.new do |s|
  s.name         = 'Expecta+Receive'
  s.version      = '1.0.0'
  s.summary      = 'Expecta matchers for OCMock 3.0.'
  s.description  = "Extends Expecta with matchers for OCMock, making it easy to check a method is called, its arguments and the return values for a function in one line of code."
  s.homepage     = 'https://github.com/chaserCN/expecta-receive'
  s.license      = 'MIT'
  s.author       = ['Nikolay Popok' => "nikolay.popok@gmail.com"]
  s.source       = { :git => 'https://github.com/chaserCN/expecta-receive', :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'PodSources/**/*.{h,m}'
  s.frameworks   = 'Foundation', 'XCTest'
  s.dependency 'Expecta'
  s.dependency 'OCMock'
end
