-- Catálogo de carreras UASD basado en la Oferta Académica 2024.
-- Motor: MySQL 8.0+ / MariaDB 10.5+.

CREATE DATABASE IF NOT EXISTS uasd_catalogo
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE uasd_catalogo;

CREATE TABLE IF NOT EXISTS facultad (
  facultad_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(160) NOT NULL,
  PRIMARY KEY (facultad_id), UNIQUE KEY uq_facultad_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS escuela (
  escuela_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  facultad_id SMALLINT UNSIGNED NOT NULL,
  nombre VARCHAR(180) NOT NULL,
  PRIMARY KEY (escuela_id), UNIQUE KEY uq_escuela_facultad (facultad_id, nombre),
  CONSTRAINT fk_escuela_facultad FOREIGN KEY (facultad_id)
    REFERENCES facultad (facultad_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS carrera (
  carrera_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  escuela_id SMALLINT UNSIGNED NOT NULL,
  nombre VARCHAR(240) NOT NULL,
  nivel ENUM('Técnico','Técnico Superior','Tecnólogo','Grado','Otro') NOT NULL DEFAULT 'Grado',
  proyectada BOOLEAN NOT NULL DEFAULT FALSE,
  observacion VARCHAR(400) NULL,
  PRIMARY KEY (carrera_id),
  UNIQUE KEY uq_carrera_escuela_nombre (escuela_id, nombre),
  KEY ix_carrera_escuela_nombre (escuela_id, nombre),
  CONSTRAINT fk_carrera_escuela FOREIGN KEY (escuela_id)
    REFERENCES escuela (escuela_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO facultad (facultad_id,nombre) VALUES
(1,'Facultad de Humanidades'),
(2,'Facultad de Ciencias'),
(3,'Facultad de Ciencias Económicas y Sociales'),
(4,'Facultad de Ciencias Jurídicas y Políticas'),
(5,'Facultad de Ingeniería y Arquitectura'),
(6,'Facultad de Ciencias de la Salud'),
(7,'Facultad de Ciencias Agronómicas y Veterinarias'),
(8,'Facultad de Artes'),
(9,'Facultad de Ciencias de la Educación');

INSERT IGNORE INTO escuela (escuela_id,facultad_id,nombre) VALUES
(1,1,'Escuela de Letras'),(2,1,'Escuela de Filosofía'),(3,1,'Escuela de Idiomas'),
(4,1,'Escuela de Comunicaciones'),(5,1,'Escuela de Historia y Antropología'),(6,1,'Escuela de Psicología'),
(7,2,'Escuela de Matemática'),(8,2,'Escuela de Química'),(9,2,'Escuela de Biología'),
(10,2,'Escuela de Física'),(11,2,'Escuela de Informática'),(12,2,'Escuela de Ciencias Geográficas'),
(13,2,'Escuela de Microbiología y Parasitología'),
(14,3,'Escuela de Administración'),(15,3,'Escuela de Economía'),(16,3,'Escuela de Mercadotecnia'),
(17,3,'Escuela de Estadística'),(18,3,'Escuela de Sociología'),(19,3,'Escuela de Contabilidad'),(20,3,'Escuela de Turismo y Hotelería'),
(21,4,'Escuela de Derecho'),(22,4,'Escuela de Ciencias Políticas'),
(23,5,'Escuela de Agrimensura'),(24,5,'Escuela de Arquitectura'),(25,5,'Escuela de Ingeniería Civil'),
(26,5,'Escuela de Ingeniería Electromecánica'),(27,5,'Escuela de Ingeniería Química'),(28,5,'Escuela de Ingeniería Industrial'),
(29,6,'Escuela de Bioanálisis'),(30,6,'Escuela de Enfermería'),(31,6,'Escuela de Farmacia'),
(32,6,'Escuela de Medicina'),(33,6,'Escuela de Odontología'),(34,6,'Escuela de Salud Pública'),(35,6,'Escuela de Ciencias Fisiológicas'),
(36,7,'Escuela de Ingeniería Agronómica'),(37,7,'Escuela de Medicina Veterinaria'),(38,7,'Escuela de Zootecnia'),
(39,8,'Escuela de Artes Plásticas'),(40,8,'Escuela de Cine, TV y Fotografía'),
(41,8,'Escuela de Crítica e Historia del Arte'),(42,8,'Escuela de Música'),(43,8,'Escuela de Publicidad'),
(44,8,'Escuela de Teatro y Danza'),(45,8,'Escuela de Diseño Industrial y de Moda'),
(46,9,'Escuela de Bibliotecología, Tecnología e Innovaciones Educativas'),
(47,9,'Escuela de Formación Docente para la Educación Infantil y Básica (FIB)'),
(48,9,'Escuela de Formación Docente para la Educación Media (FEM)'),
(49,9,'Escuela de Orientación Educativa y Psicopedagogía'),
(50,9,'Escuela de Formación Docente en Educación Física y Ciencias del Deporte'),
(51,9,'Escuela de Teoría y Gestión Educativa');

INSERT IGNORE INTO carrera (escuela_id,nombre,nivel,proyectada,observacion) VALUES
-- Humanidades
(1,'Licenciatura en Letras','Grado',0,NULL),(1,'Licenciatura en Lengua Española y Literatura orientada a la Educación','Grado',0,NULL),
(2,'Licenciatura en Filosofía','Grado',0,NULL),(3,'Licenciatura en Lengua y Literatura Francesa','Grado',0,NULL),
(3,'Licenciatura en Lengua y Literatura Inglesa','Grado',0,NULL),(4,'Licenciatura en Comunicación mención Relaciones Públicas','Grado',0,NULL),
(4,'Licenciatura en Periodismo','Grado',0,NULL),(5,'Licenciatura en Historia','Grado',0,NULL),(5,'Licenciatura en Antropología','Grado',0,NULL),
(6,'Licenciatura en Psicología Educativa','Grado',0,NULL),(6,'Licenciatura en Psicología Social','Grado',0,NULL),
(6,'Licenciatura en Psicología Organizacional','Grado',0,NULL),(6,'Licenciatura en Psicología Clínica','Grado',0,NULL),
(6,'Licenciatura en Psicología del Desarrollo','Grado',0,NULL),
-- Ciencias
(7,'Licenciatura Matemática','Grado',0,NULL),(8,'Licenciatura en Ciencia y Tecnología de Alimentos','Grado',0,NULL),
(8,'Licenciatura en Química','Grado',0,NULL),(9,'Licenciatura en Biología','Grado',0,NULL),(10,'Licenciatura en Física','Grado',0,NULL),
(10,'Licenciatura en Ciencias de la Atmósfera','Grado',0,NULL),(10,'Licenciatura en Ciencias Geológica','Grado',0,NULL),
(11,'Técnico Superior en Desarrollo de Software','Técnico Superior',0,NULL),(11,'Técnico Superior en Desarrollo Aplicaciones Móviles','Técnico Superior',0,NULL),
(11,'Técnico Superior en Infraestructura de TIC','Técnico Superior',0,NULL),(11,'Técnico Superior Desarrollo App Animación y Videojuegos','Técnico Superior',0,NULL),
(11,'Técnico Superior en Administración de Redes','Técnico Superior',0,NULL),(11,'Licenciatura en Informática','Grado',0,NULL),
(11,'Ingeniería en Ciencias de Datos','Grado',0,NULL),(11,'Ingeniería de Software','Grado',0,NULL),
(11,'Ingeniería en Inteligencia Artificial y Robótica','Grado',0,NULL),(11,'Ingeniería de Sistemas y Computación','Grado',0,NULL),
(11,'Ingeniería en Sistemas y Ciberseguridad','Grado',0,NULL),
(12,'Licenciatura en Geografía mención Recursos Naturales y Ecoturísticos','Grado',0,NULL),
(13,'Licenciatura en Microbiología y Parasitología','Grado',0,NULL),
-- Económicas y Sociales
(14,'Técnico Superior en Administración Pública','Técnico Superior',0,NULL),(14,'Técnico Superior en Servicios y Gestión Municipal','Técnico Superior',0,NULL),
(14,'Técnico Superior en Administración de Mipymes','Técnico Superior',0,NULL),(14,'Licenciatura en Administración de Empresas','Grado',0,NULL),
(15,'Licenciatura en Economía','Grado',0,NULL),(15,'Licenciatura en Comercio Exterior y Aduanas','Grado',0,NULL),
(16,'Licenciatura en Mercadotecnia','Grado',0,NULL),(17,'Licenciatura en Estadística y Ciencias de Datos','Grado',0,NULL),
(18,'Licenciatura en Trabajo Social','Grado',0,NULL),(18,'Licenciatura en Sociología','Grado',0,NULL),
(19,'Licenciatura en Contabilidad','Grado',0,NULL),(20,'Licenciatura en Turismo y Hostelería','Grado',0,NULL),
(20,'Técnico en Gestión en Alojamientos Turísticos','Técnico',0,NULL),
-- Jurídicas y Políticas
(21,'Licenciatura en Derecho','Grado',0,NULL),(22,'Licenciatura en Ciencias Políticas','Grado',0,NULL),
-- Ingeniería y Arquitectura
(23,'Técnico Superior en Agrimensura','Técnico Superior',0,NULL),(23,'Licenciatura en Agrimensura','Grado',0,NULL),
(23,'Plan de Nivelación para Egresados de Agrimensura','Otro',0,'El catálogo lo lista como programa; no especifica el grado.'),
(24,'Arquitectura','Grado',0,NULL),(25,'Ingeniería Civil','Grado',0,NULL),
(26,'Ingeniería en Telecomunicación y Sistemas Electrónicos','Grado',0,NULL),(26,'Ingeniería Eléctrica en Potencia y Controles','Grado',0,NULL),
(26,'Ingeniería Mecánica','Grado',0,NULL),(27,'Ingeniería Química','Grado',0,NULL),(28,'Ingeniería Industrial','Grado',0,NULL),
-- Salud
(29,'Técnico Radiólogo','Técnico',0,NULL),(29,'Licenciatura en Bioanálisis','Grado',0,NULL),
(29,'Licenciatura en Imagenología','Grado',0,NULL),(29,'Técnico Superior en Radioterapia y Dosimetría','Técnico Superior',0,NULL),
(30,'Licenciatura en Enfermería','Grado',0,NULL),(31,'Licenciatura en Farmacia','Grado',0,NULL),(31,'Técnico Superior en Farmacia','Técnico Superior',0,NULL),
(32,'Doctor en Medicina','Grado',0,'Denominación reproducida del catálogo.'),(32,'Pre-Médica/Medicina','Otro',0,NULL),(32,'Residencia Médica','Otro',0,'El catálogo la lista dentro de la oferta de la escuela.'),
(33,'Técnico Superior en Higiene Dental','Técnico Superior',0,NULL),(33,'Técnico Superior en Laboratorio Dental','Técnico Superior',0,NULL),
(33,'Doctor en Odontología','Grado',0,'Denominación reproducida del catálogo.'),
(34,'Técnico Superior en Atención Prehospitalaria','Técnico Superior',0,NULL),
(35,'Licenciatura en Fisioterapia','Grado',0,NULL),(35,'Licenciatura en Terapia Ocupacional','Grado',0,NULL),
(35,'Licenciatura en Logopedia','Grado',0,NULL),
-- Agronómicas y Veterinarias
(36,'Ingeniero Agrónomo mención Suelo y Riego','Grado',0,NULL),(36,'Ingeniero Agrónomo mención Producción de Cultivos','Grado',0,NULL),
(36,'Ingeniero Agrónomo mención Desarrollo Agrícola y Rural','Grado',0,NULL),
(37,'Licenciado en Medicina Veterinaria','Grado',0,NULL),(38,'Ingeniero en Zootecnia','Grado',0,NULL),
(38,'Ingeniero en Lácteo Alimentaria','Grado',0,NULL),(38,'Tecnólogo en Procesos Lácteo Alimentario','Tecnólogo',0,NULL),
(38,'Técnico Superior en Gestión Ganadera','Técnico Superior',0,NULL),(38,'Técnico Superior en Gestión Acuícola','Técnico Superior',0,NULL),
-- Artes: el asterisco denota oferta proyectada en el catálogo.
(39,'Licenciatura en Artes Visuales','Grado',1,'Proyectada según nota (*) del catálogo.'),
(39,'Licenciatura en Escultura','Grado',1,'Proyectada según nota (*) del catálogo.'),
(39,'Licenciatura en Plástica y Animación de Cómic','Grado',1,'Proyectada según nota (*) del catálogo.'),
(40,'Licenciatura en Cinematografía y Audiovisuales mención Cine','Grado',0,NULL),
(40,'Licenciatura en Cinematografía y Audiovisuales mención Televisión','Grado',0,NULL),
(40,'Técnico en Fotografía y Medios Audiovisuales','Técnico',0,NULL),
(40,'Técnico Superior en Cinematografía','Técnico Superior',1,'Proyectada según nota (*) del catálogo.'),
(40,'Técnico Superior en Televisión','Técnico Superior',1,'Proyectada según nota (*) del catálogo.'),
(41,'Licenciatura en Historia y Crítica del Arte','Grado',0,NULL),
(41,'Licenciatura en Educación Artística','Grado',1,'Proyectada según nota (*) del catálogo.'),
(42,'Licenciatura en Teoría y Educación Musical','Grado',0,NULL),
(42,'Licenciatura en Dirección Coral','Grado',1,'Proyectada según nota (*) del catálogo.'),
(42,'Técnico Superior en Música','Técnico Superior',1,'Proyectada según nota (*) del catálogo.'),
(43,'Licenciatura en Publicidad mención Diseño','Grado',0,NULL),
(43,'Licenciatura en Publicidad mención Ilustración','Grado',0,NULL),
(43,'Licenciatura en Publicidad mención Creatividad y Gerencia','Grado',0,NULL),
(43,'Licenciatura en Diseño Gráfico y Editorial','Grado',1,'Proyectada según nota (*) del catálogo.'),
(43,'Licenciatura en Dirección y Creatividad Publicitaria','Grado',1,'Proyectada según nota (*) del catálogo.'),
(43,'Licenciatura en Diseño Digital y Multimedia','Grado',1,'Proyectada según nota (*) del catálogo.'),
(44,'Licenciatura en Teatro','Grado',0,NULL),(44,'Licenciatura en Teatro mención Actuación','Grado',0,NULL),
(44,'Licenciatura en Teatro mención Dirección','Grado',0,NULL),(44,'Licenciatura en Teatro mención Dramaturgia','Grado',0,NULL),
(44,'Licenciatura en Actuación','Grado',1,'Proyectada según nota (*) del catálogo.'),
(44,'Licenciatura en Dramaturgia y Dirección','Grado',1,'Proyectada según nota (*) del catálogo.'),
(44,'Licenciatura en Danza Contemporánea','Grado',1,'Proyectada según nota (*) del catálogo.'),
(45,'Licenciatura en Diseño de Modas','Grado',0,NULL),(45,'Licenciatura en Diseño Industrial','Grado',0,NULL),
(45,'Licenciatura en Diseño Artesanal y de Ambientes','Grado',0,NULL),
-- Ciencias de la Educación
(46,'Licenciatura en Bibliotecología y Ciencias de la Información','Grado',0,NULL),
(46,'Licenciatura en Educación mención Bibliotecología','Grado',0,NULL),
(46,'Licenciatura en Educación mención Informática Educativa','Grado',0,NULL),
(47,'Licenciatura en Educación Básica','Grado',0,NULL),(47,'Licenciatura en Educación Infantil','Grado',0,NULL),
(47,'Licenciatura en Educación Inicial','Grado',0,NULL),
(47,'Licenciatura en Educación mención Primer Ciclo de Educación Primaria','Grado',0,NULL),
(47,'Licenciatura en Educación mención Segundo Ciclo de Educación Primaria','Grado',0,NULL),
(47,'Licenciatura en Educación mención Arte Escolar','Grado',0,NULL),
(48,'Licenciatura en Educación mención Letras','Grado',0,NULL),
(48,'Licenciatura en Educación Media mención Biología y Química','Grado',0,NULL),
(48,'Licenciatura en Educación Media mención Ciencias Sociales','Grado',0,NULL),
(48,'Licenciatura en Educación Media mención Física y Matemáticas','Grado',0,NULL),
(48,'Licenciatura en Educación Media mención Francés','Grado',0,NULL),
(48,'Licenciatura en Educación Media mención Inglés','Grado',0,NULL),
(49,'Licenciatura en Educación Especial e Inclusiva','Grado',0,NULL),
(49,'Licenciatura en Educación mención Orientación Académica','Grado',0,NULL),
(49,'Licenciatura en Educación mención Orientación Socio-Comunitaria','Grado',0,NULL),
(49,'Licenciatura en Educación mención Orientación para el Desarrollo de Recursos Humanos','Grado',0,NULL),
(49,'Licenciatura en Educación mención Orientación Educativa y Psicopedagógica','Grado',0,NULL),
(50,'Técnico Superior en Educación Física','Técnico Superior',0,NULL),
(50,'Técnico Superior en Entrenamiento Deportivo','Técnico Superior',0,NULL),
(50,'Licenciatura en Educación Física','Grado',0,NULL),
(50,'Licenciatura en Actividad Física, Salud y Fitness','Grado',0,NULL),
(50,'Licenciatura en Cultura Física y Deportes','Grado',0,NULL),
(51,'Licenciatura en Educación mención Gestión Educativa','Grado',0,NULL),
(51,'Licenciatura en Educación para Personas Jóvenes y Adultas','Grado',0,NULL),
(51,'Licenciatura en Educación mención Formación Humana y Ciudadanía','Grado',0,NULL);

-- Vista para que Java consulte mostrando escuela y facultad junto a cada carrera.
CREATE OR REPLACE VIEW v_catalogo_carreras AS
SELECT f.facultad_id, f.nombre AS facultad,
       e.escuela_id, e.nombre AS escuela,
       c.carrera_id, c.nombre AS carrera, c.nivel,
       c.proyectada, c.observacion
FROM facultad f
JOIN escuela e ON e.facultad_id = f.facultad_id
JOIN carrera c ON c.escuela_id = e.escuela_id;

-- Consultas de ejemplo:
-- Escuelas disponibles:
-- SELECT escuela_id, nombre FROM escuela WHERE facultad_id = ? ORDER BY nombre;
-- Carreras de una escuela:
-- SELECT carrera, nivel, proyectada FROM v_catalogo_carreras
-- WHERE escuela_id = ? ORDER BY carrera;
-- Carreras por facultad/área (p. ej. negocios = Ciencias Económicas y Sociales):
-- SELECT escuela, carrera, nivel, proyectada FROM v_catalogo_carreras
-- WHERE facultad_id = ? ORDER BY escuela, carrera;

SELECT TABLE_SCHEMA, TABLE_NAME
FROM information_schema.tables
WHERE TABLE_NAME IN ('facultad', 'escuela', 'carrera', 'v_catalogo_carreras')
ORDER BY TABLE_SCHEMA, TABLE_NAME;