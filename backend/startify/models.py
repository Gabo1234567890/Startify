from django.db import models

class Entrepreneur(models.Model):
    name = models.CharField(max_length=200)
    bio = models.TextField()
    location = models.CharField(max_length=100)
    contact_info = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class Project(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    entrepreneur = models.ForeignKey(Entrepreneur, related_name='projects', on_delete=models.CASCADE)
    start_date = models.DateField()
    end_date = models.DateField()

    def __str__(self):
        return self.title
