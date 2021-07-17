CREATE
OR REPLACE FUNCTION cam.f_servicio_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
) RETURNS varchar AS $ body $
/**************************************************************************
 SISTEMA:		Sistema de Activos Corani
 FUNCION: 		cam.f_servicio_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'afc.tgrupo_activo'
 AUTOR: 		 (admin)
 FECHA:	        09-10-2019 22:26:27
 COMENTARIOS:	
 ***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 #ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-10-2019 22:26:27								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'afc.tgrupo_activo'	
 #
 ***************************************************************************/
DECLARE v_nro_requerimiento integer;

v_parametros record;

v_id_requerimiento integer;

v_resp varchar;

v_nombre_funcion text;

v_mensaje_error text;

v_id_tipo_cambio integer;

BEGIN v_nombre_funcion = 'cam.f_servicio_ime';

v_parametros = pxp.f_get_record(p_tabla);

/*********************************    
 #TRANSACCION:  'AFC_GRUA_INS'
 #DESCRIPCION:	Insercion de registros
 #AUTOR:		admin	
 #FECHA:		09-10-2019 22:26:27
 ***********************************/
if(p_transaccion = 'CAM_SERV_INS') then begin --Sentencia de la insercion
INSERT INTO
  cam.ttipo_cambio (
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    fecha,
    oficial,
    compra,
    venta
  )
VALUES
  (
    p_id_usuario,
    null,
    now(),
    null,
    'activo',
    v_parametros._id_usuario_ai,
    v_parametros._nombre_usuario_ai,
    v_parametros.fecha,
    v_parametros.oficial,
    v_parametros.compra,
    v_parametros.venta,
  );

RETURNING id_tipo_cambio into v_id_tipo_cambio;

--Definicion de la respuesta
v_resp = pxp.f_agrega_clave(
  v_resp,
  'mensaje',
  'Tipo moneda almacenado(a) con exito (id_tipo_cambio' || v_id_tipo_cambio || ')'
);

v_resp = pxp.f_agrega_clave(
  v_resp,
  'id_tipo_cambio',
  v_id_tipo_cambio :: varchar
);

--Devuelve la respuesta
return v_resp;

end;

/*********************************    
 #TRANSACCION:  'AFC_GRUA_ELI'
 #DESCRIPCION:	Eliminacion de registros
 #AUTOR:		admin	
 #FECHA:		09-10-2019 22:26:27
 ***********************************/
elsif(p_transaccion = 'AFC_GRUA_ELI') then begin --Sentencia de la eliminacion
delete from
  afc.tgrupo_activo
where
  id_grupo_activo = v_parametros.id_grupo_activo;

--Definicion de la respuesta
v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'GRUA eliminado(a)');

v_resp = pxp.f_agrega_clave(
  v_resp,
  'id_grupo_activo',
  v_parametros.id_grupo_activo :: varchar
);

--Devuelve la respuesta
return v_resp;

end;

else raise exception 'Transaccion inexistente: %',
p_transaccion;

end if;

EXCEPTION
WHEN OTHERS THEN v_resp = '';

v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);

v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);

v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);

raise exception '%',
v_resp;

END;

$ body $ LANGUAGE 'plpgsql' VOLATILE CALLED ON NULL INPUT SECURITY INVOKER COST 100;