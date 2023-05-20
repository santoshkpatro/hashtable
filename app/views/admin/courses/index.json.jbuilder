json.array! @courses do |course|
  json.id           course.id
  json.slug         course.slug
  json.price        course.price
  json.status       course.status
  json.created_at   course.created_at
  json.updated_at   course.updated_at
end