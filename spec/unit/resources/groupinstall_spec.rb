require 'spec_helper'

describe 'groupinstall' do
  platform 'centos'
  step_into :groupinstall

  before do
    allow(Mixlib::ShellOut).to receive(:new).and_return(
      double(run_command: nil, stdout: <<~EOF
        Installed Groups:
           Installed Group (installed)
           Remove me (remove-me)
        Available Groups:
           Test Group (test)
        EOF
      )
    )
  end

  context 'on centos 7' do
    platform 'centos', '7'

    recipe do
      groupinstall 'test' do
        options '--opt'
      end

      groupinstall 'Installed Group'

      groupinstall 'remove-me' do
        action :remove
      end
    end

    it { is_expected.to run_execute('yum -qy group install --opt \'test\'') }
    it { is_expected.to_not run_execute('yum -qy group install  \'Installed Group\'') }

    it { is_expected.to run_execute('yum -qy group remove  \'remove-me\'') }
  end

  context 'on centos 8' do
    platform 'centos', '8'

    recipe do
      groupinstall 'test' do
        options '--opt'
      end

      groupinstall 'Installed Group'

      groupinstall 'remove-me' do
        action :remove
      end
    end

    it { is_expected.to run_execute('dnf -qy group install --opt \'test\'') }
    it { is_expected.to_not run_execute('dnf -qy group install  \'Installed Group\'') }
    it { is_expected.to run_execute('dnf -qy group remove  \'remove-me\'') }
  end

  context 'on fedora' do
    platform 'fedora'

    recipe do
      groupinstall 'test' do
        options '--opt'
      end

      groupinstall 'Installed Group'

      groupinstall 'remove-me' do
        action :remove
      end
    end

    it { is_expected.to run_execute('dnf -qy group install --opt \'test\'') }
    it { is_expected.to_not run_execute('dnf -qy group install  \'Installed Group\'') }
    it { is_expected.to run_execute('dnf -qy group remove  \'remove-me\'') }
  end

  context 'on non-rhel' do
    platform 'ubuntu'

    recipe do
      groupinstall 'test'
    end

    it { is_expected.to_not run_execute('dnf -qy group install  \'test\'') }
  end
end
