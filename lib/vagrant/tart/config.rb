require "vagrant"

module Vagrant
  module Tart
    class Config < Vagrant.plugin("2", :config)
      # @return [Integer] Memory size in MB
      attr_accessor :memory

      # @return [Integer] Disk storage size in GB
      attr_accessor :disksize

      # @return [Boolean] Show a GUI window on boot, or run headless
      attr_accessor :gui

      def initialize
        @memory = 2048
        @disksize = 20
        @gui = false
      end

      def to_s
        "Tart"
      end
    end
  end
end
