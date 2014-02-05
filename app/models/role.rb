class Role < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  validates :registered_user

  def registered_user
    unless user.registered_at
      errors.add(:user_id, "User must be registered")
    end
  end
end
