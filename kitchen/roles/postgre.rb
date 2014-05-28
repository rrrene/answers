name "postgre"
description "Base role for DB support"
run_list ["postgresql", "postgresql::server", "postgresql::pg_user"]
default_attributes postgresql: {
				database: [
					{
						name: 'answers',
						encoding: 'unicode'
					}
				],
        users: [
            {
                username: "answers",
                password: "answers",
                superuser: false,
                createdb: true,
                login: true
            }
        ]
    }