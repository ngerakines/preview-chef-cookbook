name             'preview'
maintainer       'Nick Gerakines'
maintainer_email 'nick@gerakines'
license          'MIT'
description      'Installs/Configures preview'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'ark'
depends 'apt'
depends 'yum'
depends 'java'
depends 'cassandra'
depends 'golang'