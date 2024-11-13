require 'middleman-core'
require 'middleman-deploy-git/commands'

::Middleman::Extensions.register(:deploy) do
  require 'middleman-deploy-git/extension'
  ::Middleman::Deploy::Git::Extension
end
