from django.urls import path
from .views import ChatRoomListCreate, MessageListCreate, NotificationList

urlpatterns = [
    path('rooms/', ChatRoomListCreate.as_view(), name="rooms"),
    path('messages/', MessageListCreate.as_view(), name="messages"),
    path('notifications/', NotificationList.as_view(), name='notifications'),
]
