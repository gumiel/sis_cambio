/***********************************I-SCP-HPG-CAM-0-18/07/2021****************************************/
CREATE TABLE cam.ttipo_cambio (
  id_tipo_cambio SERIAL,
  id_moneda INTEGER NOT NULL,
  fecha DATE DEFAULT now() NOT NULL,
  oficial NUMERIC(18,6) NOT NULL,
  compra NUMERIC(18,6) NOT NULL,
  venta NUMERIC(18,6) NOT NULL,
  observaciones VARCHAR(200),
  CONSTRAINT ttipo_cambio_pkey PRIMARY KEY(id_tipo_cambio)
) INHERITS (pxp.tbase)
WITH (oids = false);
/***********************************F-SCP-HPG-CAM-0-18/07/2021****************************************/

/***********************************I-SCP-HPG-CAM-1-18/07/2021****************************************/
CREATE TABLE param.tmoneda (
  id_moneda SERIAL,
  moneda VARCHAR(300),
  codigo VARCHAR(5),
  prioridad INTEGER,
  codigo_internacional VARCHAR(4),
  CONSTRAINT tmoneda_pkey PRIMARY KEY(id_moneda)
) INHERITS (pxp.tbase)
WITH (oids = false);
/***********************************F-SCP-HPG-CAM-1-18/07/2021****************************************/