# apprc::app
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   apprc::app { 'namevar': }
define apprc::app(
    $app_name,
    $app_validate,
    $app_start,
    $app_stop,
    $app_proc,
) {
    file { "/etc/init.d/${app_name}":
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => epp('apprc/apprc_service.epp', { start => $app_start, stop => $app_stop }),
    }
    file { "/etc/init.d/${app_validate}":
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => epp('apprc/apprc_validate.epp', { proc => $app_proc }),
    }
    service { $app_name:
        ensure     => 'running',
        hasrestart => true,
        hasstatus  => true,
        enable     => true,
        provider   => 'redhat',
        subscribe  => [
            File["/etc/init.d/${app_name}"],
            File["/etc/init.d/${app_validate}"],
        ],
    }
}
