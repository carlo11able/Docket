require 'open-uri'

class PhotosController < ApplicationController
    before_action :authenticate_user!
    


    def index
        @photo=Photo.new(user_id: current_user.id)
        begin
            authorize! :read, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
            return
        end
        
        @photos=Photo.all
    end
    
    def show
        begin
            id = params[:id] # retrieve photo ID from URI route
            @photo=Photo.find(id)
            begin
                authorize! :read, @photo, :message => "BEWARE: You are not authorized to read a photo."
            rescue CanCan::AccessDenied
                render "static/accessdenied" , status: 403
                return
            end
  
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
        
    end

    def new
      @photo = Photo.new(:user_id => current_user.id)
      begin
        authorize! :create, @photo, :message => "BEWARE: You are not authorized to create a photo."
      rescue CanCan::AccessDenied
        render "static/accessdenied" , status: 403
        return
      end

    end

    def create
        begin
            @parameter=photo_params
        rescue NoMethodError
            redirect_to new_photo_path, alert: 'Error photo was not successfully created.' 
            return
        end
        puts "inizio parameter"
        puts @parameter
        puts "fine parameter"

        if(@parameter[:url] != nil and @parameter[:image]!=nil)
            redirect_to new_photo_path, alert: 'Error photo was not successfully created.' 
            return
        end

        if(@parameter[:url] == nil and @parameter[:image]==nil)
            redirect_to new_photo_path, alert: 'Error photo was not successfully created.' 
            return
        end


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
            authorize! :create, @photo, :message => "BEWARE: You are not authorized to create a photo."
        rescue CanCan::AccessDenied
            #render html: "ACCESSO NEGATO" , status: 403
            render "static/accessdenied" , status: 403
            return
        end

        respond_to do |format|
          if @photo.save
            format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
            format.json { render :show, status: :created, location: @photo }
          else
            format.html { render :new }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
          end
        end
    end
 

    def edit
        begin
            @photo = Photo.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end   

        begin
            authorize! :update, @photo, :message => "BEWARE: You are not authorized to update a photo."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

           
    end

    def update
        begin
            @parameter=photo_params
        rescue NoMethodError
            redirect_to edit_photo_path(params[:id]), alert: 'Error photo was not successfully updated.' 
            return
        end

        begin
            @photo = Photo.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
        
        begin
            authorize! :update, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

       

        if(@parameter[:url] != nil and @parameter[:image]!=nil)
            redirect_to edit_photo_path(@photo), alert: 'Error photo was not successfully updated.' 
            return
        end

        if(@parameter[:url] == nil and @parameter[:image]==nil)
            redirect_to edit_photo_path(@photo), alert: 'Error photo was not successfully updated.' 
            return
        end



        if(@parameter[:url] != nil)
            search_url="https://loremflickr.com/json/g/320/240/#{@parameter[:url]}/all"
            puts search_url
            content = open(search_url).read
            @a=JSON.parse(content)
            @parameter[:url]=@a["file"]
        end
    
        
        respond_to do |format|
            if @photo.update(@parameter)
              format.html { redirect_to photo_path(@photo), notice: 'Photo was successfully updated.' }
            else
              format.html { render :edit }
            end
        end
        
    end

    def destroy
        

        begin
            @photo = Photo.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end

        begin
            authorize! :destroy, @photo, :message => "BEWARE: You are not authorized to read a photo."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end
        
        @photo.destroy
        flash[:notice] = "Photo #{@photo.id} deleted."
        redirect_to photos_path
        return
    end
    


    private

    def set_photo
        begin
            @photo = Photo.find(params[:id])
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
      end

    def photo_params
        params[:photo].permit(:url, :image)
    end

end
