"""
That module contains the routes of blog app
"""

from django.urls import path
from blog.views import index

APP_NAME = 'blog'

urlpatterns = [
    path('', index, name='index'),
]
