import json
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async
from .models import Message, ChatRoom
from django.contrib.auth.models import User

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = f"chat_{self.room_name}"

        # Join the room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.accept()

    async def disconnect(self, close_code):
        # Leave the room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        data = json.loads(text_data)
        message = data['message']
        username = data['username']

        # Save the message to the database
        room = await database_sync_to_async(ChatRoom.objects.get)(name=self.room_name)
        user = await database_sync_to_async(User.objects.get)(username=username)

        new_message = await database_sync_to_async(Message.objects.create)(
            room=room,
            sender=user,
            content=message
        )

        # Notify all users in the room group about the new message
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                "type": "chat_message",
                "message": message,
                "username": username,
                "timestamp": new_message.timestamp.isoformat(),  # Include timestamp for sorting
            }
        )

        # Optionally, if you want to send push notifications to mobile apps:
        # Call your push notification service here (e.g., FCM or your custom service)

    async def chat_message(self, event):
        # Send message to WebSocket
        await self.send(text_data=json.dumps(event))
