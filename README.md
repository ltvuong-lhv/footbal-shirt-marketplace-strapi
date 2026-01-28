# Football Shirt Marketplace - Strapi Backend

Dự án backend cho marketplace áo bóng đá sử dụng Strapi và PostgreSQL với Docker.

## Cấu trúc Docker

Dự án bao gồm các container sau:
- **Strapi**: Backend CMS
- **PostgreSQL**: Database
- **pgAdmin**: Quản lý database (tùy chọn)
- **Nginx**: Reverse proxy cho production (tùy chọn)

## Cài đặt và chạy

### Development Environment

1. Clone repository và di chuyển vào thư mục:
```bash
cd football-shirt-marketplace-strapi
```

2. Tạo Strapi project (nếu chưa có):
```bash
npx create-strapi-app@latest . --quickstart --no-run
```

3. Chỉnh sửa file `.env` với thông tin cấu hình phù hợp

4. Chạy development environment:
```bash
docker-compose up -d
```

5. Truy cập ứng dụng:
- Strapi Admin: http://localhost:1337/admin
- pgAdmin (nếu sử dụng): http://localhost:5050

### Production Environment

1. Chỉnh sửa secrets trong file `.env` cho production

2. Build và chạy production:
```bash
docker-compose -f docker-compose.prod.yml up -d
```

3. Với Nginx reverse proxy:
```bash
docker-compose -f docker-compose.prod.yml --profile nginx up -d
```

## Các lệnh hữu ích

### Development
```bash
# Chạy containers
docker-compose up -d

# Xem logs
docker-compose logs -f strapi

# Dừng containers
docker-compose down

# Xóa volumes (sẽ mất dữ liệu database)
docker-compose down -v
```

### Production
```bash
# Build và chạy production
docker-compose -f docker-compose.prod.yml up -d --build

# Xem logs production
docker-compose -f docker-compose.prod.yml logs -f

# Dừng production
docker-compose -f docker-compose.prod.yml down
```

### Database Operations
```bash
# Backup database
docker-compose exec postgres pg_dump -U strapi strapi > backup.sql

# Restore database
docker-compose exec -T postgres psql -U strapi strapi < backup.sql

# Truy cập PostgreSQL shell
docker-compose exec postgres psql -U strapi -d strapi
```

## Cấu hình Environment Variables

### Quan trọng: Thay đổi các giá trị sau cho production!
- `JWT_SECRET`
- `ADMIN_JWT_SECRET`
- `APP_KEYS`
- `API_TOKEN_SALT`
- `TRANSFER_TOKEN_SALT`
- `POSTGRES_PASSWORD`

### Database Configuration
- `DATABASE_HOST`: postgres (tên container)
- `DATABASE_PORT`: 5432
- `DATABASE_NAME`: strapi
- `DATABASE_USERNAME`: strapi
- `DATABASE_PASSWORD`: strapi_password

## Ports

- **Strapi**: 1337
- **PostgreSQL**: 5432
- **pgAdmin**: 5050
- **Nginx**: 80, 443

## Volumes

- `postgres_data`: Lưu trữ dữ liệu PostgreSQL
- `.:/app`: Mount source code vào container Strapi (development)

## Networks

- `strapi-network`: Internal network cho các containers

## Security Notes

1. Thay đổi tất cả default passwords và secrets
2. Sử dụng HTTPS trong production
3. Giới hạn access từ bên ngoài
4. Backup database thường xuyên
5. Update images thường xuyên

## Troubleshooting

### Container không start được
```bash
docker-compose logs <service-name>
```

### Database connection issues
- Kiểm tra container postgres đã chạy chưa
- Kiểm tra environment variables
- Kiểm tra network connectivity

### Port conflicts
- Thay đổi ports trong docker-compose.yml nếu bị conflict

### Performance issues
- Tăng resources cho Docker
- Monitor container logs
- Optimize database queries