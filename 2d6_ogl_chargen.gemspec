require 'rubygems'

Gem::Specification.new do |s|
  s.name          = "2D6 OGL CharGen".freeze
  s.version       = "0.0.4"
  s.authors       = ["Leam Hall"]
  s.email         = "leamhall@gmail.com"
  s.homepage      = "https://github.com/LeamHall/2d6_ogl_chargen"
  s.executables   = ["chargen"]
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Generates 2d6 OGL Characters."
  s.description   = "Age based progression."
  s.files         = Dir.glob("{bin,docs,lib,test,data}/**/*")
  s.has_rdoc      = false
  s.require_paths = ["lib", "lib/tools", "lib/careers"]
  s.add_dependency("sqlite3-ruby", ">= 0")
end
