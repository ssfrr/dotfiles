ENV["EDITOR"] = "atom -a"

@info "Importing Revise"
try
    using Revise
    # Turn on Revise's automatic-evaluation behavior
    Revise.async_steal_repl_backend()
catch
    @warn "Could not load Revise"
end

@info "Importing OhMyREPL"
try
    using OhMyREPL
    colorscheme!("Monokai24bit")
catch
    @warn "Could not load OhMyREPL"
end

using Pkg
isfile("Project.toml") && Pkg.activate(".") # auto-activate Project in Juno
