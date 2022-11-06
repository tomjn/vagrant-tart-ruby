# frozen_string_literal: true

require_relative "tart/version"

module Vagrant
  module Tart
    class Error < StandardError; end
    # Your code goes here...

    class TartPlugin < Vagrant.plugin("2")
      name "Vagrant Tart"
    end

  end
end
