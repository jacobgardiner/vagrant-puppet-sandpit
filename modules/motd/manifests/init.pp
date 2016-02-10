# very basic motd

class motd {

    # ensure motd is present
    file { '/etc/motd':
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('motd/motd.erb'),
    }


}
