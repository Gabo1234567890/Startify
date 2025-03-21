from rest_framework import generics, permissions
from .models import Idea
from .serializers import IdeaSerializer

# List/Create Ideas (Only show ideas for the logged-in user)
class IdeaListCreateView(generics.ListCreateAPIView):
    serializer_class = IdeaSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Idea.objects.filter(user=self.request.user)  # Only fetch user's ideas

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)  # Assign logged-in user automatically

# Retrieve/Update/Delete a specific idea (only if the user owns it)
class IdeaRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = IdeaSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Idea.objects.filter(user=self.request.user)  # Prevent access to others' ideas
