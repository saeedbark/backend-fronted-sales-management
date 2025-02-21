from rest_framework.views import APIView
from rest_framework.response import Response
import random

from rest_framework import status
from .serializers import RegisterSerializer, CustomTokenObtainPairSerializer, ProductSerializer,CategorySerializer,CartSerializer, PaymentSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth.tokens import default_token_generator
from django.utils.timezone import now


from django.core.mail import send_mail
from django.conf import settings



from rest_framework.permissions import AllowAny

from .models import Product,Category,Cart, CartItem, Product, Payment,User,PasswordResetOTP


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
    
class PasswordResetRequestView(APIView):
    def post(self, request):
        email = request.data.get('email')
        if not email:
            return Response({"error": "Email is required."}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            user = User.objects.get(email=email)  # Check if user exists
            
            # Generate a 6-digit OTP
            otp = str(random.randint(100000, 999999))

            # Save OTP in database with a timestamp
            PasswordResetOTP.objects.update_or_create(
                user=user,
                defaults={"otp": otp, "created_at": now()}
            )

            # Send OTP via email
            send_mail(
                subject="Password Reset OTP",
                message=f"Your password reset OTP is: {otp}\n"
                        "This OTP is valid for 10 minutes.",
                from_email=settings.EMAIL_HOST_USER,
                recipient_list=[user.email],
                fail_silently=False,
            )

            return Response({"message": "OTP sent to your email."}, status=status.HTTP_200_OK)

        except User.DoesNotExist:
            return Response({"error": "User with this email does not exist."}, status=status.HTTP_400_BAD_REQUEST)



class VerifyOTPView(APIView):
    def post(self, request):
        email = request.data.get("email")
        otp = request.data.get("otp")

        if not email or not otp:
            return Response({"error": "Email and OTP are required."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.get(email=email)
            otp_record = PasswordResetOTP.objects.get(user=user, otp=otp)

            # Check if OTP is expired
            if otp_record.is_expired():
                return Response({"error": "OTP has expired."}, status=status.HTTP_400_BAD_REQUEST)

            # If OTP is correct and not expired, return success
            # Frontend can then redirect to a password reset page
            return Response({"message": "OTP verified successfully."}, status=status.HTTP_200_OK)

        except (User.DoesNotExist, PasswordResetOTP.DoesNotExist):
            return Response({"error": "Invalid OTP or email."}, status=status.HTTP_400_BAD_REQUEST)

class ResetPasswordView(APIView):
    def post(self, request):
        email = request.data.get("email")
        new_password = request.data.get("new_password")
        otp = request.data.get("otp")  # In case you want to re-check or ensure same OTP

        if not email or not new_password or not otp:
            return Response({"error": "Email, OTP, and new password are required."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.get(email=email)
            otp_record = PasswordResetOTP.objects.get(user=user, otp=otp)

            # Double-check if OTP is expired (optional but recommended for security)
            if otp_record.is_expired():
                return Response({"error": "OTP has expired."}, status=status.HTTP_400_BAD_REQUEST)

            # Set the new password
            user.set_password(new_password)
            user.save()

            # Delete the OTP record to prevent reuse
            otp_record.delete()

            return Response({"message": "Password reset successfully."}, status=status.HTTP_200_OK)

        except (User.DoesNotExist, PasswordResetOTP.DoesNotExist):
            return Response({"error": "Invalid OTP or email."}, status=status.HTTP_400_BAD_REQUEST)


class Products(APIView):
    print('---------Products-------------')
    permission_classes = [IsAuthenticated]  # Require authentication

    def get(self, request):
        print('request',request)
        # Get the authenticated user from the token
        user = request.user
        
        print('user',user)

        # Fetch  products (could be filtered by user if needed)
        products = Product.objects.all()

        # Serialize the data
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
                "products": product_serializer.data
            }
        }

        return Response(home_data)
    
class ProductDetails(APIView):
    print('---------ProductDetail-------------')
    permission_classes = [IsAuthenticated]
    
    def get(self,request,pk):
        user = request.user
        
        product = Product.objects.get(id=pk)
        
                
        print('product',product)
        
        

        # Serialize the data
        product_serializer = ProductSerializer(product, many=False)

        # Construct the response data
        home_data = {
            "status": True,
            "user": {
                "id": user.id,
                "name": user.username,
                "email": user.email
            },
            "data": {
                "product": product_serializer.data
            }
        }

        return Response(home_data)
        
        
        

class Categories(APIView):
    print('---------Categroy-------------')
    permission_classes = [IsAuthenticated]  # Require authentication

    def get(self, request):
        # Get the authenticated user from the token
        user = request.user
        category = Category.objects.all()

        # Serialize the data
        cateory_serializer = CategorySerializer(category, many=True)

        # Construct the response data
        home_data = {
            "status": True,
            "user": {
                "id": user.id,
                "name": user.username,
                "email": user.email
            },
            "data": {
                "categories": cateory_serializer.data
            }
        }

        return Response(home_data)



class ProductsByCategory(APIView):
    permission_classes = [IsAuthenticated]  # Require authentication
    print('---------Products_Categroy-------------')
    def get(self, request,pk):
        print('request',request)
        # Get the authenticated user from the token
        user = request.user
        
        print('user',user)
 
        # Fetch  products (could be filtered by user if needed)
        products = Product.objects.all().filter(category=pk)
        
        print('products',products)
        
        

        # Serialize the data
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
                "products": product_serializer.data
            }
        }

        return Response(home_data)
    
    
    
    
   

class CartView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, cart_id=None):
        user = request.user

        if cart_id:
            try:
                cart = Cart.objects.get(id=cart_id, user=user)
            except Cart.DoesNotExist:
                return Response({"status": False, "message": "Cart not found"}, status=status.HTTP_404_NOT_FOUND)
        else:
            cart, created = Cart.objects.get_or_create(user=user)

        serializer = CartSerializer(cart)
        return Response({"status": True, "data": serializer.data}, status=status.HTTP_200_OK)

    def post(self, request):
        user = request.user
        product_id = request.data.get('product_id')
        quantity = request.data.get('quantity', 1)

        if not product_id:
            return Response({"status": False, "message": "Product ID is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            quantity = int(quantity)
            if quantity < 1:
                raise ValueError
        except (ValueError, TypeError):
            return Response({"status": False, "message": "Quantity must be a positive integer"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            return Response({"status": False, "message": "Product not found"}, status=status.HTTP_404_NOT_FOUND)

        cart, created = Cart.objects.get_or_create(user=user)
        cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product)

        if not created:
            cart_item.quantity += quantity
        else:
            cart_item.quantity = quantity
        cart_item.save()

        serializer = CartSerializer(cart)
        return Response({"status": True, "message": "Item added to cart", "data": serializer.data}, status=status.HTTP_200_OK)

    def delete(self, request, cart_id=None):
        user = request.user
        product_id = request.data.get('product_id')

        if not product_id:
            return Response({"status": False, "message": "Product ID is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            if cart_id:
                cart = Cart.objects.get(id=cart_id, user=user)
            else:
                cart = Cart.objects.get(user=user)
        except Cart.DoesNotExist:
            return Response({"status": False, "message": "Cart does not exist"}, status=status.HTTP_404_NOT_FOUND)

        try:
            cart_item = CartItem.objects.get(cart=cart, product_id=product_id)
            cart_item.delete()
            return Response({"status": True, "message": "Item removed from cart"}, status=status.HTTP_200_OK)
        except CartItem.DoesNotExist:
            return Response({"status": False, "message": "Item not found in cart"}, status=status.HTTP_404_NOT_FOUND)

    def put(self, request, cart_id=None):
        user = request.user
        product_id = request.data.get('product_id')
        quantity = request.data.get('quantity')

        if not product_id or quantity is None:
            return Response({"status": False, "message": "Product ID and quantity are required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            quantity = int(quantity)
            if quantity < 1:
                raise ValueError
        except (ValueError, TypeError):
            return Response({"status": False, "message": "Quantity must be a positive integer"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            if cart_id:
                cart = Cart.objects.get(id=cart_id, user=user)
            else:
                cart = Cart.objects.get(user=user)
            cart_item = CartItem.objects.get(cart=cart, product_id=product_id)
            cart_item.quantity = quantity
            cart_item.save()
            serializer = CartSerializer(cart)
            return Response({"status": True, "message": "Cart updated", "data": serializer.data}, status=status.HTTP_200_OK)
        except Cart.DoesNotExist:
            return Response({"status": False, "message": "Cart does not exist"}, status=status.HTTP_404_NOT_FOUND)
        except CartItem.DoesNotExist:
            return Response({"status": False, "message": "Item not found in cart"}, status=status.HTTP_404_NOT_FOUND)
# views.py

class CartCreateView(APIView):
    serializer_class = CartSerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        user = request.user
        cart, created = Cart.objects.get_or_create(user=user)
        serializer = self.get_serializer(cart)
        return Response({"status": True, "message": "Cart created", "data": serializer.data}, status=status.HTTP_201_CREATED)

class CartDetailView(APIView):
    serializer_class = CartSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'id'
    queryset = Cart.objects.all()

    def get(self, request, *args, **kwargs):
        cart_id = self.kwargs.get('id')
        user = request.user
        try:
            cart = Cart.objects.get(id=cart_id, user=user)
        except Cart.DoesNotExist:
            return Response({"status": False, "message": "Cart not found"}, status=status.HTTP_404_NOT_FOUND)

        serializer = self.get_serializer(cart)
        return Response({"status": True, "data": serializer.data}, status=status.HTTP_200_OK)


class PaymentView(APIView):
    permission_classes = [IsAuthenticated]
    print('---------PaymentView-------------')

    def post(self, request):
        user = request.user
        amount = request.data.get('amount')

        if not amount:
            return Response({"status": False, "message": "Amount is required"}, status=status.HTTP_400_BAD_REQUEST)

        payment = Payment.objects.create(user=user, amount=amount, status='PENDING')

        # Simulate payment processing
        payment.status = 'COMPLETED'
        payment.save()

        return Response({"status": True, "message": "Payment completed", "data": PaymentSerializer(payment).data})
    
