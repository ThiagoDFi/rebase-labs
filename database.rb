require 'pg'

module Database

  def self.connect
    PG.connect(
      host: 'postgres',
      port: 5432,
      dbname: 'medic',
      user: 'postgres',
      password: 'password'
    )
  end

  def self.execute(query)
    conn = connect
    result = conn.exec(query)
    conn.close
    result
  end
end