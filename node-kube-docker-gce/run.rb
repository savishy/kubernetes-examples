# ruby script
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'common_utils'


unless Common_utils.which('gcloud').nil?
	system('gcloud')
end

jsonfile = File.read("config.json")
json_data = JSON.parse(jsonfile)
docker_login = "docker login -u " + json_data['docker_username'] + " -p " + json_data['docker_password']
puts "-- logging in to Docker Hub (user #{json_data['docker_username']} )"
system(docker_login)

puts "-- building image #{json_data['docker_image_name']}"
docker_image_name = "#{json_data['docker_username']}/#{json_data['docker_image_name']}:#{json_data['docker_image_version']}"

docker_build = "docker build -t #{docker_image_name} node-application"
puts docker_build
system(docker_build)

puts "-- pushing image #{docker_image_name}"
docker_push = "docker push #{docker_image_name}"
system(docker_push)