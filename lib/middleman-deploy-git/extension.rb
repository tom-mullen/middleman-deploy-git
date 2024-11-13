# Require core library
require 'middleman-core'

# Extension namespace
module Middleman
  module Deploy
    module Git
      @options

      class << self
        attr_accessor :options
      end

      class Extension < Extension
        option :remote, nil
        option :branch, nil
        option :strategy, nil
        option :commit_message, nil
        option :build_before, nil

        def initialize(app, options_hash = {}, &block)
          super

          yield options if block_given?

          options.remote ||= 'origin'
          options.branch ||= 'gh-pages'
          options.strategy ||= :force_push
          options.commit_message ||= nil
          options.build_before ||= false
        end

        def after_configuration
          ::Middleman::Deploy::Git.options = options
        end
      end
    end
  end
end
