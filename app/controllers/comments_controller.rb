class CommentsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_comment, only: [:show, :edit, :update, :destroy]


    def create
      if params[:question_id]
        @question = Question.find_by(id: params[:question_id])
        @question = Question.find_by(id: params[:commentable_id])
        @comment = @question.comments.new(comment_params)
        @comment.user_id = current_user.id

        @comments = @question.comments 
      else
        @answer = Answer.find_by(id: params[:answer_id])
        #@comment = @answer.comments.new(comment_params.merge(user_id: current_user.id))
        @comment = @answer.comments.new(comment_params)
        @comment.user_id = current_user.id

        @comments = @answer.comments 
      end

    if @comment.save
      if params[:question_id]
        respond_to do |format|
          format.html { redirect_to question_path(@question) }
          format.json { render json: @comment, status: :created, location:  @comment }
        end
      else
        respond_to do |format|
          format.html { redirect_to answer_path(@answer) }
          format.json { render json: @comment, status: :created, location:  @comment }
        end
      end    
    else  
      if params[:question_id]
        respond_to do |format|
          format.html { redirect_to question_path(@question)  }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      else
        respond_to do |format|
          format.html { redirect_to answer_path(@answer)  }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end  
    end  
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    questionOrAnswer = @comment.commentable
    if @comment.update(comment_params)
      if questionOrAnswer.class == Question
        redirect_to question_path(questionOrAnswer)
      else
        redirect_to answer_path(questionOrAnswer)
      end
    else
      render :edit
    end  
  end

    def destroy
      question = @comment.commentable
      if @comment.user_id == current_user.id
        @comment.destroy
      else
        flash.notice = "У Вас нет прав на удаление этой записи"
      end  
      if question.class == Question
        question = @comment.commentable
        redirect_to question_path(question)
      else
        answer = @comment.commentable
        redirect_to answer_path(answer)
      end
    end


  private

    def comment_params
        params.require(:comment).permit(
          :id,
          :strComment, 
          :commentable_id, 
          :commentable_type
        )
    end

    def load_comment
      @comment = Comment.find_by(id: params[:id])
    end
end
