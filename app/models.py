# mm-product/app/models.py
from . import db  # Import the db instance from __init__.py

class Product(db.Model):
    __tablename__ = 'product'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    description = db.Column(db.String(255), nullable=True)
    brand = db.Column(db.String(255), nullable=True)
    categoryid = db.Column(db.Integer, db.ForeignKey('category.id'), nullable=False)
    suggestedprice = db.Column(db.Float, nullable=False)
    imageurl = db.Column(db.String(255), nullable=True)
    category = db.relationship('Category', backref=db.backref('products', lazy=True))

    def __repr__(self):
        return f"<Product {self.name}, {self.description}, {self.brand}, Suggested Price: {self.suggestedprice}>"

class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)

    def __repr__(self):
        return f"<Category {self.name}>"
