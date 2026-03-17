# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = Admin.find_or_initialize_by(email_address: "admin@example.com")
admin.password = "password"
admin.save!

customer_seeds = [
  {
    last_name: "山田",
    first_name: "太郎",
    last_name_kana: "ヤマダ",
    first_name_kana: "タロウ",
    email_address: "yamada@example.com",
    postal_code: "1000001",
    address: "東京都千代田区1-1-1",
    telephone_number: "09011112222",
    password: "password",
    is_active: true
  },
  {
    last_name: "佐藤",
    first_name: "花子",
    last_name_kana: "サトウ",
    first_name_kana: "ハナコ",
    email_address: "sato@example.com",
    postal_code: "1500001",
    address: "東京都渋谷区2-2-2",
    telephone_number: "09033334444",
    password: "password",
    is_active: true
  },
  {
    last_name: "鈴木",
    first_name: "一郎",
    last_name_kana: "スズキ",
    first_name_kana: "イチロウ",
    email_address: "suzuki@example.com",
    postal_code: "5300001",
    address: "大阪府大阪市3-3-3",
    telephone_number: "09055556666",
    password: "password",
    is_active: true
  },
  {
    last_name: "高橋",
    first_name: "美咲",
    last_name_kana: "タカハシ",
    first_name_kana: "ミサキ",
    email_address: "takahashi@example.com",
    postal_code: "4600001",
    address: "愛知県名古屋市4-4-4",
    telephone_number: "09077778888",
    password: "password",
    is_active: true
  },
  {
    last_name: "退会",
    first_name: "ユーザー",
    last_name_kana: "タイカイ",
    first_name_kana: "ユーザー",
    email_address: "withdrawn@example.com",
    postal_code: "0600001",
    address: "北海道札幌市5-5-5",
    telephone_number: "09099990000",
    password: "password",
    is_active: false
  }
]

customers = customer_seeds.map do |attrs|
  customer = Customer.find_or_initialize_by(email_address: attrs[:email_address])
  customer.assign_attributes(attrs.except(:email_address, :password))
  customer.password = attrs[:password]
  customer.save!
  customer
end

genres = ["ケーキ", "プリン", "焼き菓子", "キャンディ"].map do |genre_name|
  Genre.find_or_create_by!(name: genre_name)
end

[
  {
    genre: genres[0],
    name: "いちごショート",
    introduction: "ふわふわスポンジと甘酸っぱいいちごを使った定番ケーキです。",
    price: 450,
    is_active: true
  },
  {
    genre: genres[0],
    name: "チョコレートケーキ",
    introduction: "濃厚なチョコレートの味わいが楽しめる人気商品です。",
    price: 500,
    is_active: true
  },
  {
    genre: genres[1],
    name: "なめらかプリン",
    introduction: "口どけの良い食感に仕上げた定番プリンです。",
    price: 300,
    is_active: true
  },
  {
    genre: genres[1],
    name: "カスタードプリン",
    introduction: "卵のコクをしっかり感じられる昔ながらのプリンです。",
    price: 320,
    is_active: true
  },
  {
    genre: genres[2],
    name: "フィナンシェ",
    introduction: "バターの香りが豊かな焼き菓子です。",
    price: 220,
    is_active: true
  },
  {
    genre: genres[2],
    name: "マドレーヌ",
    introduction: "しっとり食感で食べやすい定番焼き菓子です。",
    price: 200,
    is_active: true
  },
  {
    genre: genres[3],
    name: "フルーツキャンディ",
    introduction: "フルーツ風味を楽しめるカラフルなキャンディです。",
    price: 150,
    is_active: true
  },
  {
    genre: genres[3],
    name: "ミルクキャンディ",
    introduction: "やさしい甘さのミルク味キャンディです。",
    price: 140,
    is_active: true
  }
].each do |attrs|
  item = Item.find_or_initialize_by(name: attrs[:name])
  item.assign_attributes(attrs.except(:name))
  item.save!
end

[
  {
    customer: customers[0],
    postal_code: "1010001",
    address: "東京都千代田区配送先1-1-1",
    name: "山田太郎 自宅"
  },
  {
    customer: customers[0],
    postal_code: "1010002",
    address: "東京都千代田区配送先2-2-2",
    name: "山田太郎 実家"
  },
  {
    customer: customers[1],
    postal_code: "1500002",
    address: "東京都渋谷区配送先3-3-3",
    name: "佐藤花子 自宅"
  }
].each do |attrs|
  Address.find_or_create_by!(
    customer: attrs[:customer],
    postal_code: attrs[:postal_code],
    address: attrs[:address],
    name: attrs[:name]
  )
end
