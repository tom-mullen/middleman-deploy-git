require 'middleman-core/cli'
require 'middleman-core/rack' if Middleman::VERSION.to_i > 3
require 'middleman-deploy-git/pkg-info'
require 'middleman-deploy-git/extension'
require 'middleman-deploy-git/methods'
require 'middleman-deploy-git/strategies'

module Middleman
  module Cli
    # This class provides a "deploy" command for the middleman CLI.
    module Deploy
      class Git < Thor::Group
        include Thor::Actions

        check_unknown_options!

        namespace :deploy

        class_option :environment,
          aliases: '-e',
          default: ENV['MM_ENV'] || ENV['RACK_ENV'] || 'production',
          desc: 'The environment Middleman will run under'

        class_option :verbose,
          type: :boolean,
          default: false,
          desc: 'Print debug messages'

        class_option :instrument,
          type: :boolean,
          default: false,
          desc: 'Print instrument messages'

        class_option :build_before,
          type: :boolean,
          aliases: '-b',
          desc: 'Run `middleman build` before the deploy step'

        # Tell Thor to exit with a nonzero exit code on failure
        def self.exit_on_failure?
          true
        end

        def deploy
          env = options['environment'] ? :production : options['environment'].to_s.to_sym
          verbose = options['verbose'] ? 0 : 1
          instrument = options['instrument']
          @app = ::Middleman::Application.new do
            config[:mode] = :build
            config[:environment] = env
            ::Middleman::Logger.singleton(verbose, instrument)
          end
          build_before(options)

          Middleman::Deploy::Git::Method.new(@app, deploy_options).process
        end

        protected

        def build_before(options = {})
          build_enabled = options.fetch('build_before', deploy_options.build_before)

          run("middleman build -e #{options['environment']}") || exit(1) if build_enabled
        end

        def print_usage_and_die(message)
          raise StandardError, "ERROR: #{message}\n#{Middleman::Deploy::Git::README}"
        end

        def deploy_options
          options = nil

          begin
            options = ::Middleman::Deploy::Git.options
          rescue NoMethodError
            print_usage_and_die 'You need to activate the deploy extension in config.rb.'
          end

          options
        end
      end

      # Add to CLI
      Base.register(Middleman::Cli::Deploy::Git, 'deploy', 'deploy [options]', Middleman::Deploy::Git::TAGLINE)

      # Alias "d" to "deploy"
      Base.map('d' => 'deploy')
    end
  end
end
