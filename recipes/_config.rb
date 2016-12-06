file node['fsconsul']['config']['path'] do
  owner 'root'
  group 'root'
  mode 00640
  content node['fsconsul']['config']['params'].to_json
  action :create
end
