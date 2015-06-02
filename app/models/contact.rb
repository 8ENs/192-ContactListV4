class Contact < ActiveRecord::Base
  has_many :phones

  # validates (TODO ADD LATER)
 
  def to_s
    "#{id}: #{lastname}, #{firstname} (#{email})#{self.phone_mash}"
  end

  def phone_mash
    phone_mash = ""
    phones.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
    phone_mash
  end

end