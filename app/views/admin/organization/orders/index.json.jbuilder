json.array! @orders do |order|
  json.id              order.id
  json.slug            order.slug
  json.price           order.price
  json.amount          order.amount
  json.status          order.status
  json.payment_status  order.payment_status
  json.due_date        order.due_date
  json.created_at      order.created_at
  json.updated_at      order.updated_at
end