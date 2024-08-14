select created_at from comments, products where products.id = comments.product_id
and products.id = {{ product_id }}
order by created_at desc;