class tools::disable_transparent_hugepage {
  if $virtual == 'physical' {
    exec {
      default:
        path => '/bin:/sbin:/usr/bin:/usr/sbin',
        provider => 'shell',
      ;
      'disable transparent_hugepage':
        command => 'echo never >/sys/kernel/mm/transparent_hugepage/enabled',
        unless => 'cat /sys/kernel/mm/transparent_hugepage/enabled | grep -Fe "[never]"',
      ;
      'disable transparent_hugepage_defrag':
        command => 'echo never >/sys/kernel/mm/transparent_hugepage/defrag',
        unless => 'cat /sys/kernel/mm/transparent_hugepage/defrag | grep -Fe "[never]"',
      ;
    }
  }
}
