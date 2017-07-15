begin
  ActiveRecord::Base.transaction do
    10.times do
      store_params = {
        name: Faker::Name.name,
        address: Faker::Address.city + " " + Faker::Address.street_address,
        description: Faker::Lorem.paragraph,
        code: Store.code,
        open_time: "10:00:00",
        close_time: "23:00:00"
      }

      s = Store.new(store_params)
      s.save!
    end
  end
rescue Exception => e
  Rails.logger.info e.message
end
