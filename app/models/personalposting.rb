class Personalposting < ActiveRecord::Base
    belongs_to :user
    include ActiveModel::ForbiddenAttributesProtection

    validates_presence_of :user_id, :content

    default_scope :order => 'personalpostings.created_at desc'
end
