from rest_framework.views import APIView
from rest_framework.response import Response
from django.core.mail import send_mail
from django.conf import settings
from rest_framework import status
from .serializers import RegisterSerializer, CustomTokenObtainPairSerializer, ProductSerializer,CategorySerializer,CartSerializer, PaymentSerializer,PasswordResetRequestSerializer, PasswordResetConfirmSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import IsAuthenticated
from django.utils import timezone
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode,urlsafe_base64_decode
from django.utils.encoding import force_bytes





from rest_framework.permissions import AllowAny

from .models import PasswordResetToken, User,Product,Category,Cart, CartItem, Product, Payment


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
        email = request.data.get('email')  # Get email from request
        try:
            user = User.objects.get(email=email)  # Check if user exists
            
            # Generate Reset Token
            token = default_token_generator.make_token(user)
            uid = urlsafe_base64_encode(force_bytes(user.pk))  # Encode User ID
            
            # Generate Password Reset Link
            reset_link = f"http://yourfrontend.com/reset-password/\nID:{uid}\nToken:{token}/"
            
            # Send Email with Reset Link
            send_mail(
                "Password Reset Request",
                f"Click the link below to reset your password:\n{reset_link}",
                settings.EMAIL_HOST_USER,
                [user.email],
                fail_silently=False,
            )
            
            return Response({"message": "Password reset link sent to your email"}, status=status.HTTP_200_OK)

        except User.DoesNotExist:
            return Response({"error": "User with this email does not exist."}, status=status.HTTP_400_BAD_REQUEST)
class PasswordResetConfirmView(APIView):
    def post(self, request, uidb64, token):
        try:
            # Decode UID
            uid = urlsafe_base64_decode(uidb64).decode()
            user = User.objects.get(pk=uid)

            # Verify the Token
            if not default_token_generator.check_token(user, token):
                return Response({"error": "Invalid or expired token"}, status=status.HTTP_400_BAD_REQUEST)

            # Update Password
            new_password = request.data.get("new_password")
            if not new_password:
                return Response({"error": "New password is required"}, status=status.HTTP_400_BAD_REQUEST)

            user.set_password(new_password)
            user.save()

            return Response({"message": "Password reset successful"}, status=status.HTTP_200_OK)

        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            return Response({"error": "Invalid request"}, status=status.HTTP_400_BAD_REQUEST)

        
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
    
