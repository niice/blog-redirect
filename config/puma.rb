workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_PUMA_THREADS']  || 1), Integer(ENV['MAX_PUMA_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

quiet # don’t log requests, sinatra does this for us
