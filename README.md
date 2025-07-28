# Diary Backend API

A modern Ruby on Rails API for a diary application with mood tracking and activity management.

## 🚀 Features

- **User Authentication**: JWT-based authentication system
- **Diary Entries**: Create, read, update, and delete diary entries
- **Mood Tracking**: Track daily moods with timestamps
- **Activity Management**: Log and manage user activities
- **RESTful API**: Clean, RESTful API design
- **Modern Rails**: Built with Rails 8.0 and Ruby 3.2

## 🛠 Tech Stack

- **Ruby**: 3.2.2
- **Rails**: 8.0.2
- **PostgreSQL**: 15+
- **JWT**: For authentication
- **Docker**: Containerization
- **RSpec**: Testing framework

## 📋 Prerequisites

- Ruby 3.2.2 or higher
- PostgreSQL 15 or higher
- Docker and Docker Compose (optional)

## 🚀 Quick Start

### Using Docker (Recommended)

1. Clone the repository:
```bash
git clone <repository-url>
cd FP-SJ-backend
```

2. Start the services:
```bash
docker-compose up -d
```

3. Setup the database:
```bash
docker-compose exec web bundle exec rails db:create db:migrate db:seed
```

4. Access the API at `http://localhost:3000`

### Manual Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd FP-SJ-backend
```

2. Install dependencies:
```bash
bundle install
```

3. Setup environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Setup the database:
```bash
bundle exec rails db:create db:migrate db:seed
```

5. Start the server:
```bash
bundle exec rails server
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file with the following variables:

```env
DATABASE_URL=postgresql://username:password@localhost:5432/diary_backend_development
JWT_SECRET=your_jwt_secret_here
RAILS_ENV=development
```

**⚠️ Security Note**: Never commit your `.env` file to version control. Use `config/application.example.yml` as a template and generate secure secrets.

### Generate Secure Secrets

```bash
# Generate a secure JWT secret
rails secret

# Or use Ruby
ruby -e "puts SecureRandom.hex(64)"
```

### Database Configuration

The application uses PostgreSQL. Update `config/database.yml` if needed.

## 📚 API Documentation

### Authentication

All API endpoints require authentication except for login.

**Login:**
```http
POST /api/v1/login
Content-Type: application/json

{
  "username": "your_username",
  "password": "your_password"
}
```

**Response:**
```json
{
  "user": {
    "id": 1,
    "username": "your_username"
  },
  "token": "jwt_token_here"
}
```

### Endpoints

#### Users
- `GET /api/v1/users` - List all users
- `POST /api/v1/users` - Create a new user
- `GET /api/v1/users/:id` - Get user details
- `PUT /api/v1/users/:id` - Update user
- `DELETE /api/v1/users/:id` - Delete user

#### Diary Entries
- `GET /diary_entries` - List diary entries
- `POST /diary_entries` - Create diary entry
- `GET /diary_entries/:id` - Get diary entry
- `PUT /diary_entries/:id` - Update diary entry
- `DELETE /diary_entries/:id` - Delete diary entry

#### Moods
- `GET /moods` - List moods
- `POST /moods` - Create mood
- `GET /moods/:id` - Get mood
- `PUT /moods/:id` - Update mood
- `DELETE /moods/:id` - Delete mood

#### Activities
- `GET /activities` - List activities
- `POST /activities` - Create activity
- `GET /activities/:id` - Get activity
- `PUT /activities/:id` - Update activity
- `DELETE /activities/:id` - Delete activity

## 🧪 Testing

Run the test suite:

```bash
# Using Docker
docker-compose exec web bundle exec rspec

# Manual setup
bundle exec rspec
```

Run specific tests:

```bash
bundle exec rspec spec/controllers/
bundle exec rspec spec/models/
```

## 🔍 Code Quality

### RuboCop

Check code style:

```bash
bundle exec rubocop
```

Auto-fix issues:

```bash
bundle exec rubocop -a
```

### Security

Check for security vulnerabilities:

```bash
bundle exec bundle-audit
bundle exec brakeman
```

## 🚀 Deployment

### Production Setup

1. Set environment variables:
```bash
export RAILS_ENV=production
export DATABASE_URL=your_production_database_url
export JWT_SECRET=your_secure_jwt_secret
```

2. Precompile assets:
```bash
bundle exec rake assets:precompile
```

3. Run database migrations:
```bash
bundle exec rails db:migrate
```

### Docker Production

Build and run the production image:

```bash
docker build -t diary-backend .
docker run -p 3000:3000 -e RAILS_ENV=production diary-backend
```

## 📝 Development

### Code Style

This project follows the Ruby Style Guide and uses RuboCop for enforcement.

### Git Workflow

1. Create a feature branch
2. Make your changes
3. Run tests and linting
4. Submit a pull request

### Database Migrations

Create a new migration:

```bash
bundle exec rails generate migration MigrationName
```

Run migrations:

```bash
bundle exec rails db:migrate
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

For support, please open an issue in the GitHub repository.
