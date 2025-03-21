from django.db.models import Q
from rest_framework.decorators import api_view
from rest_framework.response import Response
from startify.apps.search.models import Project, Entrepreneur

@api_view(['GET'])
def search_projects(request):
    query = request.GET.get('q', '')
    projects = Project.objects.filter(Q(title__icontains=query) | Q(description__icontains=query))
    return Response({
        'projects': [{
            'title': project.title,
            'description': project.description,
            'entrepreneur': project.entrepreneur.name,
        } for project in projects]
    })

@api_view(['GET'])
def search_entrepreneurs(request):
    query = request.GET.get('q', '')
    entrepreneurs = Entrepreneur.objects.filter(Q(name__icontains=query) | Q(bio__icontains=query))
    return Response({
        'entrepreneurs': [{
            'name': entrepreneur.name,
            'bio': entrepreneur.bio,
            'location': entrepreneur.location,
        } for entrepreneur in entrepreneurs]
    })
