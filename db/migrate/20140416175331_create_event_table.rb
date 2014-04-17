class CreateEventTable < ActiveRecord::Migration
  def change
  	create_table 	:events do |t|
  		t.string 		:title
  		t.date 			:date
  		t.string		:description
  	end
  end
end
