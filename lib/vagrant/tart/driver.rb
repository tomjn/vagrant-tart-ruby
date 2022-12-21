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
        if path.is_a?(Symbol)
          path = "#{path}.sh"
        end

        r = execute_shellscript(path, options)

        if r.exit_code != 0
          raise Errors::ShellScriptError,
            script: path,
            stderr: r.stderr
        end

        return nil
      end

      def execute_shellscript(path, options, &block)
        script_path = Pathname.new(File.expand_path("../scripts", __FILE__))
        options = options || {}
        cmd = [
          script_path
        ]
        cmd = cmd + options
        return Vagrant::Util::Subprocess.execute(*cmd, &block)
      end

      def create_vm
        execute(:create_vm, VmId: vm_id)
      end

      def delete_vm
        execute(:delete_vm, VmId: vm_id)
      end

      # Fetch current state of the VM
      #
      # @return [Hash<state, status>]
      def get_current_state
        return nil
      end

      def has_tart?
        execute(:check_tart)
      end

      def start
        execute(:start_vm, VmId: vm_id )
      end

      def stop
        execute(:stop_vm, VmId: vm_id)
      end
    end
  end
end
