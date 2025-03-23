# Room911 - Sistema de Control de Acceso

Room911 es una aplicación web diseñada para el control de acceso y autenticación de empleados. Proporciona un inicio de sesión seguro, control de acceso basado en roles y validación en tiempo real de credenciales de empleados.

## 🚀 Tecnologías Utilizadas

- **Laravel 11** - Framework backend para gestionar autenticación y lógica de negocio.
- **Vue.js 3** - Framework frontend para interacciones dinámicas con el usuario.
- **Breeze** - Esqueleto de autenticación simple para Laravel y Vue.
- **MySQL** - Base de datos relacional para almacenar empleados y registros de acceso.
- **Arquitectura Monolítica** - Estructura centralizada para facilitar el despliegue.
- **Vite** - Herramienta moderna de frontend para desarrollo rápido y recarga en vivo.

---

## 📂 Estructura del Proyecto

```
room911/
├── app/Http/Controllers/         # Controladores de Laravel
├── app/Http/Middleware/          # Middlewares personalizados
├── resources/js/Pages/           # Componentes de Vue.js
├── routes/web.php                # Rutas de la aplicación
├── database/migrations/          # Esquema de base de datos
├── database/seeders/             # Seeders de datos iniciales
├── public/                       # Archivos públicos
├── storage/                      # Almacenamiento de archivos
└── vite.config.js                # Configuración de Vite
```

---

## 🛠 Pasos de Instalación

### 1️⃣ Clonar el Repositorio
```sh
git clone https://github.com/itdyaingenieria/room_911.git
cd room_911
```

### 2️⃣ Instalar Dependencias
```sh
composer install
npm install
```

### 3️⃣ Configurar Variables de Entorno
Copiar el archivo `.env.example` y configurar las credenciales de la base de datos:
```sh
cp .env.example .env
```
Editar el archivo `.env` y definir MySQL:
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=room911
DB_USERNAME=root
DB_PASSWORD=tucontraseña
```

### 4️⃣ Generar Clave de Aplicación
```sh
php artisan key:generate
```

### 5️⃣ Ejecutar Migraciones y Seeders
```sh
php artisan migrate:refresh
```

### 6️⃣ Iniciar el Servidor de Desarrollo
```sh
php artisan serve
```

### 7️⃣ Ejecutar Vite para el Frontend
```sh
npm run dev
```

---

## 🔑 Autenticación
Room911 utiliza Laravel Breeze para la autenticación. Los usuarios pueden registrarse, iniciar sesión y acceder a rutas protegidas.

Para crear un usuario administrador, ejecutar:
```sh
php artisan tinker
```
Luego, dentro de Tinker, ingresar:
```php
User::create([ 'name' => 'Admin room911', 'email' => 'admin@itdyaingenieria.com', 'password' => bcrypt('pass2025'), 'is_superuser'=> '1' ]);
```

---

## 📌 Funcionalidades

✅ **Validación de Acceso de Empleados** - Sistema de inicio de sesión seguro con control de acceso.
✅ **Protección con Middleware** - Rutas aseguradas con middlewares personalizados en Laravel.
✅ **Registros de Acceso en Tiempo Real** - Se almacenan inicios de sesión y actividades en MySQL.
✅ **Interfaz Dinámica con Vue.js** - Frontend construido con Vue 3 e Inertia.js.
✅ **Control de Acceso Basado en Roles (RBAC)** - Diferentes roles de usuario para gestionar permisos.

---

## 📄 Endpoints de la API

### 🔹 **Departamentos**
| Método | Endpoint                     | Descripción |
|--------|------------------------------|-------------|
| GET    | `/departments`               | Listar departamentos |
| GET    | `/departments/create`        | Formulario para crear un departamento |
| POST   | `/departments`               | Guardar un nuevo departamento |
| GET    | `/departments/{department}/edit` | Formulario para editar un departamento |
| PUT    | `/departments/{department}`  | Actualizar información de un departamento |
| DELETE | `/departments/{department}`  | Eliminar un departamento |

### 🔹 **Empleados**
| Método | Endpoint                     | Descripción |
|--------|------------------------------|-------------|
| GET    | `/employees`                 | Listar empleados |
| GET    | `/employees/create`          | Formulario para crear un empleado |
| POST   | `/employees`                 | Guardar un nuevo empleado |
| GET    | `/employees/{employee}/edit` | Formulario para editar un empleado |
| GET    | `/employees/{employee}/edit-axios` | Obtener datos de un empleado para edición vía Axios |
| PUT    | `/employees/{employee}`      | Actualizar información de un empleado |
| DELETE | `/employees/{employee}`      | Eliminar un empleado |
| POST   | `/employees/upload-csv`      | Subir un archivo CSV con empleados |

### 🔹 **Simulador de Acceso**
| Método | Endpoint                     | Descripción |
|--------|------------------------------|-------------|
| GET    | `/validate-access`           | Mostrar el formulario de validación de acceso |
| POST   | `/validate-access`           | Validar el acceso de un empleado |
| GET    | `/access-simulator/dashboard` | Mostrar el panel de acceso |
| POST   | `/access-simulator/logout`   | Cerrar sesión |

---

## 📝 Licencia

Este proyecto está bajo la licencia MIT.

---

## 📧 Contacto
Para preguntas o soporte, contacta a **diegoyamaa@gmail.com**.

---

🎉 ¡Prueba Laravel 2025-marzo! 

