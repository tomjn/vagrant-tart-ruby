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

## Box Format

A Tart Vagrant box is a zip/box file containing a vagrantfile and the contents of a tart VM.

### Tart VMs

Tart VMs are folders in `~/.tart/vms` that take this format where `vmname` is the name of the VM in Tart:

 - vmname/
 - vmname/disk.img
 - vmname/nvmram.bin
 - vmname/config.json

This is also the format of Tart VMs sent to and pulled from OCI registries.

### Vagrant Box Packages

The box is the contents of the VM folder, with a vagrantfile alongside. It's expected that when imported the contents of the box will be extracted into a folder with that name inside `~/.tart/vms`.

###  Identifying Vagrant VMs in Tart

Because it's expected the box contents will become the VM, Vagrant VMs in Tart will have a vagrantfile in their folder. It's also expected their name will have a prefix e.g. `vagrant_vm_`. This is to aid in identification and to avoid clashes and name collisions with non-vagrant Tart usage.

## Installation

Something like this:

```sh
bundle install
```

## Usage

Once installed and built you can use `bundle exec vagrant` to run `vagrant` with the codebase

## Development

See https://developer.hashicorp.com/vagrant/docs/plugins/development-basics#setup-and-workflow

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
