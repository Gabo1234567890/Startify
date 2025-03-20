from rest_framework import generics
from .models import Message, ChatRoom
from .serializers import MessageSerializer, ChatRoomSerializer

class ChatRoomListCreate(generics.ListCreateAPIView):
    queryset = ChatRoom.objects.all()
    serializer_class = ChatRoomSerializer

class MessageListCreate(generics.ListCreateAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer
