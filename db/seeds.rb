# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  User.create(
    name: "testuser#{n+1}",
    email: "testuser#{n+1}@test.com",
    password: "testuser#{n+1}",
  )
  Book.create(
    title: "testbook#{n+1}",
    body: "testbook#{n+1}",
    user_id: n+1,
    created_at: Time.current - (n+1).to_i.day
  )
end 

Group.create(
  name: "Test Group",
  introduction: "Test Event Body",
  owner_id: 1
)

# Userそれぞれに対して、10レコードずつBookを作成
# 現在時刻から 0 ~ 15 までのランダムな数字を引いた時刻でBookを作成

User.all.each do |user|
  10.times do |n|
    Book.create(
      title: "testbook#{n+1}",
      body: "testbook#{n+1}",
      user_id: user.id,
      created_at: Time.current - rand(15).day
    )
  end
end

i = User.first.id

# Bookそれぞれに対してUser(1 ~ i)とのFavoriteを作成する。
# Bookのidが大きくなるほど紐つけられるFavoriteモデルの数が多くなる。
# Favoriteの作成時刻に違いを出すために「現在時刻 - i」 の時刻で作成している。

i = User.first.id # usersテーブル内の最初のレコードのidを取得

Book.all.each do |book|
  for user_id in 1..i do
    Favorite.create(
      user_id: user_id,
      book_id: book.id,
      created_at: Time.current - i.day
    )
  end
  i+=1
end