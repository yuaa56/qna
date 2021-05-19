class AnswersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :load_answer, only: [:show, :edit, :update, :destroy ]
    #before_action :load_question, only: [:show, :edit, :update ]

    def index
        @answers = Answer.all
    end

    def show
    end

    def new
        @answer = Answer.new(question_id: params[:question_id])
    end

    def edit
       
    end

    def create
        # @answer = Answer.new(answer_params.merge(question_id: params[:question_id]))
      
        @question = Question.find_by(id: params[:question_id])

        @answer = Answer.new(answer_params)
        @answer.question_id = params[:question_id]
        @answer.user_id = current_user.id
        if @answer.save
        else  
         flash.notice = "Your answer invalid."
         # render :new  
        end  
        redirect_to question_path(@question)

        # if  @answer.save 
        #   # binding.pry
        #   # redirect_to action: :index
        #   redirect_to question_path(@answer.question)
        #   flash.notice = "Your answer successfully created."
        # else
        #   render :new  
        # end
    end

    def update
        # @answer.user_id = current_user.id
        if @answer.update(answer_params)
          redirect_to question_path(@answer.question)
        else
          render :edit
        end  
    end

    def destroy
        @question = @answer.question
        if @answer.user_id == current_user.id
          @answer.destroy
        else
          flash.notice = "У Вас нет прав на удаление этой записи"
        end  
        redirect_to question_path(@question)
     end
  


    private

    def answer_params
      #  puts '---------------------'
      #  puts params
        params.require(:answer).permit(:body, :question_id)
    end
      
    # def load_question
    #     @question = Question.find_by(id: :question_id)
    #    @question = Question.find(params[:question_id])
    # end

    def load_answer
             @answer = Answer.find_by(id: params[:id])
    end

end
