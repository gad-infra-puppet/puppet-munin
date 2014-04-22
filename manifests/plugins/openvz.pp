class munin::plugins::openvz {
  package { ['libcolor-calc-perl', 'libgraphics-colorobject-perl']:
    ensure => "present";
  }

  include munin::plugin::scriptpaths
  file { "munin_plugin_openvz_":
    path    => "${munin::plugin::scriptpaths::script_path}/openvz_",
    source  => "puppet:///modules/munin/plugins/openvz_",
    owner   => root,
    group   => 0,
    mode    => '0755';
  }

  munin::plugin {
    [ 'openvzcpu' ]:
      config => "user root\nenv.drawidle 1",
      require => Package['libcolor-calc-perl', 'libgraphics-colorobject-perl'];
    ['openvz_physpages', 'openvz_laverage', 'openvz_status']:
      ensure => 'openvz_',
      config => 'user root',
      require => File['munin_plugin_openvz_'];
  }

}
