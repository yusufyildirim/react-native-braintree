
Pod::Spec.new do |s|
  s.name         = "RNBraintree"
  s.version      = "1.0.0"
  s.summary      = "RNBraintree"
  s.description  = <<-DESC
                  RNBraintree
                   DESC
  s.homepage     = "https://www.example.com"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "8.0"
  
  s.source_files  = "RNBraintree/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "BraintreeDropIn"

end
