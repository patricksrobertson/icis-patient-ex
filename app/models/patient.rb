class Patient < ActiveRecord::Base
  RANDOM_CONSTRAINT_RANGE = (100..400).to_a

  attr_accessible :first_name, :last_name, :photo_url, :uid

  before_create :set_uid
  before_create :set_placekitten

  def to_s
    "#{first_name} #{last_name}"
  end

  private

  def set_uid
    self.uid = SecureRandom.hex(32)
  end

  def set_placekitten
    self.photo_url = "http://placekitten.com/#{RANDOM_CONSTRAINT_RANGE.sample}/#{RANDOM_CONSTRAINT_RANGE.sample}"
  end
end
