class Coment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pin
end
