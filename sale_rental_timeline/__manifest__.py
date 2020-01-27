# Part of rental-vertical See LICENSE file for full copyright and licensing details.

{
    'name': 'Sale Rental Timeline',
    'summary': '''This module extends the sale_rental module to create/change the
timeline object for the rented product instance automatically.
A Timeline View will be generated for all the related products.''',
    'version': '12.0.1.0.0',
    'category': 'sale',
    'author': 'Elego Software Solutions Gmbh',
    'depends': [
        'web_timeline',
        'rental_base',
    ],
    'data': [
        'security/ir.model.access.csv',
        'views/product_view.xml',
        'views/product_timeline_view.xml',
    ],
    'demo': [
    ],
    'qweb': [
    ],
    'application': True,
    'license': 'LGPL-3',
}
