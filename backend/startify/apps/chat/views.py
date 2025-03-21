from rest_framework import generics
from .models import Message, ChatRoom, Notification
from .serializers import MessageSerializer, ChatRoomSerializer, NotificationSerializer

class ChatRoomListCreate(generics.ListCreateAPIView):
    queryset = ChatRoom.objects.all()
    serializer_class = ChatRoomSerializer

class MessageListCreate(generics.ListCreateAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

class NotificationList(generics.ListCreateAPIView):
    queryset = Notification.objects.filter(read=False)  # Only unread notifications
    serializer_class = NotificationSerializer