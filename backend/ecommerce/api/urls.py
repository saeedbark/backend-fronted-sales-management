from django.urls import path
from .views import RegisterView, CustomTokenObtainPairView, PasswordResetRequestView,VerifyOTPView,ResetPasswordView,Products,Categories,ProductsByCategory,ProductDetails,CartView, PaymentView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='login'),
    path('password-reset-request/', PasswordResetRequestView.as_view(), name='password-reset-request'),
    path('verify-otp/', VerifyOTPView.as_view(), name='verify-otp'),
    path('reset-password/', ResetPasswordView.as_view(), name='reset-password'),
    path('products/', Products.as_view(), name='home-data'),  
    path('product/<str:pk>/', ProductDetails.as_view(), name='product'),  
    path('categories/', Categories.as_view(), name='categories-data'),  
    path('categories/<str:pk>/', ProductsByCategory.as_view(), name='category'),
    path('cart/', CartView.as_view(), name='cart'),
    path('payment/', PaymentView.as_view(), name='payment'),  
]
