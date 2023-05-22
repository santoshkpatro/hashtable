json.array! @enrollments do |enrollment|
  json.id           enrollment.id
  json.active       enrollment.active
  json.role         enrollment.role
  json.enrolled_on  enrollment.enrolled_on
  json.valid_till   enrollment.valid_till
  json.created_at   enrollment.created_at
  json.updated_at   enrollment.updated_at
  json.course do
    json.id          enrollment.course.id
    json.title       enrollment.course.title
    json.slug        enrollment.course.slug
    json.status      enrollment.course.status
    json.price       enrollment.course.price
    json.created_at  enrollment.course.created_at
    json.updated_at  enrollment.course.updated_at
  end
  json.user do
    json.id          enrollment.user.id
    json.email       enrollment.user.email
    json.full_name   enrollment.user.full_name
    json.phone       enrollment.user.phone
    json.role        enrollment.user.role
    json.updated_at  enrollment.user.updated_at
    json.created_at  enrollment.user.created_at
  end
end