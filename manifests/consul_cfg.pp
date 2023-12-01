# required https://github.com/voxpupuli/puppet-consul
define tools::consul_cfg (
  Integer $port,
  String $type = "service",
  Hash $meta = {},
) {
  # setting default value for hash "meta" {{
  $default_meta = {
    metrics_path => "/metrics",
    groupname => $facts["groupname"],
    hostname => $facts["networking"]["hostname"],
    instance => $facts["networking"]["hostname"],
    fqdn => $facts["networking"]["fqdn"],
    public_hostname => $facts['ec2_metadata'].get('public-hostname', 'unknown'),
    public_ipv4 => $facts['ec2_metadata'].get('public-ipv4', $facts.get('ext_ip', 'unknown')),
    ec2_tag_name => $facts.get('ec2_tag_name', 'unknown'),
    ec2_tag_role => $facts.get('ec2_tag_role', 'unknown'),
    ec2_tag_group => $facts.get('ec2_tag_group', 'unknown'),
    process_name => $name,
  }
  $_meta = $default_meta + $meta
  # }}

  if ( $type == "service" ) {
    consul::service { $name:
      port => $port,
      meta => $_meta,
      checks => [
        {
          name => "$name tcp port check",
          tcp => "127.0.0.1:$port",
          interval => "10s",
        },
      ],
    }
  } else {
    fail("unsupported type='$type'")
  }
}
