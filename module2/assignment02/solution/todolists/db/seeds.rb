# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'
require 'pp'
User.destroy_all

def get_item(i, due_date)
	TodoItem.create({completed: false, title: "t #{i}", due_date: due_date, description: "blah #{i}"})
end

def get_items(n, due_date)
	n.times.map { |i| get_item(i, due_date) }
end

def get_user(name, birth_year, gender, n)
	first_name, last_name = name.split " "
	due_date = Date.today
	user = User.create({username: last_name, password_digest: "#{last_name}#{birth_year}"})
	user.profile = Profile.create({first_name: first_name, last_name:last_name, birth_year: birth_year, gender: gender})
	user.todo_lists = TodoList.create([{list_due_date: due_date, todo_items:get_items(n, due_date)}])
	user.save
	user
end


pp get_user("Carly Fiorina", 1954, "female", 5)
pp get_user("Donald Trump", 1946, "male", 5)
pp get_user("Ben Carson", 1951, "male", 5)
pp get_user("Hillary Clinton", 1947, "female", 5)