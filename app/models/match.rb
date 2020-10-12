class Match < ApplicationRecord
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  has_many :messages, dependent: :destroy

  def other_user(user)
    return user_1 if user_2_id == user.id
    return user_2
  end
end
