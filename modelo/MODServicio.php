<?php

/**
*@package PXP
*@file gen-ACTServicio.php
*@author  (admin)
*@date 29-06-2021 02:21:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class MODServicio extends MODbase{
  
  function __construct(CTParametro $pParam){
    parent::__construct($pParam);
  }
      
  function insertarServicio(){
    //Definicion de variables para ejecucion del procedimiento
    $this->procedimiento='cam.f_servicio_ime';
    $this->transaccion='CAM_SERV_INS';
    $this->tipo_procedimiento='IME';
        
    //Define los parametros para la funcion
    $this->setParametro('compra','compra','numeric');
    $this->setParametro('venta','venta','numeric');
    $this->setParametro('nombre','nombre','varchar');
    $this->setParametro('fecha','fecha','date');

    //Ejecuta la instruccion
    $this->armarConsulta();
    $this->ejecutarConsulta();

    //Devuelve la respuesta
    return $this->respuesta;
  }
      
      
}

