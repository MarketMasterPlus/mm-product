# mm-product/app/schemas.py
from flask_marshmallow import Marshmallow
from .models import Product, Category, ProductItem

ma = Marshmallow()

class ProductSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Product
        load_instance = True  # Optional: if true, deserialization will create model instances.


class CategorySchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Category
        load_instance = True  # Optional: if true, deserialization will create model instances.
