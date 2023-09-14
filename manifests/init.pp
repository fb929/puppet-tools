class tools {
  file {
    "/opt/puppet":
      ensure  => "directory",
      recurse => true,
      purge   => true,
      force   => true,
    ;
    "/opt/puppet/bin":
      ensure  => "directory",
      require => File["/opt/puppet"],
      recurse => true,
      purge   => true,
      force   => true,
    ;
    "/opt/puppet/README.md":
      content => inline_template("# [see](https://github.com/fb929/puppet-tools)\n"),
    ;
  }
}
