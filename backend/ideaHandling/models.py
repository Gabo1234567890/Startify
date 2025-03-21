from django.db import models

class MyDataModel(models.Model):
    Name = models.CharField(max_length=255)
    Description = models.CharField(max_length=255)
    MaxMoney = models.FloatField()
    CurrentMoney = models.FloatField()
    Status = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.string_one} - {self.string_two}"
