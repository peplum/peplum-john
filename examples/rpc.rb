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
    ),
    max_workers: 2
  },
  payload: {
    format: 'raw-sha256'
  }
)

# Waiting to complete.
sleep 1 while john.running?

# Hooray!
puts JSON.pretty_generate( john.generate_report.data )
