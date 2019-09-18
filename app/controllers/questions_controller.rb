class QuestionsController < ApplicationController
    before_action :authenticate_user!
    #before_action :check_photos
  # GET photos/:id/questions
  # GET photos/:id/questions.json
  def index
    @question = Question.new(photo_id: params[:photo_id])
    
    begin
      authorize! :read, @question, :message => "BEWARE: You are not authorized to read a photo."
    rescue CanCan::AccessDenied
      render "static/accessdenied" , status: 403
      return
    end

    redirect_to photo_path(params[:photo_id])
    
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    begin  
      id = params[:id] 
      @question=Question.find(id)
      @question.photo_id=params[:photo_id]
      begin
        authorize! :read, @question, :message => "BEWARE: You are not authorized to read a photo."
      rescue CanCan::AccessDenied
        render "static/accessdenied" , status: 403
        return
      end

    rescue ActiveRecord::RecordNotFound 
      render "static/notfound" , status: 404
      return
    end

  end

  # GET /questions/new
  def new
    @question = Question.new(photo_id: params[:photo_id])
    
    begin
      authorize! :create, @question, :message => "BEWARE: You are not authorized to create a photo."
    rescue CanCan::AccessDenied
      #render html: "ACCESSO NEGATO" , status: 403
      render "static/accessdenied" , status: 403
      return
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @parameter=params[:question].permit(:question_text, :question_answer1, :question_answer2, :correct)
    if @parameter[:correct] == '1'
      @parameter[:correct]=1
    else
      if @parameter[:correct] == '2'
        @parameter[:correct]=2
      else
        @parameter[:correct]=nil
      end
    end


    @parameter[:photo_id]=params[:photo_id]
    @question = Question.new(@parameter)

    begin
      authorize! :create, @question, :message => "BEWARE: You are not authorized to create a photo."
    rescue CanCan::AccessDenied
      render "static/accessdenied" , status: 403
      return
    end
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to photo_path(params[:photo_id]), notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end

  end


  # GET /questions/1/edit
  def edit
    begin  
      id = params[:id] 
      @question=Question.find(id)
      begin
        authorize! :update, @question, :message => "BEWARE: You are not authorized to update a photo."
      rescue CanCan::AccessDenied
        render "static/accessdenied" , status: 403
        return
      end

    rescue ActiveRecord::RecordNotFound 
      render "static/notfound" , status: 404
      return
    end
  end



  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    begin  
      id = params[:id] 
      @question=Question.find(id)
      begin
        authorize! :update, @question, :message => "BEWARE: You are not authorized to update a photo."
      rescue CanCan::AccessDenied
        render "static/accessdenied" , status: 403
        return
      end
    rescue ActiveRecord::RecordNotFound 
      render "static/notfound" , status: 404
      return
    end

    @parameter=question_params
    if @parameter[:correct] == '1'
      @parameter[:correct]=1
    else
      if @parameter[:correct] == '2'
        @parameter[:correct]=2
      else
        @parameter[:correct]=nil
      end
    end

    respond_to do |format|
      if @question.update(@parameter)
        format.html { redirect_to photo_question_path(params[:photo_id],@question), notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end

  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    begin  
      id = params[:id] 
      @question=Question.find(id)
      begin
        authorize! :delete, @question, :message => "BEWARE: You are not authorized to destroy a photo."
      rescue CanCan::AccessDenied
        render "static/accessdenied" , status: 403
        return
      end
    rescue ActiveRecord::RecordNotFound 
      render "static/notfound" , status: 404
      return
    end

    @question.destroy
    respond_to do |format|
      format.html { redirect_to photo_path(params[:photo_id]), notice: 'Question was successfully destroyed.' }
    end
  end

  private


    def check_photos
      begin
        id = params[:photo_id] # retrieve photo ID from URI route
        @photo=Photo.find(id)
      rescue ActiveRecord::RecordNotFound 
        render "static/notfound" , status: 404
        return
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      begin
        @question = Question.find(params[:id])
      rescue ActiveRecord::RecordNotFound 
        render "static/notfound" , status: 404
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:photo_id, :question_text,:question_answer1,:question_answer2, :correct)
      #params.permit(:photo_id, :question_text)
    end
end

