# mm-product/app/api/routes.py
from flask import request
from flask_restx import Resource, fields, Namespace
from ..models import db, Product, Category
from ..schemas import ProductSchema, CategorySchema
from sqlalchemy import or_

def init_routes(api):
    # Define namespaces
    product_ns = Namespace('products', description='Product operations')
    category_ns = Namespace('categories', description='Category operations')
    api.add_namespace(product_ns, path='/mm-product')
    api.add_namespace(category_ns, path='/category')

    product_schema = ProductSchema()
    category_schema = CategorySchema()

    # Data product_model for a product
    product_model = api.model('Product', {
        'id': fields.Integer(readOnly=True, description='The unique identifier of a product'),
        'name': fields.String(required=True, description='Product commercial name'),
        'description': fields.String(required=True, description='Product description'),
        'brand': fields.String(required=False, description='Product brand'),
        'categoryid': fields.Integer(readOnly=True, description='Product category'),
        'suggestedprice': fields.Float(required=True, description='Suggested price of a single unit of the product'),
        'imageurl': fields.String(required=False, description='URL of the product image')
    })

    # Data category_model for a category
    category_model = api.model('Category', {
        'id': fields.Integer(readOnly=True, description='The unique identifier of a category'),
        'name': fields.String(required=True, description='Category name')
    })

    @product_ns.route('/')
    class ProductList(Resource):
        @product_ns.doc('list_products', params={
            'name': 'Filter by product name',
            'category': 'Filter by product category ID',
            'description': 'Filter by product description',
            'brand': 'Filter by product brand'
        })
        @product_ns.marshal_list_with(product_model)
        def get(self):
            """List all products or search by specified attributes"""
            name_filter = request.args.get('name')
            category_filter = request.args.get('category')
            description_filter = request.args.get('description')
            brand_filter = request.args.get('brand')

            query = Product.query

            if name_filter:
                query = query.filter(db.func.lower(Product.name).ilike(f"%{name_filter.lower()}%"))
            if category_filter:
                query = query.join(Category).filter(db.func.lower(Category.name).ilike(f"%{category_filter.lower()}%"))
            if description_filter:
                query = query.filter(db.func.lower(Product.description).ilike(f"%{description_filter.lower()}%"))
            if brand_filter:
                query = query.filter(db.func.lower(Product.brand).ilike(f"%{brand_filter.lower()}%"))

            products = query.all()
            return products


        @product_ns.doc('create_product')
        @product_ns.expect(product_model)
        @product_ns.marshal_with(product_model, code=201)
        def post(self):
            """Create a new product"""
            data = request.json
            product = Product(**data)
            db.session.add(product)
            db.session.commit()
            return product, 201

    @product_ns.route('/category/<int:id>')
    class ProductByCategory(Resource):
        @product_ns.doc('list_products_by_category',
                        params={'q': 'Query string to filter products by name, description, or brand'})
        @product_ns.marshal_list_with(product_model)
        def get(self, id):
            """List all products by category and optionally filter by query string"""
            query = Product.query.filter(Product.categoryid == id)

            # Handling the optional query string for further filtering
            q = request.args.get('q')
            if q:
                search_filter = f"%{q.lower()}%"
                query = query.filter(
                    or_(
                        Product.name.ilike(search_filter),
                        Product.description.ilike(search_filter),
                        Product.brand.ilike(search_filter)
                    )
                )

            products = query.all()
            return products

    @product_ns.route('/<int:id>')
    class ProductDetail(Resource):
        @product_ns.doc('get_product')
        @product_ns.marshal_with(product_model)
        def get(self, id):
            """Fetch a product given its identifier"""
            product = Product.query.get_or_404(id)
            return product

        @product_ns.doc('update_product')
        @product_ns.expect(product_model)
        @product_ns.marshal_with(product_model)
        def put(self, id):
            """Update a product"""
            product = Product.query.get_or_404(id)
            data = request.json
            for key, value in data.items():
                setattr(product, key, value)
            db.session.commit()
            return product

        @product_ns.doc('delete_product')
        @product_ns.response(204, 'Product deleted')
        def delete(self, id):
            """Delete a product"""
            product = Product.query.get_or_404(id)
            db.session.delete(product)
            db.session.commit()
            return '', 204

    # Define resources and routes
    @category_ns.route('/')
    class CategoryList(Resource):
        @category_ns.doc('list_categories', params={'q': 'Query string to search for categories by name'})
        @category_ns.marshal_list_with(category_model)
        def get(self):
            """List all categories or search by query string"""
            query = request.args.get('q')
            if query:
                search_filter = f"%{query.lower()}%"
                categories = Category.query.filter(
                    or_(
                        db.func.lower(Category.name).ilike(search_filter)
                    )
                ).all()
            else:
                categories = Category.query.all()
            return categories

        @category_ns.doc('create_category')
        @category_ns.expect(category_model)
        @category_ns.marshal_with(category_model, code=201)
        def post(self):
            """Create a new category"""
            data = request.json
            category = Category(**data)
            db.session.add(category)
            db.session.commit()
            return category, 201

    @category_ns.route('/<int:id>')
    class CategoryDetail(Resource):

        @category_ns.doc('get_category')
        @category_ns.marshal_with(category_model)
        def get(self, id):
            """Fetch a category given its identifier"""
            category = Category.query.get_or_404(id)
            return category

        @category_ns.doc('update_category')
        @category_ns.expect(category_model)
        @category_ns.marshal_with(category_model)
        def put(self, id):
            """Update a category"""
            category = Category.query.get_or_404(id)
            data = request.json
            for key, value in data.items():
                setattr(category, key, value)
            db.session.commit()
            return category

        @category_ns.doc('delete_category')
        @category_ns.response(204, 'Category deleted')
        def delete(self, id):
            """Delete a category"""
            category = Category.query.get_or_404(id)
            db.session.delete(category)
            db.session.commit()
            return '', 204
