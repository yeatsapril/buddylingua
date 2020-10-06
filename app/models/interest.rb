class Interest < ApplicationRecord
  INTEREST = %w[food technology animals travelling books gaming art gardening carpenting films sports culture socializing].freeze

  has_many :user_interests, dependent: :destroy
  validates :name, presence: true, inclusion: { in: INTEREST }
end
