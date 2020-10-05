class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # if things get slow, probably a good idea to review this code block
  def buddies
    # all users where we have a match with us, but arent us (passes in to function below for this)
    users = matches.map do |match|
      # compares the matches retrieved, and returnes the id that isn't the current user
      if match.user_1 == self
        match.user_2
      else
        match.user_1
      end
    end
    # checking if each id is only matched with each other once (unique matches)
    users.uniq
  end

  def matches
    # retrieveing all the matches that this user is a a part of
    Match.where('user_1_id = :id OR user_2_id = :id', { id: id })
  end
end
