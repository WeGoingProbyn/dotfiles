local dap = require('dap')
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.configurations.fortran = {
  {
    name = "Attach to localhost:9091",
    type = "gdb",
    request = "launch",
    miDebuggerServerAddress = "localhost:9091",
    stopOnEntry = false,
  },
}
