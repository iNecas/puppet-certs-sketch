class certs {

  ca { 'candlepin-ca':
    ensure => present
  }

  cert { 'qpid-broker':
    ensure => present,
    ca => Ca['candlepin-ca'],
  }
}
