# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-citations"
  spec.version       = "1.0.0"
  spec.authors       = ["Matthew Thomas"]
  spec.email         = ["matthew.thomas@northwestern.edu"]

  spec.summary       = "A citation generator and organizer using jekyll."
  spec.homepage      = "https://github.com/nucet/jekyll-citations"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(assets|_(includes|layouts|sass)/|(LICENSE|README)((\.(txt|md|markdown)|$)))!i)
  end

  spec.add_runtime_dependency "jekyll", ">= 3.5", "< 5.0"

  spec.add_development_dependency "bundler"
end
