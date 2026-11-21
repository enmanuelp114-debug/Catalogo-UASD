# Catálogo de Carreras UASD

Aplicación de escritorio en **Java (Swing)** que consulta, en una base de datos **MySQL**, el catálogo de carreras de la UASD. El usuario elige una **Facultad**, luego una **Escuela**, y el programa muestra en una tabla las carreras de esa escuela con su nivel.

## Funcionalidades

- Carga las facultades desde la base de datos en un desplegable.
- Al elegir una facultad, carga solo las escuelas que le pertenecen.
- El botón **Buscar carreras** muestra en la tabla las carreras de la escuela seleccionada (facultad, escuela, carrera y nivel).
- El botón **Limpiar** vacía la tabla.
- Si no hay conexión con la base de datos, el programa muestra un mensaje de error en lugar de cerrarse.

## Tecnologías

| Parte | Tecnología |
|---|---|
| Lenguaje y interfaz | Java con Swing |
| IDE | Apache NetBeans |
| Base de datos | MySQL 8.0 (gestionada con MySQL Workbench) |
| Conexión | JDBC con el driver MySQL Connector/J |

## Requisitos y dependencias

Software que debe estar instalado:

| Requisito | Versión usada en el desarrollo | Para qué se usa |
|---|---|---|
| JDK (Java Development Kit) | JDK 26 | Compilar y ejecutar el programa |
| Apache NetBeans | 31 | Abrir y ejecutar el proyecto |
| MySQL Server | 8.0 (el script también es compatible con MariaDB 10.5 o superior) | Guardar la base de datos |
| MySQL Workbench | 8.0 | Importar el script y consultar las tablas |
| MySQL Connector/J (driver JDBC) | 26.10.0 | Conectar Java con MySQL |

El driver viene incluido en el repositorio: `CatalogoUASD/dist/lib/mysql-connector-j-26.10.0.jar`. Swing forma parte del JDK, así que no hay que instalar nada más.

### Configuración de la conexión

Se define en `CatalogoUASD/src/catalogouasd/Conexion.java`:

| Parámetro | Valor |
|---|---|
| Servidor | `localhost` |
| Puerto | `3306` |
| Base de datos | `uasd_catalogo` |
| Usuario | `root` (o el usuario de tu MySQL) |
| Contraseña | **la de tu MySQL local** (hay que escribirla en `Conexion.java`) |

La URL de conexión queda así: `jdbc:mysql://localhost:3306/uasd_catalogo`

## Estructura del proyecto

```
uasd_catalogo.sql              Script de la base de datos (tablas y datos)
CatalogoUASD/                  Proyecto de NetBeans
├── src/
│   ├── catalogouasd/
│   │   ├── Conexion.java          Abre la conexión con MySQL
│   │   ├── VentanaCatalogo.java   Ventana principal y consultas
│   │   └── VentanaCatalogo.form   Archivo de diseño de NetBeans
│   └── PruebaConexion.java        Programa para probar la conexión
├── dist/lib/                  Driver JDBC (mysql-connector-j-26.10.0.jar)
├── nbproject/                 Configuración de NetBeans
└── build.xml
```

## Base de datos

El script `uasd_catalogo.sql` crea la base `uasd_catalogo` con tres tablas relacionadas:

- `facultad`: una facultad tiene muchas escuelas.
- `escuela`: tiene una llave foránea `facultad_id`. Una escuela tiene muchas carreras.
- `carrera`: tiene una llave foránea `escuela_id`, el nombre y el nivel (Técnico, Técnico Superior, Tecnólogo, Grado u Otro).

## Instalación

### 1. Descargar el proyecto

Clona el repositorio o descárgalo como ZIP desde GitHub (**Code → Download ZIP**) y descomprímelo:

```
git clone <URL-del-repositorio>
```

### 2. Instalar la base de datos

1. Asegúrate de que el servicio **MySQL80** esté encendido (en Windows: `Win + R` → `services.msc` → clic derecho sobre *MySQL80* → **Iniciar**).
2. Abre **MySQL Workbench** y conéctate a tu servidor local (*Local instance MySQL80*) con tu usuario y contraseña.
3. Ve a **File → Open SQL Script** y elige `uasd_catalogo.sql`.
4. Ejecuta todo el script con el rayo (*Execute*) o con `Ctrl + Shift + Enter`.
5. En el panel **SCHEMAS**, haz clic derecho → **Refresh All**. Debe aparecer `uasd_catalogo` con sus tablas.

Para comprobarlo, ejecuta:

```sql
USE uasd_catalogo;
SHOW TABLES;
SELECT COUNT(*) FROM carrera;
```

### 3. Configurar la contraseña

Abre `CatalogoUASD/src/catalogouasd/Conexion.java` y cambia el usuario y la contraseña por los de tu MySQL:

```java
String usuario = "root";
String password = "tu_contraseña";
```

### 4. Abrir el proyecto en NetBeans

1. En NetBeans: **File → Open Project** y selecciona la carpeta `CatalogoUASD`.
2. Agrega el driver: clic derecho sobre el proyecto → **Properties → Libraries → Classpath → Add JAR/Folder** y elige `CatalogoUASD/dist/lib/mysql-connector-j-26.10.0.jar`. Si aparece una referencia rota a otro jar, quítala (*Remove*).
3. Si tu JDK no es el 26: en **Properties → Sources**, cambia **Source/Binary Format** a la versión de tu JDK, y en **Libraries → Java Platform** elige el JDK que tengas.

## Ejecución

1. (Opcional) Para probar la conexión, abre `PruebaConexion.java` y presiona `Shift + F6`. En la consola debe aparecer un mensaje de conexión exitosa.
2. Abre `VentanaCatalogo.java` y presiona `Shift + F6` (**Run File**) para ver la ventana.
3. Elige una **Facultad** y una **Escuela**, y presiona **Buscar carreras**. Las carreras aparecen en la tabla.

El botón verde **Run Project** ejecuta `PruebaConexion`, porque es la clase principal configurada. Si quieres que abra la ventana, ve a **Properties → Run → Main Class** y elige `catalogouasd.VentanaCatalogo`.

## Solución de problemas

| Problema | Causa probable y solución |
|---|---|
| `Communications link failure` o *Unable to connect to localhost:3306* | MySQL está apagado. Inicia el servicio **MySQL80**. |
| `Access denied for user 'root'` | La contraseña en `Conexion.java` no coincide con la de tu MySQL. |
| `Unknown database 'uasd_catalogo'` | No se ejecutó el script `uasd_catalogo.sql`. Impórtalo desde Workbench. |
| `ClassNotFoundException: com.mysql.cj.jdbc.Driver` | Falta el driver. Agrégalo en **Properties → Libraries**. |
| Los desplegables aparecen vacíos | La conexión falló o la base no tiene datos. Revisa los pasos de la base de datos. |
| Tildes o la letra ñ se ven mal | Abre el script como UTF-8 y ejecuta todo de nuevo. La base usa `utf8mb4`. |

## Integrantes

- Pedro Junior Rosario Martinez
- Emmanuel Rosa Sanchez
- Leo castillo
