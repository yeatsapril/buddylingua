class Language < ApplicationRecord
  LANGUAGE = %w[english spanish french german italian norwegian swedish danish polish lithuanian croatian russian].freeze

  has_many :users
  validates :name, presence: true, inclusion: { in: LANGUAGE }
end
