Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specifcation_version=
  s.required_rubygems_version = Gem::Requirement.new(">=0") if s.respond_to? :required_rubygems_version=
  
  s.name = 'authlogic_pam'
  s.version = '1.2.0'
  s.date = '2011-06-12'
  
  s.summary = 'PAM authentication plugin for AuthLogic'
  
  s.authors = ["Nat Budin", "Jason Lewis"]
  s.email = 'jasonlewis.x@gmail.com'
  
  s.require_paths = %w[lib]
  
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]
  
  s.add_dependency('authlogic', "~> 3.2.0")
  s.add_dependency('rpam-ruby19', "~> 1.1.0")
  
  s.add_development_dependency('rspec', '~> 2.6.0')
  
  # = MANIFEST = 
  s.files = %w[
    authlogic_pam.gemspec
    Rakefile
    README.md
    lib/authlogic_pam.rb
    lib/authlogic_pam/acts_as_authentic.rb
    lib/authlogic_pam/session.rb
    ]
    
  s.test_files = s.files.select { |path| path =~ /spec\/.+_spec.rb/ }
  
end