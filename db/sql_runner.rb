require('pg')

class SqlRunner

  def self.run(sql, values)
    begin
      db = PG.connect( {dbname: 'moneycashboard',
      host: 'ec2-54-163-227-202.compute-1.amazonaws.com',
      port: 5432, user: 'nvihitttnilquo', password: '6cba439750409a744b65836381c3f51e00316de2fbacb47925b4842ffa8ef070'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close
    end
    return result
  end

end
