from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password
from .models import UserProfile 
from .serializers import UserSerializer, UserProfileSerializer

class CustomTokenObtainPairView(TokenObtainPairView):
    pass

@api_view(['POST'])
def register_user(request):
    try:
        data = request.data
        user = User.objects.create(
            username=data['username'],
            email=data['email'],
            password=make_password(data['password'])
        )

        profile_data = {
            'first_name': data.get('first_name', ''),
            'last_name': data.get('last_name', ''),
            'phone_number': data.get('phone_number', ''),
            'address': data.get('address', '')
        }

        profile = UserProfile.objects.create(user=user, **profile_data)

        user_serializer = UserSerializer(user)
        return Response(user_serializer.data, status=status.HTTP_201_CREATED)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
