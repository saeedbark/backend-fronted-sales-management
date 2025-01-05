from django.urls import path
from .views import RegisterView, CustomTokenObtainPairView, HomeDataView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='login'),
    path('home/', HomeDataView.as_view(), name='home-data'),  # New route for home data
]
