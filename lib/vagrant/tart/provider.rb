# frozen_string_literal: true

require "log4r"

module Vagrant
  module Tart
    # This is the base class for a provider for the V2 API. A provider
    # is responsible for creating compute resources to match the needs
    # of a Vagrant-configured system.
    class Provider < Vagrant.plugin(2, :provider)
      def initialize(machine)
        @logger = Log4r::Logger.new("vagrant::provider::tart")
        @machine = machine
      end

      def to_s
        id = @machine.id.nil? ? "new" : @machine.id
        "Tart (#{id})"
      end
    end
  end
end
