from django.contrib import admin
from django.urls import path, include
from startify.apps.search import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/search/', include('startify.apps.search.urls')),
    path('projects/', views.search_projects, name='search_projects'), 
    path('entrepreneurs/', views.search_entrepreneurs, name='search_entrepreneurs'), 
]
