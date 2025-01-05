from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    phone = models.CharField(max_length=15, null=True, blank=True)
    image = models.URLField(max_length=200, null=True, blank=True)
    points = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    credit = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    # Add custom related_name for groups and user_permissions to avoid conflicts
    groups = models.ManyToManyField(
        'auth.Group',
        related_name='custom_user_set',  # This avoids the clash
        blank=True
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='custom_user_permissions_set',  # This avoids the clash
        blank=True
    )

    def __str__(self):
        return self.username



class Banner(models.Model):
    image = models.URLField(max_length=255)
    
    def __str__(self):
        return f"Banner {self.id}"

class Product(models.Model):
    name = models.CharField(max_length=255)
    image = models.URLField(max_length=255)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    old_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    discount = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    in_favorites = models.BooleanField(default=False)
    
    def __str__(self):
        return self.name
