from django.urls import path
from .views import register_user, verify_email

urlpatterns = [
    path('api/register/', register_user, name='register'),
    path('api/verify-email/<uid>/<token>/', verify_email, name='verify_email'),
]
