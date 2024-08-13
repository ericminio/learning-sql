select created_at from comments, products where products.id = comments.product_id
and products.id = 1
order by created_at desc;