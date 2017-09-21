# apprc
#
# Install and configure rc script for the defined application with startup validation.
#
# @summary  This class creates a mechanism to manage rc scripts for applications on RHEL/Centos7
#           system.  The script includes the capability to add a post-exec test validationn script
#           to ensure the health of the application after startup.
#
# @param rc_startid [String] Allows for the customization of priority given to the script during startup.
# @param rc_stopid [String] Allows for the customization of priority given to the script during shutdown.
# @param rc_template [String] Allows for custom template location for rc script
# @param rc_valiation [String] Allows for custom template location for validation script
#
# @example
#   include apprc
class apprc (
  $apps,
){
    $apps.each | $app_data | {
        apprc::app { $app_data['app_name']:
            app_validate => $app_data['app_validate'],
            app_start    => $app_data['app_start'],
            app_stop     => $app_data['app_stop'],
            app_proc     => $app_data['app_proc'],
        }
    }
}