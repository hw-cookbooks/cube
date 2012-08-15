name             "riot-cube"
maintainer       "Riot Games"
maintainer_email "tcashion@riotgames.com"
license          "Apache 2.0"
description      "Installs/Configures cube"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.1"

%w( centos redhat fedora ubuntu ).each do |os|
  supports "os"
end

depends "riot-mongodb"
depends "nodejs", "= 1.0.1"
