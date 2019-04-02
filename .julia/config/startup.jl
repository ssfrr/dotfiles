ENV["JULIA_PKG_DEVDIR"] = "$(ENV["HOME"])/Dropbox/juliadev"

# erase the prompt so the following log message look nice
print("\r")

using Pkg
if isfile("Project.toml")
    # auto-activate project in current directory
    @info "Activating project in $(pwd())"
    Pkg.activate(".")
end

@info "Importing Revise"
try
    using Revise
    # configure Revise to run revise() before every REPL eval
    Revise.async_steal_repl_backend()
catch ex
    @warn "Could not load Revise: $ex"
end

@info "Importing OhMyREPL"
try
    using OhMyREPL
    colorscheme!("Monokai24bit")
catch ex
    @warn "Could not load OhMyREPL: $ex"
end

# redisplay the prompt so we know we're done
using REPL: REPL
REPL.LineEdit.refresh_line(Base.active_repl.mistate)
