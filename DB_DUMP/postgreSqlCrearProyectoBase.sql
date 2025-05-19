CREATE SCHEMA esquema_prueba_spring_boot;

CREATE TABLE esquema_prueba_spring_boot.persona
(
	idPersona integer NOT NULL,
	nombre character varying(40) NOT NULL,
	primerApellido character varying(40) NOT NULL,
	segundoApellido character varying(40),
	PRIMARY KEY (idPersona)
)
WITH (
	OIDS = FALSE
);

CREATE TABLE esquema_prueba_spring_boot.usuarios
(
	id integer NOT NULL,	
	usuario character varying(100) NOT NULL,
	contra character varying(200) NOT NULL,
        createdAt timestamp(0) without time zone DEFAULT now(),
        updatedAt timestamp(0) without time zone,
	PRIMARY KEY (id),
	unique (usuario)
)
WITH (
	OIDS = FALSE
);

CREATE TABLE esquema_prueba_spring_boot.roles
(
	idRol integer NOT NULL,
	rol character varying(30) NOT NULL,
	descripcion character varying(90) NOT NULL,
	PRIMARY KEY (idRol)
)
WITH (
	OIDS = FALSE
);

CREATE TABLE esquema_prueba_spring_boot.usu_rol
(
	id integer NOT NULL,
	idRol integer NOT NULL,
	PRIMARY KEY (id, idRol),
	FOREIGN KEY (id)
		REFERENCES esquema_prueba_spring_boot.usuarios (id) MATCH SIMPLE
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (idRol)
		REFERENCES esquema_prueba_spring_boot.roles (idRol) MATCH SIMPLE
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
)
WITH (
	OIDS = FALSE
);


CREATE SEQUENCE esquema_prueba_spring_boot.SEQ_PERSONAS START WITH 1 INCREMENT BY 1 ;

insert into esquema_prueba_spring_boot.roles (idRol, rol, descripcion) values (1, 'USER', 'USUARIO AUTENTICADO');

insert into esquema_prueba_spring_boot.usuarios (id, usuario, contra) values (1, 'edrel', '$2a$10$soXe/Ux2EZW/IwQEiDVjKuZArJsvt4o9MP/7WAHompkLOZp/GfqaO');
insert into esquema_prueba_spring_boot.usuarios (id, usuario, contra) values (2, 'luis', '$2a$10$soXe/Ux2EZW/IwQEiDVjKuZArJsvt4o9MP/7WAHompkLOZp/GfqaO');

insert into esquema_prueba_spring_boot.usu_rol (id, idRol) values (1, 1);
insert into esquema_prueba_spring_boot.usu_rol (id, idRol) values (2, 1);

commit;
