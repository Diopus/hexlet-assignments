#sjson.array! @user_posts, partial: "api/v1/users/posts", as: :post
json.extract! @user, :id, :email, :address
json.full_name [@user.first_name, @user.last_name].join(" ")

json.posts do
  json.array! @user_posts, partial: "api/v1/users/posts", as: :post
end
