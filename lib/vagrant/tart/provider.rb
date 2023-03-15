# frozen_string_literal: true

require "log4r"

require_relative "driver"

module Vagrant
  module Tart
    # This is the base class for a provider for the V2 API. A provider
    # is responsible for creating compute resources to match the needs
    # of a Vagrant-configured system.
    class Provider < Vagrant.plugin(2, :provider)

      # This provider only supports MacOS so raise an error on other platforms
      def self.usable?(raise_error=false)
        unless Vagrant::Util::Platform.darwin?
          raise Errors::MacRequired
        end

        return true
      rescue Errors::TartError
        raise if raise_error
        return false
      end

      def initialize(machine)
        @logger = Log4r::Logger.new("vagrant::provider::tart")
        @machine = machine

        # This method will load in our driver, so we call it now to
        # initialize it.
        machine_id_changed
      end

      def to_s
        id = @machine.id.nil? ? "new" : @machine.id
        "Tart (#{id})"
      end

      # Set up the driver with the machine ID ( inspired by HyperV provider )
      def machine_id_changed
        @driver = Driver.new(@machine.id)
      end

      def state
        state_id = nil
        state_id = :not_created if !@machine.id

        if !state_id
          # Run a custom action we define called "read_state" which does
          # what it says. It puts the state in the `:machine_state_id`
          # key in the environment.
          env = @machine.action(:read_state)
          state_id = env[:machine_state_id]
        end

        # Get the short and long description
        short = state_id.to_s
        long  = ""

        # If we're not created, then specify the special ID flag
        if state_id == :not_created
          state_id = Vagrant::MachineState::NOT_CREATED_ID
        end

        # Return the MachineState object
        Vagrant::MachineState.new(state_id, short, long)
      end
    end
  end
end
