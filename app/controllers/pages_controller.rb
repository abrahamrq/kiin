class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
  end

  def inside
    @events = COLL.find(id: current_user.mongo_id).to_a.first
    if @events
      @classes = []
      if Date.today.sunday?
        d = Date.today
        days = [d, d+1.days, d+2.days, d+3.days, d+4.days, d+5.days, d+6.days]
      else
        d = Date.today.at_beginning_of_week
        days = [d-1.days, d, d+1.days, d+2.days, d+3.days, d+4.days, d+5.days]
      end
      @events["classes"].each do |c|
        c["times"].each do |t| 
          (0..6).each do |day|
            if t["days"][day] == "1"
              @classes << {title: c["name"], start: "#{days[day].strftime("%Y-%m-%d")}T#{t["start_time"]}", end: "#{days[day].strftime("%Y-%m-%d")}T#{t["end_time"]}"}
            end
          end
        end 
      end
    end
  end
  
  
  def email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    
    if @name.blank?
      flash[:alert] = "Please enter your name before sending your message. Thank you."
      render :contact
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = "You must provide a valid email address before sending your message. Thank you."
      render :contact
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Your message is empty. Requires at least 10 characters. Nothing to send."
      render :contact
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "You can't send links. Thank you for your understanding."
      render :contact
    else    
      ContactMailer.contact_message(@name,@email,@message).deliver_now
      redirect_to root_path, notice: "Your message was sent. Thank you."
    end
  end

  def new_permit
    @object = UserPermit.new
    @object_collection = current_user.allowed_permits
    @allowed = current_user.friends
  end

  def destroy_permit
    @object = UserPermit.find(params[:id])
    @object.destroy
    @object_collection = current_user.allowed_permits
    redirect_to new_permit_path(current_user)
  end

  def create_permit
    @object = UserPermit.new
    @object.granted_user = params[:user_permit][:granted_user] 
    @object.granting_user = params[:user_permit][:granting_user] 
    if(@object.save)
      redirect_to new_permit_path(current_user)
      flash[:notice] = "Matricula agregada exitosamente"
    else
      @object_collection = current_user.allowed_permits
      render :new_permit
      flash[:alert] = "Error al agregar Matricula"
    end
  end

  def friend_schedule
    @object = User.find_by_email("#{params[:email]}.#{params[:format]}")
    @events = COLL.find(id: @object.mongo_id).to_a.first
    if @events
      @classes = []
      if Date.today.sunday?
        d = Date.today
        days = [d, d+1.days, d+2.days, d+3.days, d+4.days, d+5.days, d+6.days]
      else
        d = Date.today.at_beginning_of_week
        days = [d-1.days, d, d+1.days, d+2.days, d+3.days, d+4.days, d+5.days]
      end
      @events["classes"].each do |c|
        c["times"].each do |t| 
          (0..6).each do |day|
            if t["days"][day] == "1"
              @classes << {title: c["name"], start: "#{days[day].strftime("%Y-%m-%d")}T#{t["start_time"]}", end: "#{days[day].strftime("%Y-%m-%d")}T#{t["end_time"]}"}
            end
          end
        end 
      end
    end
  end


end
