name "app-server"
description "The app server role for boxit"
run_list ["passenger::install", "passenger::daemon"]