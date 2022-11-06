# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in vagrant-tart.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rubocop", "~> 1.21"

group :development do
    gem "vagrant", git: "https://github.com/hashicorp/vagrant.git"
end

group :plugins do
    gem "vagrant-tart", path: "."
end
