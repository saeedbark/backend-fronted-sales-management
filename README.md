
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

