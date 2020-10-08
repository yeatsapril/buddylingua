class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :native_language, class_name: 'Language', optional: true
  belongs_to :target_language, class_name: 'Language', optional: true
  belongs_to :gender, optional: true
  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :matches
  has_many :messages

  validates :name, :address, :native_language, :target_language, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: true
  validates :target_language_level, presence: true, numericality: { only_integer: true }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one_attached :photo

  validate :check_native_language_and_target_language

  def check_native_language_and_target_language
    errors.add(:target_language, "can't be the same as native language") if target_language == native_language
  end

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

  def find_match(user)
    match = matches
    match.where('user_1_id = :id OR user_2_id = :id', { id: user.id })
  end

  def match_percentage(user)
    #compare self to user
    #full language match will give us 70 (the match percentage will be between 0 and 100).
      #my target to your native AND my native to your target.
    #half language match = 35.
      #my target language is your native OR your target is my native (but not both)
    #Ages are in a range of 5 years of each other, then 15.
    #Ages are in a range of 10- years of each other, then 7.
    #At least 2 interests in common would give 15. (full interest score)
    #1 interest in common would give 7. (half interest score).

    score = 0

    if native_language == user.target_language
      score += 35
    end
    if target_language == user.native_language
      score += 35
    end

    age_diff = (age - user.age).abs
    if age_diff <= 5
      score += 15
    elsif age_diff <= 10
      score += 7
    end

    common_interests = (interests & user.interests)
    if common_interests.size >= 2
      score += 15
    elsif common_interests.size == 1
      score += 7
    end
    return score
  end

end
