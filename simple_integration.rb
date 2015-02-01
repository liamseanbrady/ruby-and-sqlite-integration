require 'sqlite3'
require 'pry'

TABLE_NAME = 'cars'.freeze

class Car
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

cars = []
cars << Car.new('red')
cars << Car.new('blue')

db = SQLite3::Database.new "data/cars.sqlite3"
create_table = "CREATE TABLE cars (id INT PRIMARY KEY NOT NULL, color VARCHAR(255))"
db.execute(create_table) if db.table_info(TABLE_NAME).empty?

ids = db.execute("SELECT id FROM cars").flatten

cars.each_with_index do |car, idx|
  insert_row = "INSERT INTO #{TABLE_NAME} (id, color) VALUES (?, ?), [#{idx + 1}, car.color]"
  db.execute(insert_row) if !ids.include?(idx + 1)
end

