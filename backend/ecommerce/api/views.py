from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import RegisterSerializer, CustomTokenObtainPairSerializer,BannerSerializer, ProductSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import IsAuthenticated


from rest_framework.permissions import AllowAny

from .models import Banner, Product


# Register View
class RegisterView(APIView):
    permission_classes = [AllowAny]  # This allows unauthenticated users to register

    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response({
                "status": True,
                "message": "User registered successfully!",
                "data": {
                    "id": user.id,
                    "name": user.username,
                    "email": user.email,
                    "phone": user.phone,
                    "image": user.image,
                    "points": user.points,
                    "credit": user.credit,
                    "token": None  # Token will be included in the login response
                }
            }, status=status.HTTP_201_CREATED)
        return Response({
            "status": False,
            "message": "Registration failed.",
            "data": serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)


# Custom Login View (JWT Token)
class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer



class HomeDataView(APIView):
    permission_classes = [IsAuthenticated]  # Require authentication

    def get(self, request):
        # Get the authenticated user from the token
        user = request.user

        # Fetch banners and products (could be filtered by user if needed)
        banners = Banner.objects.all()
        products = Product.objects.all()

        # Serialize the data
        banner_serializer = BannerSerializer(banners, many=True)
        product_serializer = ProductSerializer(products, many=True)

        # Construct the response data
        home_data = {
            "status": True,
            "user": {
                "id": user.id,
                "name": user.username,
                "email": user.email
            },
            "data": {
                "banners": banner_serializer.data,
                "products": product_serializer.data
            }
        }

        return Response(home_data)

