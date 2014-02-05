class Moderator < Role
  validate :type, uniqueness: {scope: :user_id}
  validate :unique_with_admin

  private
  def unique_with_admin
    if Role.where(type: "Admin", user_id: user_id).count > 0
      errors.add(:type, "Cannot be a moderator while already an admin")
    end
  end
end
