from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.contrib.sites.shortcuts import get_current_site
from django.urls import reverse
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.contrib.auth.tokens import default_token_generator
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password
from .models import UserProfile 
from .serializers import UserSerializer, UserProfileSerializer

@api_view(['POST'])
def register_user(request):
    data = request.data
    if User.objects.filter(email=data['email']).exists():
        return Response({'error': 'Email already registered'}, status=status.HTTP_400_BAD_REQUEST)

    user = User.objects.create(
        username=data['username'],
        email=data['email'],
        password=make_password(data['password']),
        is_active=False 
    )

    token = default_token_generator.make_token(user)
    uid = urlsafe_base64_encode(force_bytes(user.pk))
    domain = get_current_site(request).domain
    verification_link = f"http://{domain}/api/verify-email/{uid}/{token}/"

    send_mail(
        "Verify Your Email",
        f"Click the link to verify your email: {verification_link}",
        "your-email@gmail.com",
        [user.email],
        fail_silently=False,
    )

    return Response({'message': 'User registered. Check your email for verification'}, status=status.HTTP_201_CREATED)


@api_view(['GET'])
def verify_email(request, uid, token):
    try:
        uid = force_str(urlsafe_base64_decode(uid))
        user = User.objects.get(pk=uid)

        if default_token_generator.check_token(user, token):
            user.is_active = True
            user.save()
            return Response({'message': 'Email verified successfully'}, status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Invalid token'}, status=status.HTTP_400_BAD_REQUEST)

    except User.DoesNotExist:
        return Response({'error': 'User not found'}, status=status.HTTP_400_BAD_REQUEST)
