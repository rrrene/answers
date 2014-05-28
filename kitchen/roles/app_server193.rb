name "app-server_193"
description "The app server role for boxit"
run_list ["passenger::install", "passenger::daemon", "sqlite"]