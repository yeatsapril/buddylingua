class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :native_language, class_name: 'Language', optional: true
  belongs_to :target_language, class_name: 'Language', optional: true

  def buddies
    # all users where we have a match with us, but arent us (passes in to function below for this)
    # compares the matches retrieved, and returnes the id that isn't the current user
    # checking if each id is only matched with each other once (unique matches)
    User.joins(
      "INNER JOIN matches m
      ON (users.id = m.user_1_id OR users.id = m.user_2_id)"
    ).where(
      "(user_1_id = :id OR user_2_id = :id) AND users.id != :id", id: id
    ).distinct
  end

  def matches
    # retrieveing all the matches that this user is a a part of
    Match.where('user_1_id = :id OR user_2_id = :id', { id: id })
  end
end
