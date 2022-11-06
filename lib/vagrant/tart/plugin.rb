begin
    require "vagrant"
rescue LoadError
    raise "The Vagrant Tart plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "2.3.0"
    raise "The Vagrant Tart plugin is only compatible with Vagrant 2.3+"
end

module Vagrant
    module Tart
        class Plugin < Vagrant.plugin("2")
            name "Tart"
            description <<-DESC
            This plugin installs a provider that allows Vagrant to manage
            machines in Tart.
            DESC

            provider (:tart, parallel:false) do
                require_relative "provider"
                Provider
            end
        end
    end
end
