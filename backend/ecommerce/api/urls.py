from django.urls import path
from .views import RegisterView, CustomTokenObtainPairView, Products,Categories

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='login'),
    path('products/', Products.as_view(), name='home-data'),  
    path('category/', Categories.as_view(), name='category-data'),  
]
