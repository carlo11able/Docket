class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :check_photos
  # GET photos/:id/questions
  # GET photos/:id/questions.json
  def index
    @question = Question.new(photo_id: params[:photo_id])
    
    begin
      authorize! :read, @question, :message => "BEWARE: You are not authorized to read a photo."
    rescue CanCan::AccessDenied
      #render html: "ACCESSO NEGATO" , status: 403
      render "static/accessdenied" , status: 403
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
        #render html: "ACCESSO NEGATO" , status: 403
        render "static/accessdenied" , status: 403
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
      authorize! :create, @question, :message => "BEWARE: You are not authorized to read a photo."
    rescue CanCan::AccessDenied
      #render html: "ACCESSO NEGATO" , status: 403
      render "static/accessdenied" , status: 403
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @parameter=params[:question].permit(:question_text, :question_answer1, :question_answer2)
    @parameter[:photo_id]=params[:photo_id]
    @question = Question.new(@parameter)

    begin
      authorize! :create, @question, :message => "BEWARE: You are not authorized to read a photo."
    rescue CanCan::AccessDenied
      render "static/accessdenied" , status: 403
    end
    
    respond_to do |format|
      if @question.save
        #format.html { redirect_to photo_questions_path, notice: 'Question was successfully created.' }
        format.html { redirect_to photo_path(params[:photo_id]), notice: 'Question was successfully created.' }
        #format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        #format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end

  end


  # GET /questions/1/edit
  def edit
    begin  
      id = params[:id] 
      @question=Question.find(id)
      begin
        authorize! :update, @question, :message => "BEWARE: You are not authorized to read a photo."
      rescue CanCan::AccessDenied
        #render html: "ACCESSO NEGATO" , status: 403
        render "static/accessdenied" , status: 403
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
        authorize! :update, @question, :message => "BEWARE: You are not authorized to read a photo."
      rescue CanCan::AccessDenied
        #render html: "ACCESSO NEGATO" , status: 403
        render "static/accessdenied" , status: 403
      end

    rescue ActiveRecord::RecordNotFound 
      render "static/notfound" , status: 404
      return
    end

    respond_to do |format|
      if @question.update(question_params)
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
        authorize! :delete, @question, :message => "BEWARE: You are not authorized to read a photo."
      rescue CanCan::AccessDenied
        #render html: "ACCESSO NEGATO" , status: 403
        render "static/accessdenied" , status: 403
      end

    rescue ActiveRecord::RecordNotFound 
      render "static/notfound" , status: 404
      return
    end

    @question.destroy
    respond_to do |format|
      format.html { redirect_to photo_path(params[:photo_id]), notice: 'Question was successfully destroyed.' }
      #format.json { head :no_content }
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
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:photo_id, :question_text,:question_answer1,:question_answer2)
      #params.permit(:photo_id, :question_text)
    end
end

