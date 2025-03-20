from django.urls import path
from .views import ChatRoomListCreate, MessageListCreate

urlpatterns = [
    path('rooms/', ChatRoomListCreate.as_view(), name="rooms"),
    path('messages/', MessageListCreate.as_view(), name="messages"),
]
