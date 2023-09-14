# puppet-tools
## setup
### r10k:
add in Puppetfile
```
mod 'tools',
  :git => 'https://github.com/fb929/puppet-tools',
  :tag => 'v0.0.1'
```
## usage
### deploy scripts
```
tools::file {
  "backup.sh": source => "puppet:///modules/${module_name}/bin/backup.sh";
  "update_lets_cert.sh":
    content => template("$caller_module_name/bin/update_lets_cert.sh"),
    mode => "0750",
  ;
}
```
### configure consul "service"
```
tools::consul_cfg { $module_name: port => 9103 }
```
### add alert in consul kv
```
tools::consul_alert { $module_name:
  cfg => {
    alert => "$fqdn InstanceDown",
    expr => "up{fqdn='$fqdn'} == 0",
    for => "5m",
    labels => {
      severity => "critical",
    },
    annotations => {
      description => "$fqdn instance down",
    },
  },
}
```

## [Reference](REFERENCE.md)
