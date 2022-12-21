# Vagrant Tart Ruby Plugin

This is ultra early experimental WIP, not functional yet.


## Vagrant Provider Structure

This is a primer on how a vagrant provider works. These are the main parts and what they do:

 - `tart.rb` defines the gem entry point and loads the plugin files
 - `plugin.rb` defines vagrant plugin main class and loads other parts of the codebase. This is where the plugin name and description are added. It's also where actions/errors/etc are all loaded
 - `version.rb` has version info so that Vagrant knows which version of the plugin it's using
 - `provider.rb` defines a vagrant provider, as well as what its capabilities are
 - `errors.rb` provides a place for exception classes to live
 - `config.rb` a data class that has all the parameters you can set via the vagrant file such as memory etc, also a place to put config validation functions
 - `action.rb` this has actions Vagrant will trigger when it wants to do stuff, e.g. when you want to resume a vagrant machine, it will callt he resume action. You then call smaller individual actions here that do all the lifting, like an action to setup network shares, an action to check if the VM is running, an action to delete the VM etc. These are like atomic steps
   - `action/xxxxx.rb` individual actions that can be used in `action.rb` that do just 1 thing
 - `driver.rb` this is a class that the actions use to interact directly with Tart
   - `scripts/` To make things easier, the driver will call a shellscript in this folder so that Tart can be called in a way that doesn't require Ruby and the Ruby side doesn't need changing much. E.g. `stop_vm.sh` should stop a VM ( with the VM ID passed as a parameter ). `driver.rb` will then inspect the output of the script to determine success of failure



## Installation

Something like this:

```sh
bundle install
```

## Usage

Once installed and built you can use `bundle exec vagrant` to run `vagrant` with the codebase

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
