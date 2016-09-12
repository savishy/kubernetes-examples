#!/usr/bin/ruby
require 'json'
jsonfile = File.read("config.json")
json_data = JSON.parse(jsonfile)
gce_cluster_name = json_data['gce_cluster_name']

system("kubectl delete service,deployment #{gce_cluster_name}")
system("gcloud container clusters delete #{gce_cluster_name}")
