begin
  ActiveRecord::Base.transaction do
    addrs = [
      "서울 서대문구 이화여대길 1",
      "서울 마포구 신촌로4길 3",
      "서울 마포구 신촌로4길 5-26",
      "서울 강남구 강남대로 616 (신사미타워)",
      "경기 남양주시 경춘로양골1길 35",
      "경기 남양주시 경춘로 1502 (SK호평충전소)",
      "경기 성남시 분당구 경부고속도로 409",
      "서울 마포구 성미산로 51 (홍익대학교)",
      "서울 마포구 월드컵북로 5",
      "서울 종로구 경교장길 5"
    ]
    i = 0
    10.times do
      store_params = {
        name: Faker::Name.name,
        address: addrs[i],
        description: Faker::Lorem.paragraph,
        code: Store.code,
        open_time: "10:00:00",
        close_time: "23:00:00"
      }
      i += 1
      s = Store.new(store_params)
      s.save!
    end
  end

  ActiveRecord::Base.transaction do
    Store.all.each do |s|
      s.menus.create!({
        name: Faker::Name.name,
        price: Faker::Number.number(5).to_i.round(-4),
        discounted_price: 500
      })

      7.times.each.with_index do |d|
        s.happyhours.create!({
          day_of_week: d,
          is_holiday: false,
          start_time: "10:00:00",
          end_time: "12:00:00"
        })
      end

      s.hash_tags.create!({
        tag_name: Faker::Name.name
      })
    end
  end

  ActiveRecord::Base.transaction do
    # 친구 추가시 제공하는 무료 구독
    Subscription.create!({
      title: "친구 초대 무료 구독권",
      subscription_type: 0,
      days: 30
    })
  end
rescue Exception => e
  Rails.logger.info e.message
end
