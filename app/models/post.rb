class Post < ApplicationRecord
  belongs_to :user

  scope :post_owner, ->(user) {where("user_id = ?", user)}
end
