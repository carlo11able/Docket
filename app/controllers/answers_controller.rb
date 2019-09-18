class AnswersController < ApplicationController
    #before_action :set_answer, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    # GET /answers
    # GET /answers.json
    def index
        begin
            authorize! :read, Answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end
        @answers = Answer.all
    end

    # GET /answers/1
    # GET /answers/1.json
    def show
        @answer = Answer.new(:id => params[:id], :user_id => current_user.id)
        
        begin
            @answer = Answer.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end

        begin
            authorize! :read, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

        
        
    end

    def nuova
        begin
            @question = Question.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end

        begin
            authorize! :manage, :all, :message => "BEWARE: You don't have the necessary requirements"
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end



        render :new


    end

    # GET /answers/new
    def new
        @answer = Answer.new(:user_id => current_user.id)
        begin
            authorize! :create, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

        if Question.all.empty?
            @question={}
        else
            @question=Question.order('RANDOM()').first
        end
    end

    # GET /answers/1/edit
    def edit
        @answer = Answer.new(:id => params[:id], :user_id => current_user.id)
        begin
            @answer = Answer.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
        
        begin
            authorize! :update, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

        
    end

    # POST /answers
    # POST /answers.json
    def create
        @parameter=answer_params
        @parameter["user_id"]=current_user.id
        @answer=Answer.new(@parameter)
        begin
            authorize! :create, @answer, :message => "BEWARE: You are not authorized to create an answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

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
        begin
            @answer = Answer.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end

        begin
            authorize! :update, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

        

        respond_to do |format|
            if @answer.update(answer_params)
                format.html { redirect_to answer_path(@answer), notice: 'Answer was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end

    # DELETE /answers/1
    # DELETE /answers/1.json
    def destroy
        begin
            @answer = Answer.find params[:id]
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end

        begin
            authorize! :update, @answer, :message => "BEWARE: You are not authorized to read a answer."
        rescue CanCan::AccessDenied
            render "static/accessdenied" , status: 403
            return
        end

        @answer.destroy
        respond_to do |format|
            format.html { redirect_to answers_path, notice: 'Answer was successfully destroyed.' }
        end
    end

    private
    
    def set_answer
        begin
            @answer = Answer.find(params[:id])
        rescue ActiveRecord::RecordNotFound 
            render "static/notfound" , status: 404
            return
        end
      end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
        params.require(:answer).permit(:answer,:question_id)
        #params.permit(:photo_id, :answer_text)
    end

    
end


