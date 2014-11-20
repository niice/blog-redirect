$: << File.expand_path('../../', __FILE__)
$: << File.expand_path('../../lib', __FILE__)

ENV['RACK_ENV'] ||= 'development'

require "bundler"
Bundler.require :default, ENV['RACK_ENV'].to_sym

class App < ::Sinatra::Base
  BASE_BLOG_URL = "https://niice.co/blog"
  set :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }

  configure do
    enable :raise_errors, :logging
  end

  configure :development do
    enable :show_exceptions
    set :static_cache_control, [:private, max_age: 0, must_revalidate: true]
  end

  configure :production do
    set :static_cache_control, [:public, max_age: 86400]
  end

  get "/" do
    redirect blog_url, 301
  end

  get "/:year/:month/:slug/?" do
    redirect post_url(params[:slug]), 301
  end

  def blog_url
    "#{BASE_BLOG_URL}"
  end

  def post_url(slug)
    "#{BASE_BLOG_URL}/#{slug}"
  end

end
