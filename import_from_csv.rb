require 'csv'
require_relative 'database'

module ImportFromCsv
  def self.create_table_if_not_exists(columns)
    column_names_attr = columns.map { |column| column.gsub(" ", "_").gsub("/", "_") }.join(' VARCHAR(100), ') + ' VARCHAR(100)'
    create_table = "CREATE TABLE IF NOT EXISTS exams (#{column_names_attr})"
    Database.execute(create_table)
  end

  def self.insert_data(rows, columns)
    rows.each do |row|
      values = row.map { |value| "'#{value.gsub("'", "''")}'" }.join(', ')
      column_names = columns.map { |column| column.gsub(" ", "_").gsub("/", "_") }.join(', ')
      insert_info = "INSERT INTO exams (#{column_names}) VALUES (#{values})"
      Database.execute(insert_info)
    end
  end
end

  rows = CSV.read('./data.csv', col_sep: ';')
  columns = rows.shift

  ImportFromCsv.create_table_if_not_exists(columns)
  ImportFromCsv.insert_data(rows, columns)
