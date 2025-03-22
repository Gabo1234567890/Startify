from django.urls import path
from .views import delete_all_users

urlpatterns = [
    path("delete-users/", delete_all_users, name="delete-all-users"),
]
