name "bare-bones"
description "The base role for all systems"
run_list ["apt", "build-essential", "fail2ban", "git", "hostname", "openssl", "ntp", "rvm::install", "rvm::ruby_210", 'ssl_certificate', "sudo", "users_solo::admins"]