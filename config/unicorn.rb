root = '/var/www/thecompany/current'
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_err.log"
stdout_path "#{root}/log/unicorn_out.log"

listen '/tmp/unicorn.company_website.sock'
worker_processes 4
timeout 30
