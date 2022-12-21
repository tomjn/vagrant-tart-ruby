require "vagrant"

module Vagrant
  module Tart
    class Config < Vagrant.plugin("2", :config)
      # @return [Integer] Memory size in MB
      attr_accessor :memory

      # @return [Integer] Disk storage size in GB
      attr_accessor :disksize
    end
  end
end
