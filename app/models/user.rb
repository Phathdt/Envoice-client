class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :rememberable,
          :validatable, :invitable, :async

  enum role: { staff: 0, owner: 1 }

  def active_for_authentication?
    super && !blocked
  end
end
