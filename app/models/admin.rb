class Admin < Moderator
  validate :type, uniqueness: {scope: :user_id}
  validate :unique_with_moderator

  private
  def unique_with_moderator
    if Role.where(type: "Moderator", user_id: user_id).count > 0
      errors.add(:type, "Cannot be an admin while already a moderator")
    end
  end
end
