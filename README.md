
# E-Commerce App with Flutter and FastAPI Microservice

This project is a fully functional **E-Commerce Application** built with **Flutter** for the frontend and **FastAPI** for a microservice (e.g., notifications). The app includes features like user authentication, product browsing, favorites, and notifications. It follows the **MVC architecture** and uses **GetX** for state management, **GoRouter** for navigation, and **Dio** for API communication.

---

## Features

### Flutter App
- **User Authentication**: Login and registration with token-based authentication.
- **Product Browsing**: View products with details like name, price, and image.
- **Favorites**: Add/remove products to/from favorites, persisted using `SharedPreferences`.
- **State Management**: Uses **GetX** for efficient state management.
- **Navigation**: Uses **GoRouter** for declarative routing and deep linking.
- **API Integration**: Communicates with a backend API using **Dio**.
- **Error Handling**: Custom exception handling for API errors.
- **Responsive Design**: Works on mobile, tablet, and web.

### FastAPI Microservice
- **Notifications**: A microservice built with **FastAPI** to handle real-time notifications (e.g., order updates, promotions).
- **RESTful API**: Exposes endpoints for sending and managing notifications.
- **Scalable**: Designed to be easily scalable for future features.

---

## Technologies Used

### Flutter App
- **Flutter**: UI framework for building cross-platform apps.
- **GetX**: State management, dependency injection, and navigation.
- **GoRouter**: Declarative routing for Flutter.
- **Dio**: HTTP client for API communication.
- **SharedPreferences**: Local storage for persisting user preferences and favorites.
- **TalkerDioLogger**: Logging for Dio requests and responses.

### FastAPI Microservice
- **FastAPI**: Modern Python web framework for building APIs.
- **Uvicorn**: ASGI server for running FastAPI.
- **WebSockets**: For real-time notifications (optional).
- **SQLite/PostgreSQL**: Database for storing notification data.

---

## Project Structure

### Flutter App
```
lib/
├── src/
│   ├── controllers/       # GetX controllers
│   ├── models/            # Data models
│   ├── services/          # API services
│   ├── views/             # UI screens
│   ├── widgets/           # Reusable UI components
│   ├── shared_pref/       # SharedPreferences helper
│   ├── exceptions/        # Custom exceptions
│   ├── routes/            # GoRouter configuration
├── main.dart              # App entry point
```

### FastAPI Microservice
```
fastapi-notifications/
├── app/
│   ├── api/               # API endpoints
│   ├── models/            # Database models
│   ├── services/          # Business logic
│   ├── utils/             # Helper functions
├── main.py                # FastAPI app entry point
```

---

## Setup Instructions

### Flutter App
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/ecommerce-app.git
   cd ecommerce-app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

4. **Environment Variables**:
   - Create a `.env` file in the root directory and add your API base URL:
     ```
     BASE_URL=http://your-api-url.com
     ```

### FastAPI Microservice
1. **Navigate to the FastAPI directory**:
   ```bash
   cd fastapi-notifications
   ```

2. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the FastAPI server**:
   ```bash
   uvicorn main:app --reload
   ```

4. **Access the API docs**:
   - Open your browser and go to `http://localhost:8000/docs` to view the Swagger UI.

---

## API Endpoints (FastAPI Microservice)

### Notifications
- **Send Notification**:
  ```
  POST /notifications/
  Body: { "user_id": 1, "message": "Your order has been shipped!" }
  ```

- **Get Notifications**:
  ```
  GET /notifications/{user_id}
  ```

- **Mark as Read**:
