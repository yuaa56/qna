class AnswersController < ApplicationController
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
        @answer = Answer.new(answer_params)
        @answer.question_id = params[:question_id]
        if  @answer.save 
          # redirect_to action: :index
          redirect_to question_path(@answer.question)
        else
          render :new  
        end
    end

    def update
        # binding.pry
        if @answer.update(answer_params)
          redirect_to question_path(@answer.question)
        else
          render :edit
        end  
    end

    def destroy
        @question = @answer.question
        @answer.destroy
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
