class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum status: { online: 'online', away: 'away', offline: 'offline' }, _default: :offline

  has_one_attached :avatar, dependent: :destroy

  validates :avatar, attached: true, content_type: %w[image/png image/jpeg image/gif image/jpg]
  validates :name, presence: true

  after_update_commit :broadcast_update_user_status, if: :has_status_changes?
  after_update_commit :broadcast_append_users, if: :is_confirmed?
  after_destroy_commit :broadcast_remove_user

  scope :all_except, ->(ids) { where.not(id: ids) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def broadcast_update_user_status
    broadcast_replace_later_to [self, 'status'], partial: 'users/status', locals: { user: self.decorate },
                               target: "user_#{id}_status"
  end

  def broadcast_append_users
    broadcast_append_later_to "users", partial: "chat/sidebar/user", locals: { user: self.decorate }, target: "users"
  end

  def broadcast_remove_user
    broadcast_remove_to "users", target: "user_#{self.id}"
  end

  private

  def has_status_changes?
    previous_changes['status'].present?
  end

  def is_confirmed?
    previous_changes['confirmed_at'].present?
  end
end
