# Class: sbt
#
# This module installs the Scala Build Tool package.
#
# Parameters:
#
# Actions:
#
# Requires:
#  wget
#
# Sample Usage:
#
class sbt {
    include wget

    $sbt_deb_source = 'http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.13.0/sbt.deb'

    file { '/opt/debs':
        ensure => directory,
        before => Wget::Fetch['sbt-deb-file']
    }

    wget::fetch { 'sbt-deb-file':
       source      => $sbt_deb_source,
       destination => '/opt/debs/sbt.deb',
       timeout     => 0,
       verbose     => false
    }

    package { 'sbt':
        provider => dpkg,
        ensure   => installed,
        source   => '/opt/debs/sbt.deb',
        require  => Wget::Fetch['sbt-deb-file',
        before   => Exec['apt-get-fix']
    }

    exec { 'apt-get-fix':
        command => "/usr/bin/apt-get -f -y install",
        unless  => "/usr/bin/apt-get check"
    }
}

# Class: spackage_repository_updatebt
#
# This module forces an apt-get update.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class package_repository_update {
    exec { 'apt-get-update':
        command => "/usr/bin/apt-get update"
    }
}



# Stage Chaining
stage { 'preinstall_apt_update':
  before => Stage['preinstall_apt']
}

stage { 'preinstall_apt':
  before => Stage['main']
}

# Default build node
node default {
    include git

    class {'package_repository_update': stage => preinstall_apt_update}
    class {'java': stage => preinstall_apt}
    class {'sbt': }
}
