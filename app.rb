require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite:///life_app.db"


get '/events' do
	@events = Event.all
	erb :"events/index"
end

get '/events/new' do
	erb :"events/new"
end

get '/events/:id' do
	@event = Event.find(params[:id])
	erb :"events/show"
end

get '/events/:id/edit' do
	@event = Event.find(params[:id])
	erb :"events/edit"
end

post '/events' do
	event = Event.new(params[:new_event])
	if event.save
		redirect '/events'
	else
		"error"
	end
end

put "/events/:id" do
	@event = Event.find(params[:id])
	if @event.update_attributes(params[:event])
		redirect "/events/#{@event.id}"
	else
		"error"
	end
end

get '/events/:id/delete' do
	@event = Event.find(params[:id])
	erb :"events/delete"
end

delete '/events/:id' do
	event = Event.find(params[:id])
	if event.delete
		redirect "/events"
	else
		"error"
	end
end

# ToDo.where('INNER JOIN users ON to_dos.user_id = users.id WHERE users.name = ?', params[:search])

# select * from to_dos
# inner join users on to_dos.


post '/events/search_results' do
	search = "%#{params[:search]}%"
	@events = Event.where("title LIKE ? OR date LIKE ? OR description LIKE ?", search, search, search)
	erb :"events/search_results"
end

# --------------------------------
get '/schools' do
	@schools = School.all
	erb :"schools/index"
end

get '/schools/new' do
	erb :"schools/new"
end

post '/schools' do
	school = School.new(params[:new_school])
	if school.save
		redirect '/schools'
	else
		"error"
	end
end

get '/schools/:id' do
	@school = School.find(params[:id])
	erb :"schools/show"
end

get '/schools/:id/edit' do
	@school = School.find(params[:id])
	erb :"schools/edit"
end

put "/schools/:id" do
	@school = School.find(params[:id])
	if @school.update_attributes(params[:school])
		redirect "/schools/#{@school.id}"
	else
		"error"
	end
end

get '/schools/:id/delete' do
	@school = School.find(params[:id])
	erb :"schools/delete"
end

delete '/schools/:id' do
	school = School.find(params[:id])
	if school.delete
		redirect '/schools'
	else
		"error"
	end
end

# --------------------------------

class School < ActiveRecord::Base
	# name, city, state

	STATES = [
		"AL",
		"AL",
		"AK",
		"AZ",
		"AR",
		"CA",
		"CO",
		"CT",
		"DE",
		"FL",
		"GA",
		"HI",
		"ID",
		"IL",
		"IN",
		"IA",
		"KS",
		"KY",
		"LA",
		"ME",
		"MD",
		"MA",
		"MI",
		"MN",
		"MS",
		"MO",
		"MT",
		"NE",
		"NV",
		"NH",
		"NJ",
		"NM",
		"NY",
		"NC",
		"ND",
		"OH",
		"OK",
		"OR",
		"PA",
		"RI",
		"SC",
		"SD",
		"TN",
		"TX",
		"UT",
		"VT",
		"VA",
		"WA",
		"WV",
		"WI",
		"WY"
	]

	YEARS = [ 2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014, "current"]
end

class Event < ActiveRecord::Base
	# title, date, why it matters

	def self.search_db(term)
		@searchables = []
		Event.all.each do |a|
			@searchables << a.title
		end
		@results = []
		@searchables.each do |x|
			if /term/.match(x)
				@results << x
			end
		end
		@display = []
		Event.all.each do |x|
			@results.each do |y|
				if x.title == y
					@display << x.id
				end
			end
		end
		return @display
	end


end