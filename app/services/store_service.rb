class StoreService
  def initialize

  end

  def around(gps)
    gpss = gps.split(",")

    lat = gpss.first
    lng = gpss.last

    sql = <<-SQL
      SELECT *, (
        111.111 * (
          DEGREES(ACOS(COS(RADIANS(:lat1))
            * COS(RADIANS(lat2))
            * COS(RADIANS(:lng1 - lng2))
            + SIN(RADIANS(:lat1))
            * SIN(RADIANS(lat2))))
        )
      ) dist
      FROM #{Store.table_name}
      JOIN (
        SELECT id, SUBSTRING_INDEX(gps, ',', 1) lat2, SUBSTRING_INDEX(gps, ',', -1) lng2
        FROM #{Store.table_name}
      ) B ON #{Store.table_name}.id = B.id
      ORDER BY dist
    SQL

    Store.find_by_sql([sql, {lat1: lat, lng1: lng}])
  end
end
