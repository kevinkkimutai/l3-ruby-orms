class Student
  attr_accessor :name, :age, :id

  def initialize(name:, age:, id: nil)
    @id = id
    @name = name
    @age = age
  end

  # TODO: CREATE TABLE
  def self.create_table
    query = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL, age INTEGER NOT NULL)"

    DB[:conn].query(query)
  end

  # TODO: INSERT RECORD
  def create
    query = <<-SQL
            INSERT INTO students (name, age) VALUES (?, ?)
        SQL

    DB[:conn].query(query, self.name, self.age)
    setup_id
  end

  # TODO: SHOW ALL RECORDS
  def self.all
    query = <<-SQL
            SELECT * FROM students
        SQL

    DB[:conn].query(query).map do |row|
      convert_to_object(row)
    end
  end

  # TODO: UPDATE RECORD
  def update
    query = <<-SQL
            UPDATE students SET name = ?, age = ? WHERE name = ?
        SQL

    DB[:conn].query(query, self.name, self.age, self.name)
  end

  # TODO: DELETE RECORD
  def destroy
    query = <<-SQL
            DELETE FROM students WHERE name = ?
        SQL

    DB[:conn].query(query, self.name)
  end

  # TODO: CONVERT TABLE RECORD TO RUBY OBJECT
  def self.convert_to_object(row)
    self.new(id: row[0], name: row[1], age: row[2])
  end

  #reset table
  def self.reset
    query = <<-SQL
       DROP TABLE students
    SQL
    DB[:conn].query(query)
  end

  private

  def setup_id
    query = <<-SQL
   SELECT last_insert_rowid() FROM students
    SQL
    self.id = DB[:conn].execute(query)[0][0]
  end

  # TODO: SEARCH FOR RECORD THAT MEETS CERTAIN CONDITIONS
  def self.search_by(name: nil, age: nil)
    data = if name && age
        query = <<-SQL
    SELECT * FROM students WHERE name =? AND age =?
    SQL
        DB[:conn].query(query, name, age)
      elsif name
        query = <<-SQL
        SELECT * FROM students WHERE name =?
        SQL
        DB[:conn].query(query, name)
      elsif age
        query = <<-SQL
            SELECT * FROM students WHERE age =?
            SQL
        DB[:conn].query(query, age)
      else
        query = <<-SQL
            SELECT * FROM students
            SQL
        DB[:conn].query(query)
      end
    data.map do |row|
      convert_to_object(row)
    end
  end
end
