namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to #{user}:rvm"
  task :chown, roles: :app do
    sudo "chown -R #{user}:rvm #{deploy_to}"
    sudo "chmod -R 775 #{deploy_to}"
  end

  desc "Add config dir to shared folder"
  task :add_shared_config, roles: :app do
    run "#{try_sudo} mkdir -p #{deploy_to}/shared/config"
  end

  desc "Upload configuration files"
  task :upload_configs, roles: :app do
    Dir.glob('config/*.yml').each {|cfg| top.upload cfg, "#{deploy_to}/shared/config/", via: :scp }
    Dir.glob('.env').each {|cfg| top.upload cfg, "#{deploy_to}/shared/config/", via: :scp }
  end

  desc "Symlink configs"
  task :symlink_configs, roles: :app do
    run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/.env #{current_path}/"
#    run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/newrelic.yml #{current_path}/config/"
    run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/database.yml #{current_path}/config/"
    run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/settings.yml #{current_path}/config/"
  end

  desc "Create nginx configuration from template"
  task :add_nginx_config, roles: :app do
    # add code to backup file if it exists
    template_sudo 'nginx.conf.erb', "/opt/nginx/conf/sites.d/#{application}.conf"
  end

  # Helper method to upload to /tmp then use sudo to move to correct location.
  def put_sudo(data, to, hosts)
    filename = File.basename(to)
    to_directory = File.dirname(to)

    # create temp file
    put data, "/tmp/#{filename}", hosts: hosts
    
    # mkdir unless dirpath exists
    run "if [ ! -d '#{to_directory}' ]; then #{sudo} mkdir #{to_directory}; fi", hosts: hosts

    # create time stamped backup file if one exists  
    run "if [[ -f #{to_directory}/#{filename} ]]; then #{sudo} cp #{to_directory}/#{filename} #{to_directory}/#{filename}.#{Time.now.strftime('%Y.%m.%d.%H.%M')}.bak; fi", hosts: hosts

    # move tmp file to destination
    sudo "mv -f /tmp/#{filename} #{to_directory}/", hosts: hosts
  end
   
  # Helper method to create ERB template then upload using sudo privileges (modified from rbates)
  def template_sudo(from, to, locals={})
    find_servers_for_task(current_task).each_with_index do |current_server,i|
      # grab ip address of host
      ip_via_bash = "/sbin/ifconfig eth0 | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}'"

      # setup the ip address to a capistrano variable
      set :ip, capture(ip_via_bash, hosts: current_server.host).scan(/\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b/).first

      # create counter for new relic server number
      set :new_relic_server_number, "%02d" % (i+1)

      # load file from template
      erb = File.read(File.expand_path("../templates/#{from}", __FILE__))

      # upload file to host
      put_sudo ERB.new(erb).result(binding), to, current_server.host
    end
  end
end