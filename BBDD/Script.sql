-- Tabla Cliente
CREATE TABLE Cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    direccion VARCHAR(255),
    notas_adicionales TEXT
);

-- Tabla Contrario
CREATE TABLE Contrario (
    id SERIAL PRIMARY KEY,
    denominacion VARCHAR(100) NOT NULL,
    CIF VARCHAR(20) NOT NULL,
    direccion VARCHAR(255)
);

-- Tabla Juzgado
CREATE TABLE Juzgado (
    id SERIAL PRIMARY KEY,
    denominacion VARCHAR(100) NOT NULL,
    direccion VARCHAR(255)
);

-- Tabla Procurador
CREATE TABLE Procurador (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    numero_colegiado VARCHAR(50),
    colegio_profesional VARCHAR(100)
);

-- Tabla Expediente
CREATE TABLE Expediente (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    contrario_id INT NOT NULL,
    estado VARCHAR(50),
    juzgado_id INT,
    numero_autos VARCHAR(50),
    procurador_id INT,
    notas TEXT,
    CONSTRAINT fk_expediente_cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    CONSTRAINT fk_expediente_contrario FOREIGN KEY (contrario_id) REFERENCES Contrario(id),
    CONSTRAINT fk_expediente_juzgado FOREIGN KEY (juzgado_id) REFERENCES Juzgado(id),
    CONSTRAINT fk_expediente_procurador FOREIGN KEY (procurador_id) REFERENCES Procurador(id)
);

-- Tabla Costas
CREATE TABLE Costas (
    id SERIAL PRIMARY KEY,
    expediente_id INT NOT NULL,
    estado_costas VARCHAR(50),  -- Ej.: No firmes, Firmes, Impugnadas, En recurso de revisión, Cobradas
    fecha_tasacion DATE,
    fecha_15_dias DATE,         -- Plazo para solicitar firmeza
    fecha_decreto DATE,         -- Fecha en que se recibe el decreto de firmeza
    fecha_decreto_25 DATE,      -- Fecha de "fecha_decreto" más 25 días, para solicitar ejecución
    tipo_procedimiento VARCHAR(50),  -- Ordinario, Verbal, Impugnación, Apelación
    importe_letrada NUMERIC(10,2),
    color VARCHAR(20),          -- Indicador visual: Rojo, Amarillo, Verde
    CONSTRAINT fk_costas_expediente FOREIGN KEY (expediente_id) REFERENCES Expediente(id)
);

-- Tabla Documento
CREATE TABLE Documento (
    id SERIAL PRIMARY KEY,
    expediente_id INT NOT NULL,
    nombre_archivo VARCHAR(255),
    ruta_archivo VARCHAR(255),
    tipo_archivo VARCHAR(50),
    CONSTRAINT fk_documento_expediente FOREIGN KEY (expediente_id) REFERENCES Expediente(id)
);

-- Tabla Usuario
CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    contraseña_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL  -- Ej.: Administrador, Gestor
);

