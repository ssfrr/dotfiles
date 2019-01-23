ENV["EDITOR"] = "atom -a"
ENV["JULIA_PKG_DEVDIR"] = "$(ENV["HOME"])/Dropbox/juliadev"

atreplinit() do repl
    @info "Importing Revise"
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
        @warn "Could not load Revise"
    end
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
