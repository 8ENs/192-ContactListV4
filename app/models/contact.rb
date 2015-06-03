class Contact < ActiveRecord::Base
  has_many :phones

  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true,
                    format: { with: /\A[a-zA-Z]+[-_\.]*[a-zA-Z0-9]+@[a-zA-Z]+[-_\.]*[a-zA-Z0-9]+\.[a-zA-Z0-9]{2,}\z/, message: "must be valid email" }
 
  def echo
    "#{id}: #{firstname} #{lastname} (#{email})#{self.phone_mash}"
  end

  def phone_mash
    phone_mash = ""
    phones.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
    phone_mash
  end

end