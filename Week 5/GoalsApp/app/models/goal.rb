class Goal < ActiveRecord::Base
  validates :description, :privacy_status, :completion_status, :user_id, presence: true

  belongs_to :user
  def self.users_visible_goals(user)
    Goal.where("privacy_status = 'public' OR (user_id = #{user.id} AND privacy_status = 'private')")
  end
end
