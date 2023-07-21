require 'csv'

require_relative 'database'

conn = PG.connect(
  host: 'postgres',
  port: 5432,
  dbname: 'medic',
  user: 'postgres',
  password: 'password'
)

rows = CSV.read("./data.csv", col_sep: ';')
  columns = rows.shift

  column_names_attr = columns.map { |column| column.gsub(" ", "_").gsub("/", "_") }.join(' VARCHAR(100), ') + ' VARCHAR(100)'
  create_table = "CREATE TABLE IF NOT EXISTS exams (#{column_names_attr})"
  Database.execute(create_table)

  rows.each do |row|
    values = row.map { |value| "'#{value.gsub("'", "''")}'" }.join(', ')
    column_names = columns.map { |column| column.gsub(" ", "_").gsub("/", "_") }.join(', ')
    insert_info = "INSERT INTO exams (#{column_names}) VALUES (#{values})"
    Database.execute(insert_info)
  end

conn.close