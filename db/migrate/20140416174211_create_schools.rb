class CreateSchools < ActiveRecord::Migration
  def change
  	create_table :schools do |t|
  		t.string :name
  		t.string :state
  		t.integer :year_begin
  		t.integer :year_end
  	end
  end
end
