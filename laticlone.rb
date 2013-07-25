require "rubygems"
require "bundler"
require "sinatra"
require "uri"
require "pg"
require "pusher"

set :database, ENV['DATABASE_URL'] || 'postgres://localhost/laticlone_dev'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end
end

configure do
  db = URI.parse(settings.database)
  DB = PG.connect({
    :host => db.host,
    :user => db.user,
    :password => db.password,
    :port => db.port || 5432,
    :dbname => db.path[1..-1]
  })
end

get "/?" do
  @serverurl = "#{base_url}/loc"
  @locations = DB.exec "SELECT * FROM locations ORDER BY created_at DESC LIMIT 5"
  @newest_location = @locations[0]

  erb :index
end

post '/loc' do
  lat = params[:latitude].to_f
  lon = params[:longitude].to_f
  acc = params[:accuracy].to_f

  DB.exec_params("INSERT INTO locations (lat, lon, acc, created_at) VALUES ($1, $2, $3, NOW())", [lat, lon, acc])

  Pusher.trigger('locations', 'new_location', {
    :lat => lat,
    :lon => lon,
    :acc => acc,
    :time => Time.now.strftime("%d.%m.%Y %H:%M:%S")
  })

  "200 OK.\nLast Update: #{Time.now.to_i}"
end