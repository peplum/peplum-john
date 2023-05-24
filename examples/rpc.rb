require 'pp'
require 'peplum/john'

# Spawn an Agent as a daemon.
john_agent = Peplum::John::Application.spawn( :agent, daemonize: true )
at_exit { john_agent.shutdown rescue nil }

# Spawn and connect to an Instance.
john = Peplum::John::Application.connect( john_agent.spawn )
# Don't forget this!
at_exit { john.shutdown }

john.run(
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
)

# Waiting to complete.
while john.running?
  ap john.info.progress
  sleep 1
end

# Hooray!
puts JSON.pretty_generate( john.generate_report.data )
