class UserInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :user, dependent: :destroy
end
