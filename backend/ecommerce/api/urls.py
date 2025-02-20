from django.urls import path
from .views import RegisterView, CustomTokenObtainPairView, Products,Categories,ProductsByCategory,ProductDetails,CartView, PaymentView,PasswordResetRequestView, PasswordResetConfirmView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='login'),
    path('password-reset/', PasswordResetRequestView.as_view(), name='password_reset'),
    path('password-reset-confirm/<uidb64>/<token>/', PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('products/', Products.as_view(), name='home-data'),  
    path('product/<str:pk>/', ProductDetails.as_view(), name='product'),  
    path('categories/', Categories.as_view(), name='categories-data'),  
    path('categories/<str:pk>/', ProductsByCategory.as_view(), name='category'),
    path('cart/', CartView.as_view(), name='cart'),
    path('payment/', PaymentView.as_view(), name='payment'),  
]
