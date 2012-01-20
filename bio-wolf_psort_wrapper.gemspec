# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bio-wolf_psort_wrapper"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben J Woodcroft"]
  s.date = "2012-01-20"
  s.description = "Enables the localisation predictor WoLF PSORT to be run locally. The algorithm is available at http://wolfpsort.org/"
  s.email = "donttrustben near gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.mkd"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.mkd",
    "Rakefile",
    "VERSION",
    "bio-wolf_psort_wrapper.gemspec",
    "lib/bio-wolf_psort_wrapper.rb",
    "lib/bio/appl/psort/wolf_psort_wrapper.rb",
    "test/helper.rb",
    "test/test_bio-wolf_psort_wrapper.rb"
  ]
  s.homepage = "http://github.com/wwood/bioruby-wolf_psort_wrapper"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Enables the localisation predictor WoLF PSORT to be run locally"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<bio>, [">= 1.4.2"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<bio>, [">= 1.4.2"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<bio>, [">= 1.4.2"])
  end
end

