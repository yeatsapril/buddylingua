class Language < ApplicationRecord
  LANGUAGE = %w[english spanish french german italian norwegian swedish danish polish lithuanian croatian russian].freeze

  belongs_to :user, dependent: :destroy
  validates :name, presence: true, inclusion: { in: LANGUAGE }
end
