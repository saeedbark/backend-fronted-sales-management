from rest_framework import serializers
from django.contrib.auth import get_user_model
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from .models import Banner, Product


User = get_user_model()

# Register Serializer
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'phone', 'password', 'image']

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            phone=validated_data.get('phone'),
            password=validated_data['password'],
            image=validated_data.get('image', 'null')
        )
        return user

# JWT Token Serializer
class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        data['data'] = {
            'id': self.user.id,
            'name': self.user.username,
            'email': self.user.email,
            'phone': self.user.phone,
            'image': self.user.image,
            'points': self.user.points,
            'credit': self.user.credit,
            'token': data['access'],  # Include the access token
        }
        # Remove unnecessary fields from the response
        data.pop('refresh', None)
        return data



class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Banner
        fields = ['id', 'image']

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id', 'name', 'image', 'price', 'old_price', 'discount', 'in_favorites']
