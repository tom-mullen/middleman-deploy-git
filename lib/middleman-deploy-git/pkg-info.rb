module Middleman
  module Deploy
    module Git
      PACKAGE = 'middleman-deploy-git'
      VERSION = '1.0.0'
      TAGLINE = 'Deploy a middleman built site over git (e.g. gh-pages on github).'
      README = %{
        You should follow one of the four examples below to setup the deploy
        extension in config.rb.

        # To deploy to a remote branch via git (e.g. gh-pages on github):
        activate :deploy do |deploy|
        # remote is optional (default is "origin")
        # run `git remote -v` to see a list of possible remotes
        deploy.remote = "some-other-remote-name"

        # branch is optional (default is "gh-pages")
        # run `git branch -a` to see a list of possible branches
        deploy.branch = "some-other-branch-name"

        # strategy is optional (default is :force_push)
        deploy.strategy = :submodule
        # end
        }
    end
  end
end
