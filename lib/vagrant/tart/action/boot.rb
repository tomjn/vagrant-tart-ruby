module Vagrant
  module Tart
    module Action
      class Boot
        def initialize(app, env)
          @app = app
        end

        def call(env)
          @env = env

          boot_mode = @env[:machine].provider_config.gui ? "gui" : "headless"

          # Start up the VM and wait for it to boot.
          env[:ui].info I18n.t("vagrant.actions.vm.boot.booting")

          @logger.error("Tart Action Not Implemented Yet.")
          raise Vagrant::Errors::VagrantError

          # env[:machine].provider.driver.start(boot_mode)

          @app.call(env)
        end
      end
    end
  end
end
