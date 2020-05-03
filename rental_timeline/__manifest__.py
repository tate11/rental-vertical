# Part of rental-vertical See LICENSE file for full copyright and licensing details.

{
    'name': 'Rental Timeline',
    'summary': 'Adds a timeline to products as well as a timeline view as overview of all rental products and orders',
    'description': '''
This module extends the sale_rental module to create and change the timeline objects
for the rented product instances automatically.
A complete timeline view will be generated for all rentable products.''',
    'version': '12.0.1.0.1',
    'category': 'sale',
    'author': 'Odoo Community Association (OCA)/Elego Software Solutions GmbH',
    'depends': [
        'web_timeline',
        'rental_base',
        'rental_product_variant',
    ],
    'data': [
        'security/ir.model.access.csv',
        'views/assets.xml',
        'views/product_timeline_view.xml',
        'views/product_view.xml',
    ],
    'demo': [
    ],
    'qweb': [
    ],
    'application': True,
    'license': 'AGPL-3',
}
