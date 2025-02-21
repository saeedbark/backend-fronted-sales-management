from fastapi import FastAPI
from datetime import datetime, timedelta,timezone
from pydantic import BaseModel
from typing import List

app = FastAPI()

class CartItemRequest(BaseModel):
    productId: int
    quantity: int
    dateAdded: str  # ISO format date string
    price: float
    
  


from datetime import datetime, timezone, timedelta

@app.post("/check-overdue-items")
async def check_overdue_items(items: List[CartItemRequest]):
    current_time = datetime.now(timezone.utc)
    overdue_items = []
    
    for item in items:
        added_date = datetime.fromisoformat(item.dateAdded).astimezone(timezone.utc)
        time_diff = current_time - added_date
        days_diff = time_diff.days   # Get total days difference
        
        if time_diff > timedelta(minutes=5):
            overdue_items.append({
                "productId": item.productId,
                "original_quantity": item.quantity,
                "days_since_added": days_diff,
                "message": f"You should pay or remove this cart ({days_diff} days old)",
                "price": item.price,
                "date_added": item.dateAdded,
                "deadline_passed_by": f"{days_diff - 1} days"  # Days past 1-day limit
            })
    
    return {
        "server_check_time": current_time.isoformat(),
        "overdue_items": overdue_items
    }


# from fastapi import FastAPI
# from pydantic import BaseModel
# import uuid
# from datetime import datetime  # Add this import


# app = FastAPI()

# # Define data models
# class Product(BaseModel):
#     id: int
#     name: str
#     price: str
#     image: str
#     description: str | None = None
#     old_price: str | None = None
#     discount: str | None = None
#     is_favorite: bool = False
#     category_id: int

# class CartItem(BaseModel):
#     id: int
#     product: Product
#     quantity: int
#     total_price: float

# class CartData(BaseModel):
#     status: bool
#     data: dict

# class PaymentRequest(BaseModel):
#     cart: CartData

# @app.post("/process-payment/")
# async def process_payment(request: PaymentRequest):
#     try:
#         # Directly use the cart data from request
#         cart_data = request.cart.dict()
        
#         if not cart_data['status']:
#             return {
#                 "payment_id": str(uuid.uuid4()),
#                 "status": "failed",
#                 "message": "Invalid cart data"
#             }
        
#         total = cart_data['data']['total_cart_price']
        
#         return {
#             "payment_id": str(uuid.uuid4()),
#             "status": "success" if total > 0 else "failed",
#             "total_amount": total,
#             "message": "Payment processed successfully!" if total > 0 
#                       else "Invalid payment amount"
#         }
        
#     except KeyError:
#         return {
#             "payment_id": str(uuid.uuid4()),
#             "status": "failed",
#             "message": "Invalid cart structure"
#         }