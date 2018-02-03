worker_processes 3

working_directory File.expand_path("../..", __FILE__)

listen "unix:tmp/sockets/unicorn.sock", :backlog => 64
timeout 240

pid "tmp/pids/unicorn.pid"
stderr_path "log/unicorn.stderr.log"
stdout_path "log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
