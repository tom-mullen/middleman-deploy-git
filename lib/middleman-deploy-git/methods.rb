module Middleman
  module Deploy
    module Git
      class Method
        attr_reader :options, :server_instance

        def initialize(server_instance, options = {})
          @options          = options
          @server_instance  = server_instance
        end

        def build_dir
          server_instance.config.setting(:build_dir).value
        end

        def process
          puts "## Deploying via git to remote=\"#{options.remote}\" and branch=\"#{options.branch}\""

          strategy_instance.process
        end

        private

        def strategy_instance
          strategy_class_name.constantize.new(build_dir, options.remote, options.branch, options.commit_message)
        end

        def strategy_class_name
          "Middleman::Deploy::Git::Strategies::#{camelized_strategy}"
        end

        def camelized_strategy
          options.strategy.to_s.split('_').map(&:capitalize).join
        end
      end
    end
  end
end
