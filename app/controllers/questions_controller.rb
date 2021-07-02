class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :load_question, only: [:show, :edit, :update, :destroy]
    after_action  :publish_question, only: [:create]
    
    def index
        @questions = Question.all
    end

    def show
      #@answer = @question.answers.build
      @answer = Answer.new(question_id: @question.id)
      # не корректно @comment = Comment.new(question_id: @question.id, user_id: current_user.id)
      
      #@comment = Comment.new
      #@comment.user_id = current_user.id
      #@comment.commentable_type = 'Question'
      #@comment.commentable_id = @question.id

      @answer.attachments.build
      @answer.comments.build
      @comment = @question.comments.new(user_id: current_user&.id)
      
    end

    def new
        @question = Question.new
        @question.attachments.build
        @question.comments.build
    end

    def edit
      @attachments = @question.attachments 
      @comments = @question.comments 
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
        @attachments = @question.attachments
        @comments = @question.comments

#        puts('*****************')
#        @attachments.each { |att|  puts(att.file, att.id) }
        if @question.update(question_params)
#          puts '------------'
#          puts(params)
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

    def publish_question
       return if @question.errors.any?
       #ActionCable.server.broadcast('questions',  {text: 'new question' })
  
       ActionCable.server.broadcast(
        'questions', 
        ApplicationController.render(
          partial: 'questions/question_row',
          locals: { question: @question, current_user: current_user }
        )
      )
    end  

    def question_params
        params.require(:question).permit(:title, :body, 
        attachments_attributes: 
        [  :file, :attachmentable_id, 
        :attachmentable_type, :_destroy, :id],
        comments_attributes: 
        [  :strComment, :commentable_id, 
          :commentable_type, :_destroy, :id])
    end
end
