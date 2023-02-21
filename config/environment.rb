require 'bundler'
Bundler.require

DB = { conn: SQLite3::Database.new("db/school.db") }
require_relative '../lib/student'
Student.reset

# RUN CODE FROM HERE
# create table
Student.create_table

#RESET tabe


#create students
s1 = Student.new(name: "John Doe", age: 25)
s2 = Student.new(name: "Jane Doe", age: 26)
s3 = Student.new(name: "Joe Doe", age: 27)

#insert students
s1.create
s2.create
s3.create

#view  students data
pp Student.all

#chect students
pp "student 1: #{s1}"
print "SEARCH RESULTS:"
pp Student.search_by(name: "John Doe")

# # student data
# ian = Student.new(age: 12, name: "Student")
# # insert record
# ian.create

# # view all students
# Student.all

# # update student data
# # ian.name = "Ian"
# ian.age = 90
# ian.update

# Student.all

# ian.destroy

# Student.all
