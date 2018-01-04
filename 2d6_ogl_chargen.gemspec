
Gem::Specification.new do |s|
  s.name          = "2D6_OGL_CharGen".freeze
  s.version       = "0.0.5"
  s.authors       = ["Leam Hall"]
  s.email         = "leamhall@gmail.com"
  s.homepage      = "https://github.com/LeamHall/2d6_ogl_chargen"
  s.executables   = ["chargen", "teamgen"]
  s.licenses      = ["GPL-3.0"]
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Generates 2d6 OGL Characters."
  s.description   = "Career based progression."
  s.files         = Dir.glob("{bin,data,docs,lib,test,toys}/**/*")
  s.has_rdoc      = false
  s.require_paths = ["lib", "lib/tools", "lib/careers"]
  s.add_runtime_dependency 'sqlite3', '>= 0'
  s.add_development_dependency 'mongo', '>= 0'
end
