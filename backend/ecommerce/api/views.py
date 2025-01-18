from rest_framework.views import APIView
from rest_framework.response import Response

from rest_framework import status
from .serializers import RegisterSerializer, CustomTokenObtainPairSerializer, ProductSerializer,CategorySerializer,CartSerializer, PaymentSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import IsAuthenticated


from rest_framework.permissions import AllowAny

from .models import Product,Category,Cart, CartItem, Product, Payment


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
    
    print('---------CartView-------------')

    def get(self, request):
        user = request.user
        cart, created = Cart.objects.get_or_create(user=user)
        serializer = CartSerializer(cart)
        return Response({"status": True, "data": serializer.data})

    def post(self, request):
        
        user = request.user
        product_id = request.data.get('product_id')
        quantity = request.data.get('quantity', 1)
        cart, created = Cart.objects.get_or_create(user=user)

        try:
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            return Response({"status": False, "message": "Product not found"}, status=status.HTTP_404_NOT_FOUND)

        cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product)
        if not created:
            cart_item.quantity += int(quantity)
        else:
            cart_item.quantity = int(quantity)
        cart_item.save()

        return Response({"status": True, "message": "Item added to cart"})

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
    
