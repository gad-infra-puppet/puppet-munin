# handle if_ and if_err_ plugins
class munin::plugins::interfaces  {

  # only for bitv2: change bond0_xxx => bond0.xxx
  $fixed_interfaces = regsubst($::interfaces, 'bond0_([0-9]+)', 'bond0.\1', 'G')

  # filter out many of the useless interfaces that show up
  $real_ifs = reject(split($fixed_interfaces, ' |,'), 'eth\d+_\d+|sit0|virbr\d+_nic|vif\d+_\d+|veth\d+|__tmp\d+')
  $ifs = regsubst($real_ifs, '(.+)', "if_\\1")

  munin::plugin {
    $ifs: ensure => 'if_';
  }
  case $::operatingsystem {
    openbsd: {
      $if_errs = regsubst($real_ifs, '(.+)', "if_errcoll_\\1")
      munin::plugin{
        $if_errs: ensure => 'if_errcoll_';
      }
    }
    default: {
      $if_errs = regsubst($real_ifs, '(.+)', "if_err_\\1")
      munin::plugin{
        $if_errs: ensure => 'if_err_';
      }
    }
  }
}
