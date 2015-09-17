reactor_highstate:
  cmd.state.highstate
    - tgt: {{ data['name'] }}
