require 'peplum/john'
require 'pp'
require_relative 'rest/helpers'

# Boot up our REST server for easy integration.
rest_pid = Peplum::John::Application.spawn( :rest, daemonize: true )
at_exit { Cuboid::Processes::Manager.kill rest_pid }

# Wait for the REST server to boot up.
while sleep 1
  begin
    request :get
  rescue Errno::ECONNREFUSED
    next
  end

  break
end

# Assign an Agent to the REST service for it to provide us with Instances.
john_agent = Peplum::John::Application.spawn( :agent, daemonize: true )
request :put, 'agent/url', john_agent.url
at_exit { john_agent.shutdown rescue nil }

# Create a new Instance and run with the following options.
request :post, 'instances', {
  peplum: {
    objects:     %w(
      6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090
      36f583dd16f4e1e201eb1e6f6d8e35a2ccb3bbe2658de46b4ffae7b0e9ed872e
      c6b3e5102f268d17a60562720abeb625b0d3398289f46f51861f1bab3055e89d
      b962ac55407c25c159c4c9f3764145e1ecc9ae6a37cf376e8bc98d31633e9a61
    ),
    max_workers: 4
  },
  payload: {
    format: 'raw-sha256'
  }
}

# The ID is used to represent that instance and allow us to manage it from here on out.
instance_id = response_data['id']

while sleep( 1 )
  request :get, "instances/#{instance_id}/info/progress"
  ap response_data

  # Continue looping while instance status is 'busy'.
  request :get, "instances/#{instance_id}"
  break if !response_data['busy']
end

puts '*' * 88

# Get the report.
request :get, "instances/#{instance_id}/report.json"

# Print out the report.
puts JSON.pretty_generate( JSON.load( response_data['data'] ) )

# Shutdown the Instance.
request :delete, "instances/#{instance_id}"
