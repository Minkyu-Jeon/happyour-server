class Addr2Coord
  # lat: 위도, lng: 경도
  attr_reader :lat, :lng
  def initialize(addr)
    @addr = URI.encode(addr)
    @api_key = Rails.application.secrets.daum_api_key
    @url = "https://apis.daum.net"
  end

  def call
    conn = Faraday.new(:url => @url)
    response = conn.get "local/geo/addr2coord?apikey=#{@api_key}&output=json&q=#{@addr}"

    item = JSON.parse(response.body)["channel"]["item"].first

    lat = item.try(:[], "lat")
    lng = item.try(:[], "lng")

    return "#{lat},#{lng}"
  end
end
