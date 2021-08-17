ThinkingSphinx::Index.define :comment, with: :active_record do
    indexes strComment
    indexes user.email, as: :author_email, sortable: true
  
    has user_id, created_at, updated_at
end
  