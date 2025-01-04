from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import RegisterSerializer, CustomTokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

from rest_framework.permissions import AllowAny

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
