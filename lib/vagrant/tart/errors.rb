module Vagrant
  module Tart
    module Errors
      class TartError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_tart.errors")
      end

      class MacRequired < TartError
        error_key(:mac_required)
      end
    end
  end
end
