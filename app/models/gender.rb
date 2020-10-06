class Gender < ApplicationRecord
  GENDER = %w[male female non-binary].freeze

  belongs_to :user, dependent: :destroy
  validates :name, presence: true, inclusion: { in: GENDER }
end
