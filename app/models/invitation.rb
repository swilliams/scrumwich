class Invitation < ActiveRecord::Base
  belongs_to :project
  belongs_to :person

  validates :code, presence: true

  before_create :create_code

  def create_code
    self.code = SecureRandom.uuid
  end
end
