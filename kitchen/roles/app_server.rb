name "app-server"
description "The app server role for boxit"
run_list ["passenger::install", "passenger::daemon"]
#env_run_lists "production" => ["recipe[passenger::config_prod]"], "testing" => ["recipe[passenger::config_test]"]