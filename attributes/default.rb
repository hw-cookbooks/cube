default[:cube][:install_dir]          = "/srv/cube"
default[:cube][:static_dir]           = "#{node.cube.install_dir}/static"
default[:cube][:log_dir]              = "/var/log/cube"
default[:cube][:log_rotate_frequency] = "daily"
default[:cube][:past_logs]            = 7
