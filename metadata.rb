maintainer       "Heavy Water Software Inc."
maintainer_email "ops@heavywater.ca"
license          "Apache 2.0"
description      "Installs/Configures cube"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.0"

supports "ubuntu"

depends "mongodb"
depends "nodejs"
depends "ufw"
