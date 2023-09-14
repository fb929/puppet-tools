# required https://github.com/voxpupuli/puppet-consul
define tools::consul_alert (
  Hash $cfg,
) {
  $value = String(to_json($cfg))
  consul_key_value { "alerts/$name/$fqdn":
    value => $value,
  }
}
