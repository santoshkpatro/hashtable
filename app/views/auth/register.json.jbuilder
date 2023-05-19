json.email      @user.email
json.full_name  @user.full_name
json.organization do
  json.name    @organization.name
  json.slug    @organization.slug
  json.status  @organization.status
end