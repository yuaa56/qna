class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :load_question, only: [:show, :edit, :update, :destroy]

    def index
        @questions = Question.all
    end

    def show
      @answer = Answer.new(question_id: @question.id)  
    end

    def new
        @question = Question.new
    end

    def edit
       
    end

    def create
        @question = Question.new(question_params)
       # binding.pry

        @question.user_id = current_user.id
        if  @question.save 
          #redirect_to @question
          redirect_to action: :index
          #flash.now.notice = "Your question successfully created."
          flash.notice = "Your question successfully created."

        else
          render :new  
        end
    end

    def update
        # @question.user_id = current_user.id
        if @question.update(question_params)
          #redirect_to @question
          redirect_to action: :index
        else
          render :edit
        end  
    end

    def destroy
      if @question.user_id == current_user.id
        @question.destroy
      else
        flash.notice = "У Вас нет прав на удаление этой записи"
      end  

      # redirect_to questions_path
      redirect_to action: :index
    end

  
    private
    def load_question
        @question = Question.find(params[:id])
    end

    def question_params
        params.require(:question).permit(:title, :body)
    end
  

end
