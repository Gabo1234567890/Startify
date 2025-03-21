from django.urls import path
from .views import IdeaListCreateView, IdeaRetrieveUpdateDestroyView

urlpatterns = [
    path('ideas/', IdeaListCreateView.as_view(), name='idea-list-create'),
    path('ideas/<int:pk>/', IdeaRetrieveUpdateDestroyView.as_view(), name='idea-detail'),
]
