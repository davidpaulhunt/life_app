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

# --------------------------------

class School < ActiveRecord::Base
	# name, city, state

	STATES = [
		"TN",
		"TX",
		"VA",
	]

	YEARS = [ 10, 11, 12, 13, 14, "current"]
end

class Event < ActiveRecord::Base
	# title, date, why it matters

	# def self.search(term)
	# 	if term.is_a? String
	# 		@result = search_title(term)
	# 		@result << search_description(term)
	# 	else
	# 		@result = search_date(term)
	# 	end
	# 	return @result
	# end

	# def self.search_title(term)
	# 	Event.where( :title => term )
	# end

	# def self.search_description(term)
	# 	Event.where( :description => term )
	# end

	# def self.search_date(term)
	# 	Event.where( :date => term )
	# end


end