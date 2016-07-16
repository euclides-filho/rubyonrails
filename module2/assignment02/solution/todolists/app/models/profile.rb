class Profile < ActiveRecord::Base
  belongs_to :user
  validate :first_name_last_name
  validate :sue_gender
  validates :gender, inclusion: {in: %w{male female}, message: "%{value} is not male or female" }
 
  def first_name_last_name
    errors.add(last_name ? :last_name : :first_name, "first_name and last_name cannot be both nil") unless (first_name || last_name)
  end

  def sue_gender
  	if (gender == "male" && first_name == "Sue")
  		errors.add(:first_name, "Sue cannot be male") 
  	end
  end

  def self.get_all_profiles(min_birth_year, max_birth_year)
  	Profile.where(
  		"birth_year BETWEEN :min_birth_year and :max_birth_year", 
  		{min_birth_year: min_birth_year, max_birth_year: max_birth_year}
  		).order({birth_year: :asc})
  end

end