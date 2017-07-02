express	= require 'express'
app		= express()
pug		= require 'pug'
#app.engine 'pug', pug.__express
app.set 'view engine', 'pug'
#app.set 'views', "#{ process.cwd() }/public"

#process.env.NODE_ENV	= 'production'

#console.log process.env
#console.log process.cwd()

app.set 'port', process.env.PORT or 3000

app.use express.static "#{ __dirname }/public"

app.get '/', (req, res) ->
	res.render 'home', title: 'Home Page', message: 'Hello World!'
app.get '/about', (req, res) ->
	res.render 'about', title: 'About Page', message: 'About~'
# 404 Page
app.use (req, res, next) ->
	res.status 404
	res.render '404'
# 500 Page
app.use (err, req, res, next) ->
	console.error err.stack
	res.status 500
	res.render '500'

app.listen app.get('port'), ->
	console.log "Express started on http://localhost:#{ app.get 'port' }; press Ctrl-C to terminate."







return
http	= require 'http'
fs		= require 'fs'

serveStaticFile	= (res, path, contentType, responseCode) ->
	responseCode	?= 200
	fs.readFile __dirname + path, (err, data) ->
		if err
			res.writeHead 500, 'Content-Type': 'text/plain'
			res.end '500 - Internal Error'
		else
			res.writeHead responseCode, 'Content-Type': 'text/plain'
			res.end data

http.createServer (req, res) ->
	path	= req.url.replace /\/?(?:\?.*)?$/, ''
	path	= path.toLowerCase()
	switch path
		when ''
			serveStaticFile res, '/public/home.html', 'text/html'
		when '/about'
			serveStaticFile res, '/public/about.html', 'text/html'
		when '/img/logo'
			serveStaticFile res, '/public/images/logo.jpg', 'image/jpeg'
		else
			serveStaticFile res, '/public/404.html', 'text/html'

.listen 3000

console.log 'Server started on localhost:3000; press Ctrl-C to terminate...'
