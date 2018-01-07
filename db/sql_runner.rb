require('pg')

class SqlRunner

  def self.run(sql, values)
    begin
      db = PG.connect( {
      dbname: 'moneycashboard',
      host: 'localhost',
      # port: 4567, user: 'nvihitttnilquo', password: '6cba439750409a744b65836381c3f51e00316de2fbacb47925b4842ffa8ef070'
      })
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close
    end
    return result
  end

end
