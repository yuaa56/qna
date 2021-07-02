class AnswerSerializer < ActiveModel::Serializer
    attributes: :id, :title, :files

    def files
        object.attachments
    end
end