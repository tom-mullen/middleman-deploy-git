# Middleman Deploy

Deploy your [Middleman](http://middlemanapp.com/) build to a specific branch on a **git** repository, so you can either host it on github pages, or use an approach like DHH does in [kamal-skiff](https://github.com/basecamp/kamal-skiff).

This gem is a fork and reduction of the original [middleman-deploy](https://github.com/karlfreeman/middleman-deploy/) to support git only (the other approaches felt a bit old skool).

## Installation

```ruby
gem 'middleman-deploy-git', '~> 1.0'
```

## Usage

```
$ middleman build [--clean]
$ middleman deploy [--build-before]
```

## Possible Configurations

Middleman-deploy-git can deploy a site via git.

### Git (e.g. GitHub Pages)

Make sure that `git` is installed, and activate the extension by adding the
following to `config.rb`:

```ruby
activate :deploy do |deploy|
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
```

If you use a remote name, you must first add it using `git remote add`. Run
`git remote -v` to see a list of possible remote names. If you use a git url,
it must end with '.git'.

Afterwards, the `build` directory will become a git repo.

If you use the force push strategy, this branch will be created on the remote if
it doesn't already exist.
But if you use the submodule strategy, you must first initialize build folder as
a submodule. See `git submodule add` documentation.

### Run Automatically

To automatically run `middleman build` during `middleman deploy`, turn on the
`build_before` option while activating the deploy extension:

```ruby
activate :deploy do |deploy|
  # ...
  deploy.build_before = true # default: false
end
```

### Multiple Environments

Deploy your site to more than one configuration using environment variables.

```ruby
# config.rb
case ENV['TARGET'].to_s.downcase
when 'production'
  activate :deploy do |deploy|
    deploy.branch = 'production'
  end
else
  activate :deploy do |deploy|
    deploy.branch = 'staging'
  end
end
```

```ruby
# Rakefile
namespace :deploy do
  def deploy(env)
    puts "Deploying to #{env}"
    system "TARGET=#{env} bundle exec middleman deploy"
  end

  task :staging do
    deploy :staging
  end

  task :production do
    deploy :production
  end
end
```

```
$ rake deploy:staging
$ rake deploy:production
```

# Credits

This gem is based on the great work done on the original [middleman-deploy](https://github.com/karlfreeman/middleman-deploy/).

Inspiration:

The main inspiration for this gem was the approach taken by DHH in [kamal-skiff](https://github.com/basecamp/kamal-skiff).
