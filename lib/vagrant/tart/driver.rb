require "json"
require "log4r"

module Vagrant
  module Tart
    class Driver

      # @return [String] VM ID
      attr_reader :vm_id

      def initialize(id)
        @vm_id = id
        @logger   = Log4r::Logger.new("vagrant::tart::driver")
      end

      def execute(path, options={})
        return nil
      end
    end
  end
end
