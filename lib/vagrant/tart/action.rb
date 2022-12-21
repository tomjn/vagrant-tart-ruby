# frozen_string_literal: true

module Vagrant
  module Tart
    module Action
      action_root = Pathname.new(File.expand_path("../action", __FILE__))
      autoload :Boot, File.expand_path("../action/boot", __FILE__)
      autoload :CheckAccessible, File.expand_path("../action/check_accessible", __FILE__)
      autoload :CheckCreated, File.expand_path("../action/check_created", __FILE__)
      autoload :CheckRunning, File.expand_path("../action/check_running", __FILE__)
      autoload :CheckTart, action_root.join('check_tart')
      autoload :Created, File.expand_path("../action/created", __FILE__)
      autoload :Customize, File.expand_path("../action/customize", __FILE__)

      autoload :Destroy, action_root.join('action/destroy')

      autoload :CreateInstance, action_root.join('create_instance')
      autoload :StartInstance, action_root.join('start_instance')
      autoload :StopInstance, action_root.join('stop_instance')

      # TODO: Add more actions from the official virtualbox provider where relevant

      # Include the built-in modules so that we can use them as top-level
      # things.
      include Vagrant::Action::Builtin

      # This action boots the VM, assuming the VM is in a state that requires
      # a bootup (i.e. not saved).
      def self.action_boot
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckAccessible
          b.use CheckTart
        end
      end

      # This is the action that is primarily responsible for completely
      # freeing the resources of the underlying virtual machine.
      def self.action_destroy
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          b.use Call, IsState, :not_created do |env1, b1|
            if env1[:result]
              b1.use Message, I18n.t("vagrant_tart.message_not_created")
              next
            end

            b1.use Call, DestroyConfirm do |env2, b2|
              #if !env2[:result]
              #  b2.use MessageWillNotDestroy
              #  next
              #end

              #b2.use ConfigValidate
              #b2.use ProvisionerCleanup, :before
              b2.use StopInstance
              b2.use Destroy
              #b2.use SyncedFolderCleanup
            end
          end
        end
      end

      # This is the action that is primarily responsible for halting
      # the virtual machine, gracefully or by force.
      def self.action_halt
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          b.use StopInstance
        end
      end

      # This action packages the virtual machine into a single box file.
      def self.action_package
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          b.use Call, Created do |env1, b2|
            if !env1[:result]
              b2.use MessageNotCreated
              next
            end

            #b2.use PackageSetupFolders
            #b2.use PackageSetupFiles
            b2.use CheckAccessible
            b2.use action_halt
          end
        end
      end

      # This action just runs the provisioners on the machine.
      def self.action_provision
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      # This action is responsible for reloading the machine, which
      # brings it down, sucks in new configuration, and brings the
      # machine back up with the new configuration.
      def self.action_reload
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          b.use Call, Created do |env1, b2|
            if !env1[:result]
              b2.use MessageNotCreated
              next
            end

            #b2.use ConfigValidate
            b2.use action_halt
            b2.use action_start
          end
        end
      end

      # This is the action that is primarily responsible for resuming
      # suspended machines.
      def self.action_resume
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      def self.action_snapshot_delete
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      # This is the action that is primarily responsible for restoring a snapshot
      def self.action_snapshot_restore
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      # This is the action that is primarily responsible for saving a snapshot
      def self.action_snapshot_save
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      # This is the action that will exec into an SSH shell.
      def self.action_ssh
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          b.use CheckCreated
          b.use CheckAccessible
          b.use CheckRunning
          #b.use SSHExec
        end
      end

      # This is the action that will run a single SSH command.
      def self.action_ssh_run
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          b.use CheckCreated
          b.use CheckAccessible
          b.use CheckRunning
          #b.use SSHRun
        end
      end

      # This action starts a VM, assuming it is already imported and exists.
      # A precondition of this action is that the VM exists.
      def self.action_start
        Vagrant::Action::Builder.new.tap do |b|
          b.use Call, IsState, :running do |env1, b1|
            if env1[:result]
              b1.use action_provision
              next
            end

            #b3.use CleanupDisks
            #b3.use Disk
            #b3.use SyncedFolderCleanup
            b3.use StartInstance
            #b3.use WaitForIPAddress
            #b3.use WaitForCommunicator, [:running]
            #b3.use SyncedFolders
            #b3.use SetHostname
          end
        end
      end

      # This is the action that is primarily responsible for suspending
      # the virtual machine.
      def self.action_suspend
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      # This is the action that is called to sync folders to a running
      # machine without a reboot.
      def self.action_sync_folders
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
        end
      end

      # This action brings the machine up from nothing, including importing
      # the box, configuring metadata, and booting.
      def self.action_up
        Vagrant::Action::Builder.new.tap do |b|
          b.use CheckTart
          #b.use HandleBox
          #b.use ConfigValidate
          b.use Call, IsState, :not_created do |env1, b1|
            if env1[:result]
              b1.use CreateInstance
            end

            b1.use action_start
          end
        end
      end
    end
  end
end
