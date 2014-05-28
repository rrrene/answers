cookbook_path    ['kitchen/cookbooks', 'kitchen/site-cookbooks']
node_path        'kitchen/nodes'
role_path        'kitchen/roles'
environment_path 'kitchen/environments'
data_bag_path    'kitchen/data_bags'
encrypted_data_bag_secret '.databag_secret'
ssl_verify_mode :verify_peer

knife[:berkshelf_path] = 'kitchen/cookbooks'