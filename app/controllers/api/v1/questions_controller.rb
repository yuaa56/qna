class Api::V1::QuestionsController < Api::V1::BaseController

  before_action :find_question, only: [:show]


   def index
     # render nothing: true
     # head: :ok
     # @questions = Question.all
      @questions = Question.order(:id)
     # respond_with @questions.to_json(include: :answers) 
     respond_with @questions   # с сериалайзером
   end

   def show
    respond_with @question, serializer: ::DetailedQuestionSerializer
  end

  def create
    respond_with( @question = Question.create(question_params.merge(user_id: current_resource_owner.id)))
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find(params[:id])
  end

end    