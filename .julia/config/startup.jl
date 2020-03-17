ENV["JULIA_PKG_DEVDIR"] = "$(ENV["HOME"])/Dropbox/juliadev"
# pull in private data we don't want in the repository
include("startup_private.jl")
