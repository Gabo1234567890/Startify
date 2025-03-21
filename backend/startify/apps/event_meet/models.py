from django.db import models

class Event(models.Model):
    name = models.CharField(max_length=255)
    event_date = models.DateTimeField()
    color = models.CharField(max_length=7)  # Hex код на цвета

    def __str__(self):
        return self.name
