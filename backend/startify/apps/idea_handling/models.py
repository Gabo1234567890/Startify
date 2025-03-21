from django.db import models
from django.contrib.auth.models import User

class MyDataModel(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    Name = models.CharField(max_length=255)
    Description = models.CharField(max_length=255)
    CurrentMoney = models.FloatField()
    MaxMoney = models.FloatField()
    Status = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.Name} - {self.Description} (User: {self.user.username})"
