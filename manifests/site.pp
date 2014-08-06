node /haproxy01/ {
  include ::haproxy
  include ::keepalived

  keepalived::vrrp::script { 'check_haproxy':
    script => '/usr/bin/killall -0 haproxy',
  }

  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'MASTER',
    virtual_router_id => '50',
    priority          => '101',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => '172.28.33.12',
    track_script      => 'check_haproxy',
  }

  haproxy::listen { 'web':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '80',
    options          => {},
  }
  haproxy::listen { 'stats':
    ipaddress => $::ipaddress, 
    ports     => '8080',
    options   => {
      'mode'  => 'http',
      'stats' => [
        'uri /',
        'auth puppet:puppet'
      ],  
    },  
  }
  haproxy::balancermember { 'web01':
    listening_service => 'web',
    server_names      => 'web01',
    ipaddresses       => '172.28.33.21',
    ports             => '80',
    options           => 'check',
  }
  haproxy::balancermember { 'web02':
    listening_service => 'web',
    server_names      => 'web02',
    ipaddresses       => '172.28.33.22',
    ports             => '80',
    options           => 'check',
  }
}

node /haproxy02/ {
  include ::haproxy
  include ::keepalived

  keepalived::vrrp::script { 'check_haproxy':
    script => '/usr/bin/killall -0 haproxy',
  }
  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'BACKUP',
    virtual_router_id => '50',
    priority          => '100',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => '172.28.33.12',
    track_script      => 'check_haproxy',
  }
  haproxy::listen { 'stats':
    ipaddress => $::ipaddress, 
    ports     => '8080',
    options   => {
      'mode'  => 'http',
      'stats' => [
        'uri /',
        'auth puppet:puppet'
      ],  
    },  
  }
  haproxy::listen { 'web':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '80',
    options          => {},
  }
  haproxy::balancermember { 'web01':
    listening_service => 'web',
    server_names      => 'web01',
    ipaddresses       => '172.28.33.21',
    ports             => '80',
    options           => 'check',
  }
  haproxy::balancermember { 'web02':
    listening_service => 'web',
    server_names      => 'web02',
    ipaddresses       => '172.28.33.22',
    ports             => '80',
    options           => 'check',
  }

}

node default {
}
