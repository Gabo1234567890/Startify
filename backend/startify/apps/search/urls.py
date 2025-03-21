from django.urls import path
from . import views

urlpatterns = [
    path('projects/', views.search_projects, name='search_projects'), 
    path('entrepreneurs/', views.search_entrepreneurs, name='search_entrepreneurs'), 
]
