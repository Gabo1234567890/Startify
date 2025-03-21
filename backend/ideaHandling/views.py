from rest_framework import generics
from .models import Idea
from .serializers import IdeaSerializer

# List all Ideas or Create a new one
class IdeaListCreateView(generics.ListCreateAPIView):
    queryset = Idea.objects.all()
    serializer_class = IdeaSerializer

# Retrieve, Update, or Delete a single Idea
class IdeaRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Idea.objects.all()
    serializer_class = IdeaSerializer
