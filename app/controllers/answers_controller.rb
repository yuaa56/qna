class AnswersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :load_answer, only: [:show, :edit, :update, :destroy ]
    after_action  :publish_answer, only: [:create]
    

    #before_action :load_question, only: [:show, :edit, :update ]

    def index
        @answers = Answer.all
    end

    def show
      @answer = Answer.find_by(id: params[:id])
      @question = Question.find_by(id: @answer.question_id)
      @answer.attachments.build
      @answer.comments.build
      @comment = @answer.comments.new(user_id: current_user&.id)
      @comments = @answer.comments 
    end
    
    def new
        @answer = Answer.new(question_id: params[:question_id])
    end

    def edit
      #binding.pry
    end

    def create
        # @answer = Answer.new(answer_params.merge(question_id: params[:question_id]))
      
        @question = Question.find_by(id: params[:question_id])

        @answer = Answer.new(answer_params)
        @answer.question_id = params[:question_id]
        @answer.user_id = current_user.id
        @answers = @question.answers 
        if @answer.save
          @attachments =  @answer.attachments
    
            respond_to do |format|
              #format.html {  render partial: 'questions/answer_row', locals: { answer: @answer},  layout: false }
              format.html { redirect_to question_path(@question) }
            # format.json {  render json: @answer }
              format.json { render json: @answer.attributes.merge({ files: @attachments }), status: :created, location:  @answer }
            end
         
         else  
          #flash.notice = "Your answer invalid."

            respond_to do |format|
              format.html { redirect_to question_path(@question)  }
              format.json { render json: @answer.errors, status: :unprocessable_entity }
            end
        end  
     

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
      @answer = Answer.find(params[:id])
      @answer.update(answer_params)
      #  puts '1----------------'
      #  puts params
      #  puts answer_params

      # if @answer.update(answer_params)
      #   puts '2----------------'
      #   puts params
      #   puts answer_params
      #    # redirect_to question_path(@answer.question)
      # else
      #   render :edit
      # end  
    end

  def destroy
    #@question = @answer.question
    if @answer.user_id == current_user.id
      @answer_id = @answer.id if @answer.destroy
    end
    #else
    #  flash.notice = "У Вас нет прав на удаление этой записи"
    #end  
    #redirect_to question_path(@question)
  end
  


    private

    def answer_params
      #  puts '---------------------'
      #  puts params
        params.require(:answer).permit(
          :body, 
          :best, 
          :question_id,
          attachments_attributes: [
            :file, 
            :attachmentable_id, 
            :attachmentable_type,
            :_destroy, :id ],
          comments_attributes: [
            :strComment, 
            :commentable_id, 
            :commentable_type,
            :_destroy, :id ]
        )
    end

  def load_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def publish_answer
    return if @answer.errors.any?
    #ActionCable.server.broadcast('answers',  {text: 'new answer' })

    ActionCable.server.broadcast(
     'answers', 
     ApplicationController.render(
       partial: 'questions/answer_row',
       locals: { answer: @answer, current_user: current_user }
     )
   )
  end  

end
