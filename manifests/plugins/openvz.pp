class munin::plugins::openvz {
  munin::plugin::deploy {
    [ 'openvzcpu' ]:
      config => 'user root\nenv.drawidle 1',
      require => Package['libcolor-calc-perl', 'libgraphics-colorobject-perl'];
    ['openvz_physpages', 'openvz_laverage', 'openvz_status']:
      ensure => 'openvz_',
      config => 'user root'
  }

  package { ['libcolor-calc-perl', 'libgraphics-colorobject-perl']:
    ensure => "present";
  }
}
