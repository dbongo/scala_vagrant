class { 'apt': }

node default {
    include java
    include scala

    apt::ppa { 'ppa:git-core/ppa': }
    package { 'git':
        ensure   => latest
    }
}
