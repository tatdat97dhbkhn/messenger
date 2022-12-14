# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :string           default("offline"), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Filterable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :not_broadcast

  enum status: { online: 'online', away: 'away', offline: 'offline' }, _default: :offline

  has_one_attached :avatar, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :message_reactions, dependent: :destroy
  has_many :message_notifications, dependent: :destroy
  has_many :joinables, dependent: :destroy
  has_many :joined_channels, through: :joinables, source: :channel
  has_many :admin_channels, class_name: 'Channel', foreign_key: :creator_id

  validates :avatar, attached: true, content_type: %w[image/png image/jpeg image/gif image/jpg]
  validates :name, presence: true

  after_update_commit :broadcast_update_user_status, if: :has_status_changes?
  # after_update_commit :broadcast_append_users, if: -> { is_confirmed? && !not_broadcast }
  # after_destroy_commit :broadcast_remove_user

  scope :all_except, ->(ids) { where.not(id: ids) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def broadcast_update_user_status
    broadcast_replace_later_to [self, 'status'], partial: 'users/status', locals: { user: decorate },
                                                 target: "user_#{id}_status"
  end

  def broadcast_remove_user
    broadcast_remove_to 'users', target: "user_#{id}"
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def has_status_changes?
    previous_changes['status'].present?
  end

  def is_confirmed?
    previous_changes['confirmed_at'].present?
  end
end
