class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Pagination
  paginates_per 100

  # Validations
  # :email
  validates_format_of :email, with: /[Aa](\d+)@itesm\.mx/

  def self.paged(page_number)
    order(admin: :desc, email: :asc).page page_number
  end

  def self.search_and_order(search, page_number)
    if search
      where("email LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, email: :asc
      ).page page_number
    else
      order(admin: :desc, email: :asc).page page_number
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","email","created_at")
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select("id","email","last_sign_in_at")
  end

  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end

  def student_id
    email.delete("@itesm.mx")
  end

  def mongo_id
    student_id.delete("A").delete("a")
  end

  def allowed_permits
    UserPermit.all.where(granting_user: student_id)  
  end

  def friends
    UserPermit.all.where(granted_user: student_id)  
  end
end
