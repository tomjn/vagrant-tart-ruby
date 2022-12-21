module Vagrant
  module Tart
    module Errors
      class TartError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_tart.errors")
      end

      class MacRequired < TartError
        error_key(:mac_required)
      end

      class TartRequired < TartError
        error_key(:tart_required)
      end

      class ShellScriptError < TartError
        error_key(:shellscript_error)
      end
    end
  end
end
