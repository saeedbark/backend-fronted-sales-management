from fastapi import FastAPI
from pydantic import BaseModel
import uuid

app = FastAPI()

# Define data models
class Product(BaseModel):
    id: int
    name: str
    price: str
    image: str
    description: str | None = None
    old_price: str | None = None
    discount: str | None = None
    is_favorite: bool = False
    category_id: int

class CartItem(BaseModel):
    id: int
    product: Product
    quantity: int
    total_price: float

class CartData(BaseModel):
    status: bool
    data: dict

class PaymentRequest(BaseModel):
    cart: CartData

@app.post("/process-payment/")
async def process_payment(request: PaymentRequest):
    try:
        # Directly use the cart data from request
        cart_data = request.cart.dict()
        
        if not cart_data['status']:
            return {
                "payment_id": str(uuid.uuid4()),
                "status": "failed",
                "message": "Invalid cart data"
            }
        
        total = cart_data['data']['total_cart_price']
        
        return {
            "payment_id": str(uuid.uuid4()),
            "status": "success" if total > 0 else "failed",
            "total_amount": total,
            "message": "Payment processed successfully!" if total > 0 
                      else "Invalid payment amount"
        }
        
    except KeyError:
        return {
            "payment_id": str(uuid.uuid4()),
            "status": "failed",
            "message": "Invalid cart structure"
        }