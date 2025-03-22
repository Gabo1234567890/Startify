from django.contrib import admin
from django.urls import path, include
from startify.apps.search import views
from startify.apps.login.views import register_user
from rest_framework_simplejwt.views import TokenRefreshView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/search/', include('startify.apps.search.urls')),
    path('projects/', views.search_projects, name='search_projects'), 
    path('entrepreneurs/', views.search_entrepreneurs, name='search_entrepreneurs'), 
    #path('api/token/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/register/', register_user, name='register'),
    path("api/", include("user_management.urls")),
]
