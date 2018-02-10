require 'csv'
begin
  ActiveRecord::Base.transaction do
    CSV.read(Rails.root.join("files", "stores.csv")).each do |row|

      store_params = {
        name: row[0],
        address: row[1],
        description: row[2],
        promotion_tag: "123",
        open_time: row[3],
        close_time: row[4]
      }
      s = Store.new(store_params)
      s.save!
    end

    Store.all.each do |s|
      4.times.with_index(1) do |_, i|
        s.store_images.create!({
          image: File.open(Rails.root.join("files", "images", "#{i}.png"))
        })
      end

      YAML.load_file(Rails.root.join("files", "menu.yml")).each do |row|

        menu = s.menus.create!({
          name: row["name"],
          price: row["price"],
          discounted_price: row["discount_price"]
        })

        4.times.with_index(1) do |_, i|
          menu.menu_images.create!({
            image: File.open(Rails.root.join("files", "images", "#{i}.png"))
          })
        end
      end

      YAML.load_file(Rails.root.join("files", "happyour.yml")).each do |row|
        7.times.each.with_index do |d|
          s.happyhours.create!({
            day_of_week: d,
            is_holiday: row["is_holiday"],
            start_time: row["start_time"],
            end_time: row["end_time"]
          })
        end
      end

      YAML.load_file(Rails.root.join("files", "hashtag.yml")).each do |row|
        s.hash_tags.create!({
          tag_name: row["name"]
        })
      end
    end
  end
rescue Exception => e
  Rails.logger.info e.message
end
