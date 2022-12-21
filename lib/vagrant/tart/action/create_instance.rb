module Vagrant
  module Tart
    module Action
      class CreateInstance
        def initialize(app, env)
          @app = app
        end

        def call(env)
          env[:ui].output('Creating the machine...')
          env[:machine].provider.driver.create_vm
          @app.call(env)
        end
      end
    end
  end
end
