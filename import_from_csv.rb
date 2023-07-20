require 'pg'

conn = PG.connect(
  host: 'postgres',
  port: 5432,
  dbname: 'medic',
  user: 'postgres',
  password: 'password'
)

result = conn.exec("SELECT * FROM exams")
result.each do |row|
  puts row 
end

conn.close