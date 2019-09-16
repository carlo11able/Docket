class AnswersController < ApplicationController
    before_action :set_answer, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    # GET /answers
    # GET /answers.json
    def index
        @answers = Answer.all
    end

    # GET /answers/1
    # GET /answers/1.json
    def show
        @answer = Answer.new(:id => params[:id], :user_id => current_user.id)
        begin
            authorize! :read, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
        end

        begin
            @answer = Answer.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
        end
        
    end

    # GET /answers/new
    def new
        @question=Question.order('RANDOM()').first
    end

    # GET /answers/1/edit
    def edit
        @answer = Answer.new(:id => params[:id], :user_id => current_user.id)
        begin
            authorize! :update, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
        end

        begin
            @answer = Answer.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
        end
    end

    # POST /answers
    # POST /answers.json
    def create
        # id_photo = params[:photo_id]
        # @photo = photo.find(id_photo)

        #@answer = Answer.new(answer_params)
        @parameter=answer_params
        @parameter["user_id"]=current_user.id
        @answer=Answer.new(@parameter)
        respond_to do |format|
            if @answer.save
            format.html { redirect_to answers_path, notice: 'Answer was successfully created.' }
            #format.json { render :show, status: :created, location: @answer }
            else
            format.html { render :new }
            #format.json { render json: @answer.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /answers/1
    # PATCH/PUT /answers/1.json
    def update
        respond_to do |format|
        if @answer.update(answer_params)
            format.html { redirect_to answer_path(@answer), notice: 'Answer was successfully updated.' }
            #format.json { render :show, status: :ok, location: @answer }
        else
            format.html { render :edit }
            #format.json { render json: @answer.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /answers/1
    # DELETE /answers/1.json
    def destroy
        @answer.destroy
        respond_to do |format|
            format.html { redirect_to photo_question_answers_path, notice: 'Answer was successfully destroyed.' }
            #format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
        @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
        params.require(:answer).permit(:answer,:question_id)
        #params.permit(:photo_id, :answer_text)
    end

    
end


