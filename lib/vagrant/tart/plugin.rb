# frozen_string_literal: true

begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant Tart plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
raise "The Vagrant Tart plugin is only compatible with Vagrant 2.3+" if Vagrant::VERSION < "2.3.0"

module Vagrant
  module Tart
    autoload :Action, File.expand_path("../action", __FILE__)
    autoload :Errors, File.expand_path("../errors", __FILE__)

    # Main vagrant plugin class
    class Plugin < Vagrant.plugin("2")
      name "Tart"
      description <<-DESC
            This plugin installs a provider that allows Vagrant to manage
            machines in Tart.
      DESC

      provider(:tart, parallel: false) do
        require_relative "provider"
        Provider
      end
    end
  end
end
