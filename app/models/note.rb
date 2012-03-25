class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :animal
  
  before_create :create_uuid
  
  attr_accessible :note, :user_id, :animal_id
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end
