ENV["JULIA_PKG_DEVDIR"] = "$(ENV["HOME"])/Dropbox/juliadev"

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
