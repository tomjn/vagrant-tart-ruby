# frozen_string_literal: true

require 'vagrant/util/platform'

module Vagrant
  module Tart
    module Action
      # Checks that Tart is installed and ready to be used.
      class CheckTart
        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant::provider::tart")
        end

        def call(env)
          if Vagrant::Util::Platform.windows?
            @logger.error("Tart is a MacOS only provider, it cannot be used on windows.")

            raise Vagrant::Errors::VagrantError
          end

          # Carry on.
          @app.call(env)
        end
      end
    end
  end
end