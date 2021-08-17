class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :load_question, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe]
    after_action  :publish_question, only: [:create]
    
    respond_to :html #11 zan

    # authorize_resource #CanCan
    #load_and_authorize_resource #CanCan

    def index
      authorize Question

      #authorize! :index, Question #CanCan
      #authorize! :read, Question #CanCan

        # @questions = Question.all
        respond_with(@questions = Question.all)
    end

    def show
      authorize @question
      #authorize! :read, @question #(обьект) #CanCan
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
      respond_with @question
    end

    def new
      #authorize! :create, Question #CanCan
        @question = Question.new
        @question.attachments.build
        @question.comments.build
        
        authorize @question
        respond_with @question
    end

    def edit
      authorize @question
      @attachments = @question.attachments 
      @comments = @question.comments 
    end

    def create
      @question = Question.new(question_params)
      @question.user_id = current_user.id

      authorize @question
      flash.notice = "Your question successfully created." if  @question.save
      respond_with @question
      # binding.pry
      # redirect_to @question
      # redirect_to action: :index
      # flash.now.notice = "Your question successfully created."
      # render :new  
    end

    def update
      authorize @question
      @question.update(question_params)
      @attachments = @question.attachments
      @comments    = @question.comments
      respond_with @question
      # @attachments.each { |att|  puts(att.file, att.id) }
    end

    def destroy
      authorize @question
      # authorize! :destroy, @question #(обьект удалит любые) #CanCan
      # authorize! :destroy, Question #(обьект удалит только свои) #CanCan
      respond_with(@question.destroy) if @question.user_id == current_user.id
      flash.notice = "У Вас нет прав на удаление этой записи" if @question.user_id != current_user.id
      #redirect_to action: :index
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
