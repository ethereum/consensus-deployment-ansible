Role Name
=========

A role to setup HAproxy on your server. The role is meant to be configured with variables which are automatically
used in the config. The expectation is that there are multiple frontends and backends that need to be configured. The
frontends are described as ACLs and the corresponding backend to use is specified. 

Requirements
------------

A debian based environment as haproxy is run as a service

Role Variables
--------------

```
haproxy_frontends:                                  # Specifies the frontends that are entered as ACLs in the config                     
  - name: host_grafana                              # Name of the frontend
    address: grafana.example.io                     # DNS address 
    backend: grafana                                # Corresponding backend to send traffic to, user needs to ensure this exists!

haproxy_backend_servers:                            # Specifies the backends that receive traffic
  - name: grafana                                   # Name of the backend, referenced by the frontend
    address: localhost:3000                         # The address to send traffic to 
    options: 'check fall 3 rise 2'                  # The rule to add for uptime check or other parameters

haproxy_stats_port: 8404                            # Port for HA proxy statistics, could be used by an exporter
haproxy_user: monitoring                            # User to run process as
haproxy_group: monitoring                           # Group in which to run process
haproxy_stats_user: monitoring                      # User for authentication to statistics page
haproxy_stats_password: example                     # Password for authentication to statistics page

haproxy_default_backend_name: grafana               # Default backend for traffic
```



Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      become: yes
      roles:
        - { role: ansible-haproxy }



Contributors welcome!
----------------

If you like my work, feel free to buy me a beer.

Ethereum address: 0x2628562A4fd5762D52CF43DE21bB925174C33085