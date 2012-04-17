class Klink < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :picture_uri
  belongs_to :user

  validates :user_id, presence: true
  validates :picture_uri, presence: true
  # TODO: acrescentar validates para picture_uri, latitude e longitude quando se usar o API do Flickr

  default_scope order: 'klinks.created_at DESC'
end
