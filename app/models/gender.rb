class Gender < ApplicationRecord
  GENDER = %w[male female non-binary].freeze

  has_many :users
  validates :name, presence: true, inclusion: { in: GENDER }
end
