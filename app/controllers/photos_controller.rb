class PhotosController < ApplicationController
    #before_action :set_photo, only: [:show, :edit, :update, :destroy]

    before_action :authenticate_user!
    
    def index
        # if current_user.is? :admin
        #     @photos = Place.all
        # else
        #     flash[:warning] = "You are not authorized to read all photos"
        #     redirect_to root_path
        # end
        @photos=Photo.all
    end
    
    def show
        begin
            id = params[:id] # retrieve photo ID from URI route
            @photo=Photo.find(id)
            # @photo = Place.find(id)
            # authorize! :read, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue ActiveRecord::RecordNotFound 
            redirect_to :controller => "photo", :action => "index"
            flash[:warning] = "There is no photo with that index"
            return
        end
        # will render app/views/photos/show.html.erb by default
    end

    def new
      @photo = Photo.new

        # default: render ’new’ template
    end

    def create
        # @owner = current_user
        # @photo = @owner.property.build(params[:photo].permit(:name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices, :icon))
        # authorize! :create, @photo, :message => "BEWARE: You are not authorized to create a new photo."
        # @photo.save!
        # if !(@owner.is?(:owner))
        #     @owner.roles = @owner.roles << :owner
        # end
        # @owner.save!
        # respond_to do |client_wants|
        #     client_wants.html {
        #         flash[:notice] = "#{@photo.name} was successfully created."
        #         redirect_to root_path
        #     }
        #     client_wants.xml { render :xml => @photo.to_xml }
        # end

        #@photo = @owner.property.build(params[:photo].permit(:user_id, :url))   
        @photo = Photo.new(params[:photo].permit(:user_id, :url))
        respond_to do |format|
          if @photo.save
            format.html { redirect_to @photo, notice: 'photo was successfully created.' }
            format.json { render :show, status: :created, location: @photo }
          else
            format.html { render :new }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
          end
        end
    end
 

    def edit
        @photo = Photo.find params[:id]
        # authorize! :update, @photo, :message => "BEWARE: You are not authorized to edit a photo."
        # if current_user != @photo.user
        #     flash[:warning] = "You are not authorized to edit this photo"
        #     redirect_to photo_path(@photo)
        # end
        
    end

    def update
        @photo = Photo.find params[:id]
        # authorize! :update, @photo, :message => "BEWARE: You are not authorized to update a photo."
        # if current_user != @photo.user
        #     flash[:warning] = "You are not authorized to update this photo"
        #     redirect_to photo_path(@photo)
        # end
        # @photo.update_attributes!(params[:photo].permit(:name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices, :icon))
        # respond_to do |client_wants|
        #     client_wants.html {
        #         flash[:notice] = "#{@photo.name} was successfully updated."
        #         redirect_to photo_path(@photo)
        #     }
        #     client_wants.xml { render :xml => @photo.to_xml }
        # end
        @photo.update_attributes!(params[:photo].permit(:url, :user_id))
        redirect_to photo_path(@photo)
    
    end

    def destroy
        @photo = Photo.find(params[:id])
        # authorize! :destroy, @photo, :message => "BEWARE: You are not authorized to delete a photo."
        # if current_user != @photo.user && !current_user.is?(:moderator) && !current_user.is?(:admin)
        #     flash[:warning] = "You are not authorized to delete this photo"
        #     redirect_to photo_path(@photo)
        # end
        @photo.destroy
        flash[:notice] = "Photo #{@photo.id} deleted."
        redirect_to photos_path
    end
    

end
