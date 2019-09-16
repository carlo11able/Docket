require 'open-uri'

class PhotosController < ApplicationController
    #before_action :set_photo, only: [:show, :edit, :update, :destroy]

    before_action :authenticate_user!
    


    def index

        @photo=Photo.new(user_id: current_user.id)

        begin
            authorize! :read, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
        end
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
            begin
                authorize! :read, @photo, :message => "BEWARE: You are not authorized to read a photo."
            rescue CanCan::AccessDenied
                #render html: "ACCESSO NEGATO" , status: 403
                render "static/accessdenied" , status: 403
            end
  
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
        
    end

    def new
      @photo = Photo.new(:user_id => current_user.id)
      begin
        authorize! :create, @photo, :message => "BEWARE: You are not authorized to read a photo."
      rescue CanCan::AccessDenied
        #render html: "ACCESSO NEGATO" , status: 403
        render "static/accessdenied" , status: 403
      end

        # default: render ’new’ template
    end

    def create

        @parameter=params[:photo].permit(:url, :image)
        puts "ANDREEAAA"
        puts @parameter
        puts "MNAMA"
        if(@parameter[:url] != nil)
            search_url="https://loremflickr.com/json/g/320/240/#{@parameter[:url]}/all"
            puts search_url
            content = open(search_url).read
            @a=JSON.parse(content)
            @parameter[:url]=@a["file"]
        end
    
        @parameter[:user_id]=current_user.id

        @photo = Photo.new(@parameter)

        begin
            authorize! :create, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
        end

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

        @photo = Photo.new(:user_id => current_user.id)
        begin
            authorize! :update, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
        end

        begin
            @photo = Photo.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
        end
        
       
        
    end

    def update
        @photo = Photo.new(:user_id => current_user.id)
        begin
            authorize! :update, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
        end

        begin
            @photo = Photo.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
        
        respond_to do |format|
            if @photo.update(photo_params)
              format.html { redirect_to photo_path(@photo), notice: 'Question was successfully updated.' }
            else
              format.html { render :edit }
            end
        end
        
    end

    def destroy
        @photo = Photo.new(:user_id => current_user.id)
        begin
            authorize! :destroy, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
        end

        begin
            @photo = Photo.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
        
        @photo.destroy
        flash[:notice] = "Photo #{@photo.id} deleted."
        redirect_to photos_path
    end
    

end
