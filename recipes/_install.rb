include_recipe 'ubuntu'
include_recipe 'golang'

ark 'fsconsul' do
  url "https://github.com/Cimpress-MCP/fsconsul/archive/#{node['fsconsul']['version']}.tar.gz"
  version node['fsconsul']['version']
  action :install
end

execute 'go get' do
  cwd "/usr/local/fsconsul-#{node['fsconsul']['version']}"
  environment GOPATH: node['go']['gopath'],
              GOBIN: node['go']['gobin'],
              PATH: "#{node['go']['install_dir']}/go/bin:#{ENV['PATH']}"
  not_if { ::File.exist?("#{node['go']['gobin']}/fsconsul-#{node['fsconsul']['version']}") }
  action :run
end

execute 'go install' do
  cwd "/usr/local/fsconsul-#{node['fsconsul']['version']}"
  environment GOPATH: node['go']['gopath'],
              GOBIN: node['go']['gobin'],
              PATH: "#{node['go']['install_dir']}/go/bin:#{ENV['PATH']}"
  not_if { ::File.exist?("#{node['go']['gobin']}/fsconsul-#{node['fsconsul']['version']}") }
  action :run
end

link '/usr/local/bin/fsconsul' do
  to "#{node['go']['gobin']}/fsconsul-#{node['fsconsul']['version']}"
  action :create
end
