module Vagrant
  module Tart
    module Errors
      class TartError < Vagrant::Errors::VagrantError
        error_namespace("tart_provider.errors")
      end
    end
  end
end
