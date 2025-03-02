from flask import Flask, jsonify, request
from flask_cors import CORS
import hmac
import hashlib

app = Flask(__name__)
app.config['SECRET_KEY'] = '42721553'  # Same as Django


CORS(app)

# Mock payment processor for Mauritius
def process_bankily_payment(amount, reference):
    # Implement actual Bankily API integration here
    return {
        'status': 'success',
        'transaction_id': f'BANKILY_{reference}',
        'amount': amount
    }

def process_sadad_payment(amount, reference):
    # Implement actual SADAD API integration here
    return {
        'status': 'pending',
        'transaction_id': f'SADAD_{reference}',
        'amount': amount,
        'payment_instructions': 'Pay at any MCB/SBM ATM using reference'
    }

@app.route('/process-payment', methods=['POST'])
def handle_payment():  
    # Verify authentication
    auth_header = request.headers.get('Authorization')
    if not verify_signature(auth_header, request.data):
        return jsonify({"error": "Unauthorized"}), 401

    data = request.json
    payment_method = data.get('payment_method', 'bankily')
    reference = f"{data['user_id']}-{data['cart_id']}"

    if payment_method == 'bankily':
        result = process_bankily_payment(data['amount'], reference)
    elif payment_method == 'sadad':
        result = process_sadad_payment(data['amount'], reference)
    else:
        return jsonify({"error": "Invalid payment method"}), 400

    return jsonify(result)

def verify_signature(auth_header, payload):
    secret = 'FLASK_SECRET' 
    expected_signature = hmac.new(secret, payload, hashlib.sha256).hexdigest()
    return hmac.compare_digest(auth_header, f"Bearer {expected_signature}")

if __name__ == '__main__':
 app.run(host='10.0.38.172', port=5000, debug=False)
