# ruby script
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'common_utils'

# required commands
['gcloud','docker','kubectl'].each { |x| 
	if Common_utils.which(x).nil?
		abort "command #{x} not found"
	end
}  

jsonfile = File.read("config.json")
json_data = JSON.parse(jsonfile)
docker_username = json_data['docker_username']
docker_password = json_data['docker_password']
puts "-- logging in to Docker Hub (user #{docker_username} )"
docker_login = "docker login -u #{docker_username} -p #{docker_password}"
out = system(docker_login)
if $?.exitstatus != 0
	abort "Error: #{out}"
end

puts "-- building image #{json_data['docker_image_name']}"
docker_image_name = "#{docker_username}/#{json_data['docker_image_name']}:#{json_data['docker_image_version']}"

docker_build = "docker build -t #{docker_image_name} node-application"
puts docker_build
system(docker_build)

puts "-- pushing image #{docker_image_name}"
docker_push = "docker push #{docker_image_name}"
system(docker_push)

gce_cluster_name = json_data['gce_cluster_name']

puts "-- creating google cloud container cluster #{gce_cluster_name}"
system("gcloud config set project #{json_data['gce_project']}")
system("gcloud config set compute/zone #{json_data['gce_compute_zone']}")
system("gcloud container clusters create #{gce_cluster_name}")
system("gcloud container clusters get-credentials #{gce_cluster_name}")

# fix for problem finding kubeconfig on my windows machine
# (my Windows machine has $HOME set. YMMV.)
kubectl_cmd = "kubectl --kubeconfig=#{ENV['HOME']}\\.kube\\config"

# Create a kubernetes pod and deployment.
system("#{kubectl_cmd} run #{gce_cluster_name} --image=#{docker_image_name} --port=8080")

# expose public IP address
system("#{kubectl_cmd} expose deployment #{gce_cluster_name} --type=\"LoadBalancer\"")

# print the exposed IP address
echo "-- Exposed IP Address:"
system("#{kubectl_cmd} get services kubecluster -o=\"jsonpath={.status.loadBalancer.ingress[].ip}\"")