from rest_framework import serializers
from .models import Idea

class IdeaSerializer(serializers.ModelSerializer):
    user = serializers.ReadOnlyField(source='user.username')  # Auto-set from request.user

    class Meta:
        model = Idea
        fields = '__all__'  # Include all fields