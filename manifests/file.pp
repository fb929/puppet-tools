define tools::file (
  Boolean $bin_link = true,
  Optional[String] $content = undef,
  Optional[String] $source = undef,
  Optional[String] $mode = "0755",
) {
  include ::tools
  ensure_resource(
    "file",
    "/opt/puppet/${caller_module_name}",
    {
      ensure => directory,
      recurse => true,
      purge => true,
      force => true,
    }
  )
  ensure_resource(
    "file",
    "/opt/puppet/${caller_module_name}/$name",
    {
      content => $content,
      source => $source,
      mode => $mode,
      require => File["/opt/puppet/${caller_module_name}"],
    }
  )
  if $bin_link {
    ensure_resource(
      "file",
      "/opt/puppet/bin/${caller_module_name}_$name",
      {
        ensure => "link",
        target => "/opt/puppet/${caller_module_name}/$name",
        require => File["/opt/puppet/${caller_module_name}/$name"],
      }
    )
  }
}
