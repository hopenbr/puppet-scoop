# @summary Installs Scoop, Scoop buckets and packages
#
# @example Basic usage
# class { 'scoop':
#   packages => [ 'firefox', 'ripgrep' ],
#   buckets  => [ 'extras' ],
#   url_buckets => {
#     'wangzq' => 'https://github.com/wangzq/scoop-bucket'
#   },
# }
#
# @see https://scoop.sh
#
# @param ensure
#   Install or uninstall Scoop.
#
# @param buckets
#   Configure known buckets.
#   See: https://github.com/lukesampson/scoop/blob/master/buckets.json
#
# @param url_buckets
#   Configure extra buckets by url.
#
# @param packages
#   Install packages with scoop.
class scoop (
  Enum['present', 'absent'] $ensure = 'present',
  Array[String] $buckets = [],
  Hash[String, String] $url_buckets = {},
  Array[String] $packages = [],
) {
  include ::scoop::install

  scoop::bucket { $scoop::buckets:
    ensure => present,
  }

  $scoop::url_buckets.each |$bucket, $url| {
    scoop::bucket { $bucket:
      ensure => present,
      url    => $url,
    }
  }

  scoop::package { $scoop::packages:
    ensure  => present,
  }
}
