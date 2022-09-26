function pull_to_push {

  {%- if cl_client_name == "nimbus" %}

  curl localhost:{{beacon_metrics_port}}/metrics | sed '/^[^#]/s/process_virtual_memory_bytes /_ /' | sed '/^[^#]/s/process_max_fds /_c /' | sed '/^[^#]/s/process_open_fds /_b /' | sed '/^[^#]/s/process_cpu_seconds_total /_d /' |sed '/^[^#]/s/process_start_time_seconds /_e /' | sed '/^[^#]/s/process_resident_memory_bytes /_f /' | curl --data-binary @- http://{{pushgateway_ip}}/metrics/job/pushgateway/scrape_location/beacon/network/{{cl_network_name}}/instance/$(hostname)/client_name/{{cl_client_name}}

  {%- elif cl_client_name == "lighthouse" %}

  curl localhost:{{beacon_metrics_port}}/metrics | sed '/^[^#]/s/process_cpu_seconds_total /_ /' | curl --data-binary @- http://{{pushgateway_ip}}/metrics/job/pushgateway/scrape_location/beacon/network/{{cl_network_name}}/instance/$(hostname)/client_name/{{cl_client_name}}

  {% else %}

  curl localhost:{{beacon_metrics_port}}/metrics | curl --data-binary @- http://{{pushgateway_ip}}/metrics/job/pushgateway/scrape_location/beacon/network/{{cl_network_name}}/instance/$(hostname)/client_name/{{cl_client_name}}

  {% endif %}

  {%- if raw_iron is sameas false %}

  curl localhost:9100/metrics | curl --data-binary @- http://{{pushgateway_ip}}/metrics/job/pushgateway/scrape_location/node_exporter/network/{{cl_network_name}}/instance/$(hostname)/client/{{cl_client_name}}

  {% endif %}

  {%- if validator_enabled is sameas true %}


  curl localhost:{{validator_metrics_port}}/metrics | curl --data-binary @- http://{{pushgateway_ip}}/metrics/job/pushgateway/scrape_location/validator/network/{{cl_network_name}}/instance/$(hostname)/client/{{cl_client_name}}
  {% endif %}

  sleep 20
}

for (( j = 0; j < 2; j++ )); do
	pull_to_push
done