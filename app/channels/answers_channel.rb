class AnswersChannel < ApplicationCable::Channel
    def follow
     stream_from "answers" #идентиф. нашего канала(стрима)
    end
 end
 