class Message < ApplicationRecord
  belongs_to :user
  belongs_to :match

  # not going to validate the seen_at yet until we implement it
  validates :content, presence: true
end
