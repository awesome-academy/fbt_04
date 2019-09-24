4.times do |n|
  name  = Faker::Name.name
  Category.create!(name: name)
end


30.times do |n|
  categorys = Category.all
  name  = Faker::Name.name
  category = categorys[1..3]
  category.each { |item|
  Tour.create!(
    name: name,
    price: n*10,
    category: item
  )
  }
end

30.times do |n|
  name = Faker::Name.name
  email = "tranngoc-#{n+1}@gmail.com"
  password = "password"
  User.create!(
    fullname: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

30.times do |n|
  users = User.all
  tours = Tour.all
  # name = Faker::Company.name
  content = Faker::Pokemon.name
  user = users[1..10]
  tour = tours[1..3]
  user.each do |user|
    tour.each do |tour|
      Review.create(
        tour_id: tour.id,
        user_id: user.id,
        content: content
      )
    end
  end
end

10.times do |n|
  users = User.all
  tours = Tour.all
  reviews = Review.all
  content = Faker::Company.name
  user = users[0..3]
  tour = tours[0..3]
  review = reviews[0..3]
  user.each do |user|
    tour.each do |tour|
      Comment.create(
        commentable_id: tour.id,
        commentable_type: tour.class,
        user_id: user.id,
        content: content
      )
    end
  end
  user.each do |user|
    review.each do |review|
      Comment.create(
        commentable_id: review.id,
        commentable_type: review.class,
        user_id: user.id,
        content: content
      )
    end
  end
end
