groupinstall 'Dial-up Networking Support' do
  # dnf requires the group to be installed already
  # yum does not
  only_if { node['platform_version'].to_i >= 8 }
end

groupinstall 'dial-up' do
  action :upgrade
end
